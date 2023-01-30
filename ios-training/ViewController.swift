//
//  ViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/23.
//

import UIKit
import YumemiWeather

class ViewController: UIViewController {
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func reloadButton(_ sender: UIButton) {
        Task {
            guard let result = await fetchWeather() else { return }
            
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
    
    @IBAction func closeButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func fetchWeather() async -> String? {
        let result = try? YumemiWeather.fetchWeatherCondition(at: "tokyo")
        return result
    }
    
}

