//
//  WeatherListViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/22.
//

import UIKit
import YumemiWeather

class WeatherListViewController: UIViewController {
    
    var weatherModel = WeatherModel()
    var indicator = UIActivityIndicatorView()
    
    let loadingView = UIView(frame: UIScreen.main.bounds)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showIndicator()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "WeatherListCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
    }
    
    @objc private func onRefresh(_ sender: AnyObject) {
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    private func receiveError(result: Result<[Response], YumemiWeatherError>) {
        switch result {
        case .success:
            return
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
    
    private func showIndicator() {
        indicator.center = view.center
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        loadingView.addSubview(indicator)
    }
    
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WeatherListCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherListCell
        view.addSubview(loadingView)
        indicator.startAnimating()
        weatherModel.fetchWeather { result in
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.loadingView.removeFromSuperview()
                self.receiveError(result: result)
                cell.receiveWeather(result: result)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セル選択時に詳細画面に遷移するコードを記述予定
    }
}
