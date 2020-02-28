//
//  DailyForecastTableViewCell.swift
//  Hows The Weather
//
//  Created by Anthony on 13/02/20.
//  Copyright © 2020 EmeraldApps. All rights reserved.
//

import UIKit

class DailyForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
 
    var forecast: DataViewModel? {
        didSet {
            highTempLabel.text = forecast!.maxTemperature
            lowTempLabel.text = forecast!.minTemperature
            icon.image = UIImage(named: forecast!.iconName)
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
