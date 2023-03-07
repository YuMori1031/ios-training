//
//  Request.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/09.
//

import Foundation

struct Request: Encodable {
    let areas: [String]
    let date: Date
}
