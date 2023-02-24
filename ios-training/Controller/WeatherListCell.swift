//
//  WeatherListCell.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/22.
//

import UIKit
import YumemiWeather

class WeatherListCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func receiveWeather(result: Result<[Response], YumemiWeatherError>) {
        switch result {
        case .success(let response):
            self.weatherImageView.image = UIImage(named: response[0].info.weatherCondition.rawValue)
            
            switch response[0].info.weatherCondition {
            case .sunny:
                self.weatherImageView.tintColor = .red
            case .cloudy:
                self.weatherImageView.tintColor = .gray
            case .rainy:
                self.weatherImageView.tintColor = .blue
            }
            
            self.cityName.text = String(response[0].area)
            
            self.minTemperature.text = String(response[0].info.minTemperature)
            self.maxTemperature.text = String(response[0].info.maxTemperature)
            
        case .failure:
            return
        }
    }

}
