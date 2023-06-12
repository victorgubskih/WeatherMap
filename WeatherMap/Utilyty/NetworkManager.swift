//
//  NetworkManager.swift
//  WeatherMap
//
//  Created by viktor on 01.05.2023.
//

import Foundation
struct NetworkManager {
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    func obtainWeather(completion: @escaping(WeatherData) -> Void) {
        guard let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=49.715&longitude=35.577295518227245&hourly=temperature_2m,rain,snowfall,surface_pressure&daily=temperature_2m_max,temperature_2m_min,sunrise,sunset&current_weather=true&past_days=1&forecast_days=3&timezone=GMT") else {
            return
        }
        
        session.dataTask(with: url) { (data, response, error) in
            if error == nil, let parsData = data {
                guard let weatherData = try? decoder.decode(WeatherData.self, from: parsData) else {
                    return
                }
               
                completion(weatherData)
            } else {
                print("Error: \(error?.localizedDescription)")
            }
        }.resume()
    }
}
