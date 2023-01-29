//
//  NewViewController.swift
//  ios-training
//
//  Created by Yusuke Mori on 2023/01/26.
//

import UIKit

class NewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Viewが表示された時にViewControllerへ画面遷移
    override func viewDidAppear(_ animated: Bool) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateInitialViewController() as! ViewController
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated: true, completion: nil)
    }

}
