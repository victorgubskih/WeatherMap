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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
}
