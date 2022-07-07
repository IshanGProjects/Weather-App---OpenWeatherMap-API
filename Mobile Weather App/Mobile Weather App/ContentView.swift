//
//  ContentView.swift
//  Mobile Weather App
//
//  Created by Stewart Lynch on 2021-01-18.
//

import SDWebImageSwiftUI
import SwiftUI

@available(iOS 15.0, *)
struct ContentView: View {
    @StateObject private var  forecastListVM = ForecastListViewModel()
    @State var isPopoverShowing = false
    var body: some View {
        ZStack {
        NavigationView {
            VStack(alignment: .center) {
                
                Picker(selection: $forecastListVM.system, label: Text("System")) {
                    Text("ºC").tag(0)
                    Text("ºF").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 100)
                .padding(.vertical)
                HStack {
                    TextField("Enter Location", text: $forecastListVM.location, onCommit: {
                        forecastListVM.getWeatherForecast()
                    })
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(
                            Button(action: {
                                forecastListVM.location = ""
                                forecastListVM.getWeatherForecast()
                            }){
                                Image(systemName: "xmark.circle")
                                    .foregroundColor(.gray)
                                    
                            }
                            .padding(.horizontal),
                            alignment: .trailing
                        )
                    Button {
                        forecastListVM.getWeatherForecast()
                    } label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .font(.title3)
                    }
                }
                List(forecastListVM.forecasts, id: \.day) { day in
                    HStack {
                        WebImage(url: day.weatherIconURL)
                            .resizable()
                            .placeholder {
                                Image(systemName: "photo.circle")
                            }
                            .scaledToFit()
                            .frame(width: 65)
                        Text(day.avg)
                        
                        Text(day.day)
                            .fontWeight(.bold)
                            .frame(width: 135, height: 20, alignment: .center)
                        
                        Button(action: {
                            isPopoverShowing = true
                        }) {
                            Label("", systemImage: "chevron.right")
                            .offset(x: 20, y: 0)                            }
                        .sheet(isPresented: $isPopoverShowing) {
                            VStack {
                                Text(day.overview)
                                    .font(.title)
                                    .padding()
                                HStack(alignment: .center) {
                                    Text(day.high)
                                        .font(.largeTitle)
                                      
                                        .padding()
                                    Text(day.low)
                                        .font(.largeTitle)
                                       
                                        .padding()
                                }
                                Text(day.pop)
                                    .font(.title)
                                    .padding()
                                Text(day.clouds)
                                    .font(.title)
                                    .padding()
                                Text(day.humidity)
                                    .font(.title)
                                    .padding()
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle("Weather App")
            .alert(item: $forecastListVM.appError) { appAlert in
                Alert(title: Text("Error"),
                      message: Text("""
                        \(appAlert.errorString)
                        Please try again later!
                        """
                        )
                )
                    
            }
            if forecastListVM.isLoading {
                ZStack {
                    Color.white
                        .opacity(0.3)
                    .ignoresSafeArea()
                    ProgressView("Fetching Weather")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground)))
                        .shadow(radius: 10)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}
}
