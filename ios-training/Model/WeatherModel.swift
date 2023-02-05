//
//  WeatherModel.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/31.
//

import Foundation
import YumemiWeather

class WeatherModel {
    weak var delegate: WeatherDelegate? = nil
    
    func fetchWeather() async {
        guard let weatherDelegate = self.delegate else { return }
        let result = Result { try YumemiWeather.fetchWeatherCondition(at: "tokyo") }
            .mapError { $0 as! YumemiWeatherError }
        weatherDelegate.loadWeather(result)
    }
}
