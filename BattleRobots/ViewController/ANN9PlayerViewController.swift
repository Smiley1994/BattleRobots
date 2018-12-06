//
//  ANN9PlayerViewController.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/20.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import XSCommon

class ANN9PlayerViewController: UIViewController {

    var model : ANN9VideoListModel!
    var toolView : ANN9PlayerToolView!
    var playerView : XSPlayerView!
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        UIApplication.shared.isStatusBarHidden = true
        let value = UIInterfaceOrientation.landscapeLeft.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        let value = UIInterfaceOrientation.portrait.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    
    override var shouldAutorotate: Bool {
       return true
    }
    
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
//        createPlayerView()
    }

    func createPlayerView() {
        playerView = XSPlayerView(frame: CGRect.zero, model : model)
        playerView.toolView.closeButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        self.view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
    func createToolsView() {
     
        toolView = ANN9PlayerToolView()
        toolView.backgroundColor = UIColor.clear
        toolView.closeButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        self.view.addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    @objc func pop() {
        
        playerView.playerFinish()
        UIApplication.shared.isStatusBarHidden = false
        self.navigationController?.popViewController(animated: true)
    
    }
    
    

}
