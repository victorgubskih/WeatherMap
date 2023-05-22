import Foundation
import UIKit

class BackgroundProvider {
    enum Constants {
        static let midnightColor = UIColor(named: "midnight")!
        static let middaytColor = UIColor(named: "midday")!
        static let sunsetColor = UIColor(named: "sunset_color")!
        static let sunriseColor = UIColor(named: "sunrise_color")!
    }
    
    func background(for hour: WeatherModel.Hourly, at day: WeatherModel.Daily) -> UIColor {
        let midday = Date(timeIntervalSince1970: (day.sunrise.timeIntervalSince1970 + day.sunset.timeIntervalSince1970) / 2)
        let midnight = Date(timeIntervalSince1970: midday.timeIntervalSince1970 - (day.sunset.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970))
        let nextMidNight =  Date(timeIntervalSince1970: midday.timeIntervalSince1970 + (day.sunset.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970))
        
        if (midnight...day.sunrise).contains(hour.time) {
            let halfNight = day.sunrise.timeIntervalSince1970 - midnight.timeIntervalSince1970
            let passMidnight = hour.time.timeIntervalSince1970 -  midnight.timeIntervalSince1970
            let proportion = CGFloat(passMidnight / halfNight)
            return Constants.midnightColor.gradient(to: Constants.sunriseColor, proportion: proportion)
        }
        
        if (day.sunrise...midday).contains(hour.time) {
            let halfDay = midday.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970
            let passSunrise = hour.time.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970
            let proportion = CGFloat(passSunrise / halfDay)
            return Constants.sunriseColor.gradient(to: Constants.middaytColor, proportion: proportion)
        }
        
        if (midday...day.sunset).contains(hour.time) {
            let halfDay = day.sunset.timeIntervalSince1970 - midday.timeIntervalSince1970
            let passMidday = hour.time.timeIntervalSince1970 - midday.timeIntervalSince1970
            let proportion = CGFloat(passMidday / halfDay)
            return Constants.middaytColor.gradient(to: Constants.sunsetColor, proportion: proportion)
        }
        
        if (day.sunset...nextMidNight).contains(hour.time) {
            let halfNight = nextMidNight.timeIntervalSince1970 - day.sunset.timeIntervalSince1970
            let passSunset = hour.time.timeIntervalSince1970 - day.sunset.timeIntervalSince1970
            let proportion = CGFloat(passSunset / halfNight)
            return Constants.sunsetColor.gradient(to: Constants.midnightColor, proportion: proportion)
        }
        
        
        return Constants.middaytColor
    }
    
    
}
