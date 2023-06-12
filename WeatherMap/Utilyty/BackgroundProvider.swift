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
    
    func naturalBackground(for hour: WeatherModel.Hourly, at day: WeatherModel.Daily) -> UIColor {
        let midday = Date(timeIntervalSince1970: (day.sunrise.timeIntervalSince1970 + day.sunset.timeIntervalSince1970) / 2)
        let midnight = Date(timeIntervalSince1970: midday.timeIntervalSince1970 - (day.sunset.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970))
        let nextMidNight =  Date(timeIntervalSince1970: midday.timeIntervalSince1970 + (day.sunset.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970))
        
        if (midnight...day.sunrise).contains(hour.time) {
            let halfNight = day.sunrise.timeIntervalSince1970 - midnight.timeIntervalSince1970
            let passMidnight = hour.time.timeIntervalSince1970 -  midnight.timeIntervalSince1970
            let proportion = CGFloat(passMidnight / halfNight)
            let calculator = BezierCurveCalculator(p1: CGPoint(x: 1.3, y: -0.3), p2:  CGPoint(x: 0.9, y: -0.02))
            let naturalProportion = calculator.calcultate(t: proportion).y
            
            return Constants.midnightColor.gradient(to: Constants.sunriseColor, proportion: naturalProportion)
        }
        
        if (day.sunrise...midday).contains(hour.time) {
            let halfDay = midday.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970
            let passSunrise = hour.time.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970
            let proportion = CGFloat(passSunrise / halfDay)
            let calculator = BezierCurveCalculator.easeIn
            let naturalProportion = calculator.calcultate(t: proportion).y
            return Constants.sunriseColor.gradient(to: Constants.middaytColor, proportion: naturalProportion)
        }
        
        if (midday...day.sunset).contains(hour.time) {
            let halfDay = day.sunset.timeIntervalSince1970 - midday.timeIntervalSince1970
            let passMidday = hour.time.timeIntervalSince1970 - midday.timeIntervalSince1970
            let proportion = CGFloat(passMidday / halfDay)
            let calculator = BezierCurveCalculator.easeOut
            let naturalProportion = calculator.calcultate(t: proportion).y
            return Constants.middaytColor.gradient(to: Constants.sunsetColor, proportion: naturalProportion)
        }
        
        if (day.sunset...nextMidNight).contains(hour.time) {
            let halfNight = nextMidNight.timeIntervalSince1970 - day.sunset.timeIntervalSince1970
            let passSunset = hour.time.timeIntervalSince1970 - day.sunset.timeIntervalSince1970
            let proportion = CGFloat(passSunset / halfNight)
            let calculator = BezierCurveCalculator(p1: CGPoint(x: 0.0, y: 1.3), p2: CGPoint(x: 0.0, y: 1.3))
            let naturalProportion = calculator.calcultate(t: proportion).y
            return Constants.sunsetColor.gradient(to: Constants.midnightColor, proportion: naturalProportion)
        }
        
    
        
        
        
        return Constants.middaytColor
    }
    
    func gradientColors(for hour: WeatherModel.Hourly, at day: WeatherModel.Daily) -> [CGColor] {
        let midday = Date(timeIntervalSince1970: (day.sunrise.timeIntervalSince1970 + day.sunset.timeIntervalSince1970) / 2)
        let midnight = Date(timeIntervalSince1970: midday.timeIntervalSince1970 - (day.sunset.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970))
        let nextMidNight =  Date(timeIntervalSince1970: midday.timeIntervalSince1970 + (day.sunset.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970))
        
        if (midnight...day.sunrise).contains(hour.time) {
            let halfNight = day.sunrise.timeIntervalSince1970 - midnight.timeIntervalSince1970
            let passMidnight = hour.time.timeIntervalSince1970 -  midnight.timeIntervalSince1970
            let proportion1 = CGFloat(passMidnight / halfNight)
            let proportion0 = CGFloat((passMidnight - 1 * 60 * 60) / halfNight)
            return [
                Constants.midnightColor.gradient(to: Constants.sunriseColor, proportion: proportion0).cgColor,
                Constants.midnightColor.gradient(to: Constants.sunriseColor, proportion: proportion1).cgColor
            ]
        }
        
        if (day.sunrise...midday).contains(hour.time) {
            let halfDay = midday.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970
            let passSunrise = hour.time.timeIntervalSince1970 - day.sunrise.timeIntervalSince1970
            let proportion1 = CGFloat(passSunrise / halfDay)
            let proportion0 = CGFloat((passSunrise - 1 * 60 * 60) / halfDay)
            
            return [
                Constants.sunriseColor.gradient(to: Constants.middaytColor, proportion: proportion0).cgColor,
                Constants.sunriseColor.gradient(to: Constants.middaytColor, proportion: proportion1).cgColor
            ]
        }
        
        if (midday...day.sunset).contains(hour.time) {
            let halfDay = day.sunset.timeIntervalSince1970 - midday.timeIntervalSince1970
            let passMidday = hour.time.timeIntervalSince1970 - midday.timeIntervalSince1970
            let proportion1 = CGFloat(passMidday / halfDay)
            let proportion0 = CGFloat((passMidday - 1 * 60 * 60) / halfDay)
            
            return [
                Constants.middaytColor.gradient(to: Constants.sunsetColor, proportion: proportion0).cgColor,
                Constants.middaytColor.gradient(to: Constants.sunsetColor, proportion: proportion1).cgColor
            ]
        }
        
        if (day.sunset...nextMidNight).contains(hour.time) {
            let halfNight = nextMidNight.timeIntervalSince1970 - day.sunset.timeIntervalSince1970
            let passSunset = hour.time.timeIntervalSince1970 - day.sunset.timeIntervalSince1970
            let proportion1 = CGFloat(passSunset / halfNight)
            let proportion0 = CGFloat((passSunset - 1 * 60 * 60) / halfNight)
            
            return [
                Constants.sunsetColor.gradient(to: Constants.midnightColor, proportion: proportion0).cgColor,
                Constants.sunsetColor.gradient(to: Constants.midnightColor, proportion: proportion1).cgColor
            ]
        }
        return [Constants.middaytColor.cgColor, Constants.sunsetColor.cgColor]
    }
    
    
}
