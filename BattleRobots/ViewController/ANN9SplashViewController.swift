//
//  ANN9SplashViewController.swift
//  Iron
//
//  Created by 晓松 on 2018/6/13.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import SwiftyJSON

class ANN9SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        openRootViewController()
//        loadAdData()
        
    }

    func loadAdData() {
        
        ANN9RequestManager.requestData(AdAPI, success: { (response) in
            ANN9APP.shareInstace.advertJson = response
            if response["data"]["AdCover"]["Status"].number == 1 &&   ANN9APP.shareInstace.UserType != IsVIP{ 
                self.showAdViewController(adCover: response["data"]["AdCover"])
            } else {
                self.openRootViewController()
            }
        }) { (err) in
            print(err)
            self.openRootViewController()
        }
        
    }
    
    func showAdViewController(adCover : JSON) {
        let adViewController = ANN9AdvertisingViewController()
        adViewController.adCover = adCover
        adViewController.close = {
            self.openRootViewController()
        }
        self.present(adViewController, animated: true)
    }
    
    func openRootViewController() {
        let window = UIApplication.shared.delegate as! AppDelegate
        window.window?.rootViewController = ANN9RootViewController()
    }

}
