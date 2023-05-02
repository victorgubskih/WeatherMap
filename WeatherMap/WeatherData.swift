//
//  WeatherData.swift
//  WeatherMap
//
//  Created by viktor on 02.05.2023.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let generationtime_ms: Double
    let utc_offset_seconds: Int
    let timezone: String
    let timezone_abbreviation: String
    let elevation: Double
    let current_weather: CurrentWeather
    struct CurrentWeather: Codable {
        let temperature: Double
        let windspeed: Double
        let winddirection: Double
        let weathercode: Int
        let is_day: Int
        let time: String
    }
    
        
    let hourly_units: HourlyUunits
    struct HourlyUunits: Codable {
        let time: String
        let temperature_2m: String
        let rain: String
        let snowfall: String
        let surface_pressure: String
    }
    
    let hourly: Hourly
    struct Hourly: Codable {
        let time: [String]
        let temperature_2m: [Double]
        let rain: [Double]
        let snowfall: [Double]
        let surface_pressure: [Double]
        
    }
    let daily_units: DailyUnits
    struct DailyUnits: Codable {
        let time: String
        let temperature_2m_max: String
        let temperature_2m_min: String
        let sunrise: String
        let sunset: String
    }
        
        
        let daily: Deily
   
    struct Deily: Codable {
        let time: [String]
        let temperature_2m_max: [Double]
           
        let temperature_2m_min: [Double]
            
        let sunrise: [String]
           
        let sunset: [String]
    }
    
}
