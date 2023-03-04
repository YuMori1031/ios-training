//
//  WeatherListViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/02/22.
//

import UIKit
import YumemiWeather

class WeatherListViewController: UIViewController {
    
    let cities: [String] = [
        "Sapporo", "Sendai", "Niigata", "Kanazawa", "Tokyo", "Nagoya", "Osaka", "Hiroshima", "Kochi", "Fukuoka", "Kagoshima", "Naha"
    ]
    
    var weatherModel = WeatherModel()
    var weatherList: [Response] = [] { // レスポンスデータが更新されたらテーブルビューを再読み込み
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var indicator = UIActivityIndicatorView()
    
    var loadingView = UIView(frame: UIScreen.main.bounds) {
        didSet {
            loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib(nibName: "WeatherListCell", bundle: nil), forCellReuseIdentifier: "Cell")
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(onRefresh(_:)), for: .valueChanged)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.fetchweatherList()
        }
        
        showIndicator()
        
        fetchweatherList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    @objc private func onRefresh(_ sender: AnyObject) {
        fetchweatherList()
        tableView.reloadData()
        tableView.refreshControl?.endRefreshing()
    }
    
    private func fetchweatherList() {
        view.addSubview(loadingView)
        indicator.startAnimating()
        weatherModel.fetchWeather(city: cities) { result in
            defer {
                DispatchQueue.main.async {
                    self.loadingView.removeFromSuperview()
                    self.indicator.stopAnimating()
                }
            }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.weatherList = response

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
    
    private func showIndicator() {
        indicator.center = view.center
        indicator.style = .large
        indicator.color = .white
        indicator.hidesWhenStopped = true
        //loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        loadingView.addSubview(indicator)
    }
    
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: WeatherListCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as?  WeatherListCell else { return UITableViewCell() }
        
        cell.weatherImageView.image = UIImage(named: weatherList[indexPath.row].info.weatherCondition.rawValue)
        
        switch weatherList[indexPath.row].info.weatherCondition {
        case .sunny:
            cell.weatherImageView.tintColor = .red
        case .cloudy:
            cell.weatherImageView.tintColor = .gray
        case .rainy:
            cell.weatherImageView.tintColor = .blue
        }
        
        cell.cityName.text = String(weatherList[indexPath.row].area)
        
        cell.minTemperature.text = String(weatherList[indexPath.row].info.minTemperature)
        cell.maxTemperature.text = String(weatherList[indexPath.row].info.maxTemperature)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
}

extension WeatherListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "WeatherDetailView", bundle: nil)
        guard let nextViewController = storyboard.instantiateInitialViewController() as? WeatherDetailViewController else { return }
        
        nextViewController.weatherList = weatherList[indexPath.row] // 詳細画面への値渡し
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
