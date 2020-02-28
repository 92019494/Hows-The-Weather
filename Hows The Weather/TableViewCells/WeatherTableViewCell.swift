//
//  WeatherTableViewCell.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var forecast: ForecastViewModel? {
        didSet {
            timeLabel.text = forecast!.currentTime
            placeLabel.text = forecast!.name
            temperatureLabel.text = forecast!.temperature
            weatherIcon.image = UIImage(named: forecast!.iconName)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
