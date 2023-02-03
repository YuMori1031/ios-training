//
//  ViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/23.
//

import UIKit
import YumemiWeather

protocol WeatherDelegate: AnyObject {
    func loadWeather(_ result: String)
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
    func loadWeather(_ result: String) {
        Task {
            switch result {
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
        }
    }
}
