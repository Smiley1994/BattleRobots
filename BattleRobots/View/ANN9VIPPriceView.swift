//
//  ANN9VIPPriceView.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/21.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit

class ANN9VIPPriceView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 6
        self.layer.borderColor = RGBA(188, 153, 233, 1).cgColor
        self.layer.borderWidth = 0.7
        
        
        let vipImageView = UIImageView()
        vipImageView.image = UIImage(named: "会员-2")
        self.addSubview(vipImageView)
        vipImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(self.snp.top).offset(5)
            make.size.equalTo(CGSize(width: fit(50), height: fit(50)))
        }
        
        let vipLabelImageView = UIImageView()
        vipLabelImageView.image = UIImage(named: "年费视频vip")
        self.addSubview(vipLabelImageView)
        vipLabelImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(vipImageView.snp.bottom).offset(14)
            make.height.equalTo(fit(30))
        }
        
        let unitLabel = UILabel()
        unitLabel.text = " 仅需 ¥ "
        unitLabel.textColor = UIColor.hexColor(hexString: "2d2d33")
        unitLabel.font = UIFont.systemFont(ofSize: 16)
        self.addSubview(unitLabel)
        unitLabel.snp.makeConstraints { (make) in
            make.top.equalTo(vipLabelImageView.snp.bottom).offset(20)
            make.right.equalTo(self.snp.centerX)
        }
        
        
        let priceLabel = UILabel()
        priceLabel.text = "128"
        priceLabel.font = UIFont.systemFont(ofSize: 19)
        priceLabel.textColor = UIColor.hexColor(hexString: "EA4866")
        self.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(unitLabel.snp.bottom).offset(1)
            make.left.equalTo(self.snp.centerX)
        }
        
    }

}
