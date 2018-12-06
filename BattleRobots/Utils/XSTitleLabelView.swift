//
//  XSTitleLabelView.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/19.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit




class LabelItem : UICollectionViewCell {
    
    var titleLabel : UILabel!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textAlignment = .center
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        let selectedBackgroundView = UIView()
        
        
        let bottonLine = UIView()
        bottonLine.backgroundColor = UIColor.white
        selectedBackgroundView.addSubview(bottonLine)
        bottonLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(selectedBackgroundView)
            make.height.equalTo(2)
        }
        
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


protocol TitlelabelDelegate {
    func selectedIndex(index : Int)
}

class XSTitleLabelView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    var labels : [String] = [] {
        didSet {
            collectionView.reloadData()
            self.collectionView.selectItem(at: IndexPath(row: 0, section: 0), animated: true, scrollPosition: .left)
        }
    }
    var collectionView : UICollectionView!
    var selectedIndex : Int! {
        didSet {
            self.collectionView.selectItem(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .left)
        }
    }
    var delegate : TitlelabelDelegate!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    func createUI() {
        let layout = UICollectionViewFlowLayout()
//        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 30
        //分头
        layout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(LabelItem.self, forCellWithReuseIdentifier: "item")
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        self.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return labels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! LabelItem
        
        item.contentView.backgroundColor = UIColor.clear
        item.titleLabel.text = labels[indexPath.row]
        
        return item
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 40 ,height:40);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate.selectedIndex(index: indexPath.row)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
