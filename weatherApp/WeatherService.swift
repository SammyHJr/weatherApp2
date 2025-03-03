//
//  weatherService.swift
//  weatherApp
//
//  Created by Sam Hengami on 2025-02-05.
//
// original url testing for the basic UI to work
// URL : https://api.open-meteo.com/v1/forecast?latitude=13.52&longitude=100.41&current=temperature_2m,weather_code&hourly=temperature_2m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto

//The url for the mutable url when using CoreLocation to update the locations
//https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,weather_code&hourly=temperature_2m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto


import Foundation
import SwiftUICore
import CoreLocation

class WeatherService: ObservableObject {
    @State private var locationService = LocationManager()
    @Published var weather: WeatherModel?
    
    init() {
        locationService.requestLocation()
    }
    
    //takes in 2 parameters latitude and the longitude
    // couldnt get garrits link to work https://chatgpt.com/share/67a5ddf6-5cb4-8011-ba2e-3f16ad7a684c
    func fetchWeather (latitude: Double, longitude: Double) async {

        let urlString = "https://api.open-meteo.com/v1/forecast?latitude=\(latitude)&longitude=\(longitude)&current=temperature_2m,weather_code&hourly=temperature_2m&daily=weather_code,temperature_2m_max,temperature_2m_min&timezone=auto"
        
        
        guard let url = URL(string: urlString) else {
            print("Couldnt fetch URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching weather data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.weather = decodedData
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
 
// not written extensively just the overarching of the cases. will be shown in the box1view and 7dayView
func weatherDescriptionImages (for code: Int) -> Image{
    switch code {
    case 0 :
        return Image(systemName: "sun.max.fill") //"Clear sky"
    case 1, 2, 3:
        return Image(systemName: "cloud.fill") //"Partly cloudy"
    case 45, 48:
        return Image(systemName: "cloud.fog") // "Fog"
    case 51, 52 ,55:
        return Image(systemName: "cloud.drizzle.fill") //"Drizzle"
    case  56, 57:
        return Image(systemName: "cloud.snow") //"Freeze Drizzle"
    case 61, 63,65:
        return Image(systemName: "cloud.rain.fill") //"Rain"
    case 71, 73, 75:
        return Image(systemName: "cloud.snow.fill") //"Snow Fall"
    case 77:
        return Image(systemName: "snowflake") //"Snow Grain"
    case 80, 81, 82:
        return Image(systemName: "cloud.rain.circle.fill") //"Rain Showers"
    case 85, 86:
        return Image(systemName: "cloud.snow.circle.fill") //"Snow Showers"
    case 95:
        return Image(systemName: "cloud.bolt.fill") //"Thunderstorm"
    case 96, 99:
        return Image(systemName: "cloud.bolt.rain.fill") //"ThunderRain with hail"
        
    default:
        return Image(systemName: "exclamationmark.warninglight") // error symbol
    }
}

// this will be displayed in the box1View in the first text
func weatherDescriptionText(for code: Int) -> String{
    
    switch code {
    case 0 :
        return "Clear sky"
    case 1, 2, 3:
        return "Partly cloudy"
    case 45, 48:
        return "Fog"
    case 51, 52 ,55:
        return  "Drizzle"
    case  56, 57:
        return "Freeze Drizzle"
    case 61, 63,65:
        return "Rain"
    case 71, 73, 75:
        return "Snow Fall"
    case 77:
        return "Snow Grain"
    case 80, 81, 82:
        return "Rain Showers"
    case 85, 86:
        return "Snow Showers"
    case 95:
        return "Thunderstorm"
    case 96, 99:
        return "ThunderRain with hail"
        
    default:
        return  "error"
    }
}
