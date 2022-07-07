//
//  Mobile_Weather_AppApp.swift
//  Mobile Weather App
//
//  Created by Stewart Lynch on 2021-01-18.
//

import SwiftUI

@main
struct Mobile_Weather_AppApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 15.0, *) {
                ContentView()
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
