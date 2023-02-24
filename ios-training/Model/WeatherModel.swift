//
//  WeatherModel.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/31.
//

import Foundation
import YumemiWeather

class WeatherModel {
    func fetchWeather(completion: ((Result<[Response], YumemiWeatherError>) -> Void)?) {
        let request = Request(areas: ["tokyo"], date: Date())
        
        guard let test1 = try? jsonEncode(from: request) else { return }
        print(test1)
        
        let jsonString: String = """
{
    "area": ["tokyo"],
    "date": "2020-04-01T12:00:00+09:00"
}
"""
        
        do {
            let test2 = try YumemiWeather.syncFetchWeatherList(jsonString)
            
            print(test2)
        } catch  {
            print(error)
        }
        
        
        DispatchQueue.global().async {
            let response = Result { try self.jsonDecode(from: YumemiWeather.syncFetchWeatherList(self.jsonEncode(from: request))) }.mapError { $0 as! YumemiWeatherError }
            if let completion = completion {
                completion(response)
            }
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
    
    private func jsonDecode(from responseJson: String) throws -> [Response] {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(df)
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let responseData = responseJson.data(using: .utf8) else { throw YumemiWeatherError.invalidParameterError }
        
        return try decoder.decode([Response].self, from: responseData)
    }
}
