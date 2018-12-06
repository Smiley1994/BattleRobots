//
//  ANN9VipVideoViewController.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/19.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit

class ANN9VipVideoViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var page : NSInteger = 0
    let pageSize : NSInteger = 12
    
    
    var dataArray : NSMutableArray = NSMutableArray()
    
    var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        createCollectionView()
        refresh()
        
        collectionView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: {
            self.requestData(offset: self.page)
        })
    }
    
    func refresh() {
        requestData(offset: page)
    }
    
    func requestData(offset : NSInteger) {
        page = offset + 12
        ANN9RequestManager.requestData(Ann9VipVideoList, parameterJson: "{\"offset\":\(offset),\"limit\":\(pageSize)}", success: { (json) in
            self.collectionView.mj_footer.endRefreshing()
            let videList : [ANN9VideoListModel] = ANN9VideoListModel().initWithJson(response: json)
            self.dataArray.addObjects(from: videList)
            self.collectionView.reloadData()
        }) { (err) in
            print(err)
        }
    }
    
    func createCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        //分头
        layout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = RGB(243, 243, 243)
        collectionView.register(ANN9VideoCell.self, forCellWithReuseIdentifier: "item")
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! ANN9VideoCell
        
        let model = dataArray[indexPath.row] as! ANN9VideoListModel
        
        item.model = model
        
        return item
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ScreenWidth ,height:(ScreenWidth - 4) / 2 * 1.3);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerViewController = ANN9PlayerViewController()
        let model = dataArray[indexPath.row] as! ANN9VideoListModel
        playerViewController.model = model
        self.navigationController?.pushViewController(playerViewController, animated: true)
    }

}
