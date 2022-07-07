//
//  ForecastViewModel.swift
//  Mobile Weather App
//
//  Created by Ishan Gohil on 5/20/22.
//

import Foundation

/*Following the  MVVM (Model-View-ViewModel) Design pattern we need to seperate backEnd elements with
front end elements
 */

struct ForecastViewModel {
    let forecast: Forecast.Daily
    var system: Int
    
    //Creation a computed property to format the date
    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E, MMM, d"
        return dateFormatter
    }
    
    //similar to how I created a date formatter I need to create a number formatter for Temps
    private static var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter
    }
    
    //I need to create a number formatter for manipulating data to get percentages for precipatation
    private static var numberFormatter2: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .percent
        return numberFormatter
    }
    
    //Function to convert the unit of temp
    func convert (_ temp: Double) -> Double {
        let celsius = temp - 273.5
        if system == 0 {
            return celsius
        } else {
            return celsius * 9 / 5 + 32
        }
    }
    
    var day: String {
        return Self.dateFormatter.string(from: forecast.dt)
    }
    
    //Creating computed property for description of the weather with capetlization
    var overview: String {
        forecast.weather[0].description.capitalized
    }
    
    //Computed proerty for high as a string
    var high: String {
        return "High: \(Self.numberFormatter.string(for: convert(forecast.temp.max)) ?? "0")º"
    }
    
    //Computed proerty for low as a string
    var low: String {
        return "Low: \(Self.numberFormatter.string(for: convert(forecast.temp.min)) ?? "0")º"
    }
    
    //Computed Property for avg tem
    var avg: String {
        return "\(Self.numberFormatter.string(for: convert(((forecast.temp.min + forecast.temp.max)/2))) ?? "0")º"
    }
    
    //Computed property of pop
    var pop: String {
        return "💧 \(Self.numberFormatter2.string(for: forecast.pop) ?? "0%")"
    }
    
    //Computed property for cloudiness
    var clouds: String {
        return "☁️ \(forecast.clouds)%"
    }
    
    //Computed property for humidity
    var humidity: String {
        return "Humidity: \(forecast.humidity)%"
    }
    
    //Image
    var weatherIconURL: URL {
        let urlString = "https://openweathermap.org/img/wn/\(forecast.weather[0].icon)@2x.png"
        return URL(string: urlString)!
    }
    
}
