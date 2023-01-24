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
        // Do any additional setup after loading the view.
    }

    @IBAction func reloadButton(_ sender: UIButton) {
        do {
            guard let result = try? YumemiWeather.fetchWeatherCondition(at: "tokyo") else { return }
            
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

