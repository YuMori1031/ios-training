//
//  WeatherListViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/22.
//

import UIKit

class WeatherListViewController: UIViewController {
    
    var weatherModel = WeatherModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeatherListCell", bundle: nil), forCellReuseIdentifier: "Cell")
    }
    
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherListCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherListCell
        weatherModel.fetchWeather { result in
            DispatchQueue.main.async {
                //cell.receiveWeather(result: result)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

extension WeatherListViewController: UITableViewDelegate {
    
}
