//
//  ContentView.swift
//  WeatherUpdate
//
//  Created by Ankita Jaiswal on 15/06/24.
//

import SwiftUI
import CoreLocationUI

struct ContentView: View {
    
    
    @StateObject var locationManager = LocationManager()
    
    var weatherManager = WeatherManager()
    @State var weather: WeatherData?
    
    var body: some View {
        VStack {
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherDisplayView(weather: weather)
                } else {
                    LoadingView()
                        .task {
                            do {
                                weather = try await weatherManager.fetchWeatherData(latitude: location.latitude, longitude: location.longitude)
                            } catch {
                                print("Error getting weather updates:\(error)")
                            }
                            
                        }
                }
            } else {
                if locationManager.isLoading {
                    LoadingView()
                } else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
            
        }
        .background(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
