//
//  CurrentForecastTableViewCell.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class CurrentForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var chanceOfRainLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var precipitationLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var uvLabel: UILabel!
    
    var forecast: ForecastViewModel? {
        didSet {
            sunriseLabel.text = forecast!.sunriseTime
            sunsetLabel.text = forecast!.sunsetTime
            chanceOfRainLabel.text = forecast!.chanceOfRain
            humidityLabel.text = forecast!.humidity
            windLabel.text = forecast!.wind
            feelsLikeLabel.text = forecast!.feelsLikeTemperature
            precipitationLabel.text = forecast!.precipitation
            pressureLabel.text = forecast!.pressure
            visibilityLabel.text = forecast!.visibility
            uvLabel.text = forecast!.uvIndex
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
