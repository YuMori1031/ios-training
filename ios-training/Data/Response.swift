//
//  Response.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/09.
//

import Foundation

struct Response: Decodable {
    let maxTemperature: Int
    let minTemperature: Int
    let date: Date
    let weatherCondition: Weather
}
