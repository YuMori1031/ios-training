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
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            self?.weatherModel.fetchWeather()
        }
    }
    
    deinit {
        print("deinit ViewController")
    }

    @IBAction func reloadButton(_ sender: UIButton) {
        weatherModel.fetchWeather()
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension ViewController: WeatherDelegate {
    func loadWeather(_ result: Result<Response, YumemiWeatherError>) {
        DispatchQueue.main.async {
            switch result {
            case .success(let response):
                self.weatherImageView.image = UIImage(named: response.weatherCondition.rawValue)
                
                switch response.weatherCondition {
                case .sunny:
                    self.weatherImageView.tintColor = .red
                case .cloudy:
                    self.weatherImageView.tintColor = .gray
                case .rainy:
                    self.weatherImageView.tintColor = .blue
                }
                
                self.minTemperature.text = String(response.minTemperature)
                self.maxTemperature.text = String(response.maxTemperature)
                
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
                self.present(alert, animated: true)
            }
        }
    }
}
