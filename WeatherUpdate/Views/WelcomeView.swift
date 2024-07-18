//
//  WelcomeView.swift
//  WeatherUpdate
//
//  Created by Ankita Jaiswal on 15/06/24.
//

import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    
    @EnvironmentObject var locationManager: LocationManager
    
    var body: some View {
        ZStack{
            Image(.background)
                .resizable()
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack(spacing: 20){
                 Text("Welcome to the Weather App")
                     .font(.largeTitle)
                     .foregroundStyle(.white)
                     .bold()
                     .italic()
                 Text("Please enter the location to get the weather update")
                     .font(.headline)
                     .foregroundStyle(.white)
             }.multilineTextAlignment(.center)
                 .padding()
           
                
                LocationButton(.shareCurrentLocation) {
                    locationManager.requestLocation()
                }
                .cornerRadius(30)
                .symbolVariant(.fill)
                .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
     
    }
}
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
