//
//  HourTableViewCell.swift
//  WeatherMap
//
//  Created by viktor on 10.05.2023.
//

import UIKit

class HourTableViewCell: UITableViewCell {
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var rainLabel: UILabel!
    
    @IBOutlet weak var surfacePressureLabel: UILabel!
    
    var gradientLayer = CAGradientLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientLayer.frame = contentView.bounds
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.green.cgColor]
        contentView.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = contentView.bounds
    }
   
    
 
    
}
