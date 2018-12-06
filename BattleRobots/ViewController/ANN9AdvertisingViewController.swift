//
//  ANN9AdvertisingViewController.swift
//  CiYuanMengDongLi
//
//  Created by 晓松 on 2018/5/30.
//  Copyright © 2018年 ciyuanmengdongli. All rights reserved.
//

import UIKit
import SwiftyJSON
import YYWebImage

class ANN9AdvertisingViewController: UIViewController {

    typealias block = () -> ()
    
    var close : block!
    var adCover : JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(disMissAdCover), userInfo: nil, repeats: false)
    }
    
    func createUI() {
        let imageUrl = adCover["Data"]["3"].string!
        let adImageView = UIImageView()
        adImageView.yy_setImage(with: URL(string: imageUrl))
        self.view.addSubview(adImageView)
        adImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let closeButton = UIButton(type: .custom)
        closeButton.setTitle("跳过", for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: fit(16))
        closeButton.setTitleColor(UIColor.hexColor(hexString: "666666"), for: .normal)
        closeButton.addTarget(self, action: #selector(disMissAdCover), for: .touchUpInside)
        closeButton.backgroundColor = UIColor.clear
        closeButton.layer.masksToBounds = true
        closeButton.layer.cornerRadius = 5
        closeButton.layer.borderWidth = 0.6
        closeButton.layer.borderColor = UIColor.hexColor(hexString: "666666").cgColor
        self.view.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.view).inset(fit(15))
            make.bottom.equalTo(self.view).inset(fit(50))
            make.size.equalTo(CGSize(width: 65, height: 30))
        }
    }
    
    
    
    func openSafariWithUrl(urlString : String) {
        if let url = URL(string: urlString) {
            
            ANN9PostDevice.updateIDFA(action: "1", adUrl: urlString)
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],
                                          completionHandler: {
                                            (success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    @objc func disMissAdCover() {
        if (close != nil) {
            close!()
        }
        self.dismiss(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        openSafariWithUrl(urlString: adCover["AdUrl"].string!)
        if (close != nil) {
            close!()
        }
        self.dismiss(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
