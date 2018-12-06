//
//  ANN9BaseViewController.swift
//  Iron
//
//  Created by 晓松 on 2018/6/13.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ANN9BaseViewController: UIViewController,TitlelabelDelegate,UIScrollViewDelegate {

    var leftButton : UIButton!
    var scrollView : UIScrollView!
    var titleView : XSTitleLabelView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.randomColor
        UIApplication.shared.statusBarStyle = .lightContent
        
        createScrollView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(openJoinVipViewController), name: NSNotification.Name(rawValue: NotificationOpenJoinVip), object: nil)
        
    }
    
    @objc func openJoinVipViewController() {
        let joinVipViewController = ANN9JoinVipViewController()
        self.navigationController?.pushViewController(joinVipViewController, animated: true)
        
    }
    
    func setupNavigationView() {
        
        self.navigationController?.navigationBar.barTintColor = UIColor.hexColor(hexString: "7d30d9")
        leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "分类"), for: .normal)
        leftButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let leftBarItem = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarItem
        
        titleView = XSTitleLabelView(frame: CGRect(x: 0, y: 0, width: ScreenWidth / 2.5, height: 40))
        titleView.backgroundColor = UIColor.clear
        titleView.delegate = self
        titleView.labels = ["免费","会员"]
        self.navigationItem.titleView = titleView
    }
    
    func selectedIndex(index: Int) {
        
        let offsetX = CGFloat(index) * ScreenWidth
        scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentIndex = scrollView.contentOffset.x / ScreenWidth
        titleView.selectedIndex = Int(currentIndex)
    }
    
    
    func createScrollView() {
        
        let Height = ScreenHeight - NavgationBarHeight
        scrollView = UIScrollView(frame: CGRect(x: 0, y: NavgationBarHeight, width: ScreenWidth, height: Height))
        scrollView.backgroundColor = UIColor.white
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: ScreenWidth * 2, height: Height)
        view.addSubview(scrollView)
        
        let freeViewController = ANN9FreeVideoViewController()
        self.addChildViewController(freeViewController)
        freeViewController.view.frame = CGRect(x: 0, y: 0, width: ScreenWidth, height: Height)
        scrollView.addSubview(freeViewController.view)
        
        let vipViewController = ANN9VipVideoViewController()
        self.addChildViewController(vipViewController)
        vipViewController.view.frame = CGRect(x: ScreenWidth, y: 0, width: ScreenWidth, height: Height)
        scrollView.addSubview(vipViewController.view)
        
        
    }

}
