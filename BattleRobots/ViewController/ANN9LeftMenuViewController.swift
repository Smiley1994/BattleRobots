//
//  ANN9LeftMenuViewController.swift
//  Iron
//
//  Created by 晓松 on 2018/6/13.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit

class ANN9LeftMenuViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    var dataArray : [Any] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor.hexColor(hexString: "7d30d9")
        
        
        createTableView()
        setupDataArray()
    }
    
    func createTableView() {
        
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = fit(50)
        tableView.separatorStyle = .none
        tableView.backgroundColor = RGB(141, 107, 240)
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
    }

    func setupDataArray() {
        
        let mainModel = ANN9LeftMenuModel()
        mainModel.icon = "首页"
        mainModel.title = "首页"
        if ANN9APP.shareInstace.UserType == IsVIP {
            mainModel.vipIcon = "VIP"
        }
        
        dataArray.append(mainModel)
        
        let topupModel = ANN9LeftMenuModel()
        topupModel.icon = "激活会员"
        if  ANN9APP.shareInstace.UserType == IsVIP {
            topupModel.title = "我的会员"
        } else {
            topupModel.title = "激活会员"
        }
        
        dataArray.append(topupModel)
        
        let shareModel = ANN9LeftMenuModel()
        shareModel.icon = "分享"
        shareModel.title = "分享"
        dataArray.append(shareModel)
        
//        let historyModel = ANN9LeftMenuModel()
//        historyModel.icon = "Sideslip_icon_History_tubiao"
//        historyModel.title = "历史记录"
//        dataArray.append(historyModel)
        
//        if ANN9APP.shareInstace.advertJson["data"]["AdList"]["Status"].number == 1 {
//            
//            let adTitleHeader = ANN9LeftMenuAdHeaderModel()
//            adTitleHeader.title = "赞助商"
//            dataArray.append(adTitleHeader)
//            
//            for (_, item) in ANN9APP.shareInstace.advertJson["data"]["AdList"]["Data"] {
//                let adListModel = ANN9LeftMenuAdModel()
//                adListModel.iconUrl = item["AdImage"].string
//                adListModel.title = item["Title"].string
//                adListModel.adUrl = item["AdUrl"].string
//                dataArray.append(adListModel)
//            }
//        }
        
        
        tableView.reloadData()
        
        tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: UITableViewScrollPosition.top)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ANN9LeftMenuCell.cellWithTableView(tableView: tableView)
        
        if dataArray[indexPath.row] is ANN9LeftMenuModel {
            let model = dataArray[indexPath.row] as! ANN9LeftMenuModel
            cell.setupModel(model: model)
        } else if dataArray[indexPath.row] is ANN9LeftMenuAdModel {
            let model = dataArray[indexPath.row] as! ANN9LeftMenuAdModel
            cell.setupAdmodel(model: model)
        } else if dataArray[indexPath.row] is ANN9LeftMenuAdHeaderModel {
            
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationHiddenLeftMenu), object: nil)
        } else if indexPath.row == 1 {
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationHiddenLeftMenu), object: nil)
            NotificationCenter.default.post(name: Notification.Name(rawValue: NotificationOpenJoinVip), object: nil)
        }
    }
    
    
    
    deinit {
        
    }

}
