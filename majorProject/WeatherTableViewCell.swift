//
//  WeatherTableViewCell.swift
//  majorProject
//
//  Created by Sriteja Chilakamarri on 21/02/17.
//  Copyright © 2017 Sriteja Chilakamarri. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var iconLabel: UILabel!
    
    
    
    
}
