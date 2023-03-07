//
//  WeatherDetailViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/23.
//

import UIKit
import YumemiWeather

class WeatherDetailViewController: UIViewController {

    var weatherModel = WeatherModel()
    var weatherList: Response!
    var cityName: String!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = weatherList.area
        
        // Large Title
        /*
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        */
        
        weatherImageView.image = UIImage(named: weatherList.info.weatherCondition.rawValue)
        switch weatherList.info.weatherCondition {
        case .sunny:
            weatherImageView.tintColor = .red
        case .cloudy:
            weatherImageView.tintColor = .gray
        case .rainy:
            weatherImageView.tintColor = .blue
        }
        
        minTemperature.text = String(weatherList.info.minTemperature)
        maxTemperature.text = String(weatherList.info.maxTemperature)
    }
    
    deinit {
        print("deinit ViewController")
    }

}
