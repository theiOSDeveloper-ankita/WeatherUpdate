//
//  WeatherManager.swift
//  WeatherUpdate
//
//  Created by Ankita Jaiswal on 15/06/24.
//

import Foundation
import CoreLocation

class WeatherManager: ObservableObject{
    
    func fetchWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> WeatherData {
        let weatherAPI = self.createURLComponents(latitude: latitude, longitude: longitude)
        guard let url = weatherAPI.url
        else { fatalError("Missing URL") }
        
        
        let urlRequest = URLRequest(url: url)
        print(urlRequest)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")}
        
        let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
        print(decodedData)
        return decodedData
    }
}

private extension WeatherManager{

struct OpenWeatherAPI {
   static let scheme: String = "https"
    static let host: String = "api.openweathermap.org"
    static  let path: String = "/data/2.5/weather"
    static let key: String = "Your API KEY"
}
   
    func createURLComponents(latitude: CLLocationDegrees, longitude: CLLocationDegrees) -> URLComponents {
        var urlcomponents = URLComponents()
        urlcomponents.scheme = OpenWeatherAPI.scheme
        urlcomponents.host = OpenWeatherAPI.host
        urlcomponents.path = OpenWeatherAPI.path
        urlcomponents.queryItems = [
           URLQueryItem(name: "lat", value: "\(latitude)"),
           URLQueryItem(name: "lon", value: "\(longitude)"),
           URLQueryItem(name: "appid", value: OpenWeatherAPI.key)
        ]
   
        return urlcomponents
    }
    
}
