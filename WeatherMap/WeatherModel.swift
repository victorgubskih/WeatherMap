import Foundation

struct WeatherModel {
    struct Daily {
        let time: Date
        let maxTemperature: String
        let minTemperature: String
        let sunrise: Date
        let sunset: Date
        let hourly: [Hourly]
    }
    
    struct Hourly {
        let time: Date
        let temperature: String
        let rain: String
        let surfacePressure: String
    }
    
    let latitude: Double
    let longitude: Double
    let elevation: Double
    let temperature: String
    let weathercode: Int
    let isDay: Bool
    let time: Date
    let daily: [Daily]
    
    init?(data: WeatherData) {
        guard data.daily.time.count == data.daily.temperature_2m_max.count,
                data.daily.time.count == data.daily.temperature_2m_min.count,
              data.daily.time.count == data.daily.sunrise.count,
              data.daily.time.count == data.daily.sunset.count else {
                  return nil
        }
        guard data.hourly.time.count == data.hourly.temperature_2m.count,
              data.hourly.time.count == data.hourly.rain.count,
              data.hourly.time.count == data.hourly.surface_pressure.count else {
                  return nil
        }
        guard data.daily_units.time == "iso8601",
              data.daily_units.sunset == "iso8601",
              data.daily_units.sunrise == "iso8601",
              data.hourly_units.time == "iso8601" else {
                  return nil
        }
        
       
        
        self.longitude = data.longitude
        self.latitude = data.latitude
        self.elevation = data.elevation
        
        let dailyTemperatureUnitMax = data.daily_units.temperature_2m_max
        let dailyTemperatureUnitMin = data.daily_units.temperature_2m_min
        let hourlyTemperatureUnit = data.hourly_units.temperature_2m
        
        let fullDateFormater = DateFormatter()
        fullDateFormater.dateFormat = "YYYY-MM-dd'T'HH:mm"
        fullDateFormater.timeZone = TimeZone(identifier: data.timezone)
        
        let dayDateFormater = DateFormatter()
        dayDateFormater.dateFormat = "YYYY-MM-dd"
        dayDateFormater.timeZone = TimeZone(identifier: data.timezone)
        
        self.temperature = "\(data.current_weather.temperature) " + hourlyTemperatureUnit
        self.weathercode = data.current_weather.weathercode
        self.isDay = data.current_weather.is_day == 1
        self.time = fullDateFormater.date(from: data.current_weather.time) ?? Date()
        
        var daily = [Daily]()
        for i in 0..<data.daily.time.count {
            if let time = dayDateFormater.date(from: data.daily.time[i]),
               let sunrise = fullDateFormater.date(from: data.daily.sunrise[i]),
               let sunset = fullDateFormater.date(from: data.daily.sunset[i]) {
               let hourly = hourlyModel(from: data, for: time)
               if hourly.isEmpty {
                    continue
               }
               let day = Daily(
                    time: time,
                    maxTemperature: "\(data.daily.temperature_2m_max[i]) " + dailyTemperatureUnitMax,
                    minTemperature: "\(data.daily.temperature_2m_min[i]) " + dailyTemperatureUnitMin,
                    sunrise: sunrise,
                    sunset: sunset,
                    hourly: hourly
                )
                daily.append(day)
            }
        }
        guard !daily.isEmpty else {
            return nil
        }
        self.daily = daily
    }
}

private func hourlyModel(from data: WeatherData, for dayDate: Date) -> [WeatherModel.Hourly] {
    let hourlyTemperatureUnit = data.hourly_units.temperature_2m
    let hourlyRainUnit = data.hourly_units.rain
    let hourlyPresureUnit = data.hourly_units.surface_pressure
    
    let fullDateFormater = DateFormatter()
    fullDateFormater.dateFormat = "YYYY-MM-dd'T'HH:mm"
    fullDateFormater.timeZone = TimeZone(identifier: data.timezone)
    
    var hourly = [WeatherModel.Hourly]()
    for i in 0..<data.hourly.time.count {
        if let time = fullDateFormater.date(from: data.hourly.time[i]),
           Calendar.current.isDate(time, inSameDayAs: dayDate) {
            let hour = WeatherModel.Hourly(
                time: time,
                temperature: "\(data.hourly.temperature_2m[i]) " + hourlyTemperatureUnit,
                rain: "\(data.hourly.rain[i]) " + hourlyRainUnit,
                surfacePressure: "\(data.hourly.surface_pressure[i]) " + hourlyPresureUnit
            )
            hourly.append(hour)
        }
    }
    return hourly
}
