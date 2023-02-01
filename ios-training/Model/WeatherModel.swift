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
        guard let result = try? YumemiWeather.fetchWeatherCondition(at: "tokyo") else { return }
        weatherDelegate.loadWeather(result)
    }
}
