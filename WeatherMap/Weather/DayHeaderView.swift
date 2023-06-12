//
//  DayHeaderView.swift
//  WeatherMap
//
//  Created by viktor on 06.05.2023.
//

import UIKit

class DayHeaderView: UITableViewHeaderFooterView {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    @IBOutlet private var calendarImageView: UIImageView!
    @IBOutlet private(set) var calendarLabel: UILabel!
    
    @IBOutlet private var sunriseImageView: UIImageView!
    @IBOutlet private(set) var sunriseLabel: UILabel!
    
    @IBOutlet private var sunsetImageView: UIImageView!
    @IBOutlet private(set) var sunsetLabel: UILabel!
    
    @IBOutlet private var temperatureImageViewMax: UIImageView!
    @IBOutlet private(set) var temperaturelabelMax: UILabel!
    
    @IBOutlet private var temperatureImageViewMin: UIImageView!
    @IBOutlet private(set) var temperaturelabelMin: UILabel!
   
    
  
    
}








