//
//  Response.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/09.
//

import Foundation

struct Response: Decodable {
    let area: String
    let info: Info
}

struct Info: Decodable {
    var maxTemperature: Int
    var minTemperature: Int
    var date: Date
    var weatherCondition: Weather
}
