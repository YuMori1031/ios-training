//
//  WeatherModel.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/31.
//

import Foundation
import YumemiWeather

class WeatherModel {
    var delegate: WeatherDelegate? = nil
    
    func fetchWeatherAPI() {
        if let weatherDelegate = self.delegate {
            weatherDelegate.loadWeather()
        }
    }
}
