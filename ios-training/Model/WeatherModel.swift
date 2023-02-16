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
    
    func fetchWeather() {
        guard let weatherDelegate = self.delegate else { return }
        let request = Request(area: "tokyo", date: Date())
        DispatchQueue.global().async {
            let response = Result { try self.jsonDecode(from: YumemiWeather.syncFetchWeather(self.jsonEncode(from: request))) }.mapError { $0 as! YumemiWeatherError }
            weatherDelegate.loadWeather(response)
        }
    }
    
    private let df: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return df
    }()
    
    private func jsonEncode(from request: Request) throws -> String {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(df)
        let requestData = try encoder.encode(request)
        guard let requestJson = String(data: requestData, encoding: .utf8) else { throw YumemiWeatherError.invalidParameterError }
        return requestJson
    }
    
    private func jsonDecode(from responseJson: String) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(df)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let responseData = responseJson.data(using: .utf8) else { throw YumemiWeatherError.invalidParameterError }
        return try decoder.decode(Response.self, from: responseData)
    }
}
