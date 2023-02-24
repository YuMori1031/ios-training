//
//  ViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/23.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
/*
    var weatherModel = WeatherModel()
    
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTemperature: UILabel!
    @IBOutlet weak var maxTemperature: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.activityIndicator.startAnimating()
            self.weatherModel.fetchWeather { result in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.receiveWeather(result: result)
                }
            }
        }
    }
    
    deinit {
        print("deinit ViewController")
    }

    @IBAction func reloadButton(_ sender: UIButton) {
        activityIndicator.startAnimating()
        weatherModel.fetchWeather() { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.receiveWeather(result: result)
            }
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func receiveWeather(result: Result<Response, YumemiWeatherError>) {
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
  */
}
