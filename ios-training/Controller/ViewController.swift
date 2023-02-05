//
//  ViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/23.
//

import UIKit
import YumemiWeather

protocol WeatherDelegate: AnyObject {
    func loadWeather(_ result: Result<String, YumemiWeatherError>)
}

class ViewController: UIViewController {
    
    var weatherModel = WeatherModel()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
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
    func loadWeather(_ result: Result<String, YumemiWeatherError>) {
        Task {
            switch result {
            case .success(let string):
                switch string {
                case "sunny":
                    weatherImageView.image = UIImage(named: "Sunny")
                    weatherImageView.tintColor = .red
                case "cloudy":
                    weatherImageView.image = UIImage(named: "Cloudy")
                    weatherImageView.tintColor = .gray
                case "rainy":
                    weatherImageView.image = UIImage(named: "Rainy")
                    weatherImageView.tintColor = .blue
                default:
                    return
                }
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
