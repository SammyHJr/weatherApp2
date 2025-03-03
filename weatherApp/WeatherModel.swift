//
//  weatherModel.swift
//  weatherApp
//
//  Created by Sam Hengami on 2025-02-05.
//

// create the model for the weather
import Foundation

struct WeatherModel: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Double
    let current_units: CurrentUnits
    let current: Current
    let daily_units: DailyUnits
    let daily: Daily
    let hourly_units: HourlyUnits
    let hourly: Hourly
}

// Current units
struct CurrentUnits: Codable {
    let time: String
    let interval: String
    let temperature_2m: String
    let weather_code: String
}

// current weather
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature_2m: Double
    let weather_code: Int
}

// Hourly data units
struct HourlyUnits: Codable {
    let time: String
    let temperature_2m: String
}

// Hourly weather data
struct Hourly: Codable {
    let time: [String]
    let temperature_2m: [Double]
}

struct DailyUnits: Codable {
    let time: String
    let weather_code: String
    let temperature_2m_max: String
    let temperature_2m_min: String
}

// daily weather
struct Daily: Codable {
    let time: [String]
    let weather_code: [Int]
    let temperature_2m_max: [Double]
    let temperature_2m_min: [Double]
}
