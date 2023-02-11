//
//  ViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/23.
//

import UIKit
import YumemiWeather

protocol WeatherDelegate: AnyObject {
    func loadWeather(_ result: Result<Response, YumemiWeatherError>)
}

class ViewController: UIViewController {
    
    var weatherModel = WeatherModel()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherModel.delegate = self
    }
    
    deinit {
        print("deinit ViewController")
    }

    @IBAction func reloadButton(_ sender: UIButton) {
        Task { @MainActor in
            await weatherModel.fetchWeather()
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension ViewController: WeatherDelegate {
    func loadWeather(_ result: Result<Response, YumemiWeatherError>) {
        Task {
            switch result {
            case .success(let response):
                weatherImageView.image = UIImage(named: response.weatherCondition.rawValue)
                
                switch response.weatherCondition {
                case .sunny:
                    weatherImageView.tintColor = .red
                case .cloudy:
                    weatherImageView.tintColor = .gray
                case .rainy:
                    weatherImageView.tintColor = .blue
                }
                
                minTemperature.text = String(response.minTemperature)
                maxTemperature.text = String(response.maxTemperature)
                
            case .failure(let error):
                let errorMessage: String
                switch error {
                case .invalidParameterError:
                    errorMessage = "invalidParameterError"
                case .unknownError:
                    errorMessage = "unknownError"
                }
                
                let alert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
            }
        }
    }
}
