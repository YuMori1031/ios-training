//
//  RootViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/26.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // Viewが表示された時にWeatherListViewControllerへ画面遷移
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "WeatherListView", bundle: nil)
        guard let nextViewController = storyboard.instantiateInitialViewController() as? WeatherListViewController else { return }
        navigationController?.pushViewController(nextViewController, animated: true)
    }

}
