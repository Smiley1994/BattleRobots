//
//  ANN9JoinVipHeaderView.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/21.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit

class ANN9JoinVipHeaderView: UIView {

    var backButton : UIButton!
    var titleLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func createUI() {
        //      7d30d9,   7134d7    6f42e3
        let gradientColors: [CGColor] = [UIColor.hexColor(hexString: "7d30d9").cgColor, UIColor.hexColor(hexString: "6f42e3").cgColor]
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        
        gradientLayer.colors = gradientColors
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
        
        backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "返回"), for: .normal)
        self.addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(12)
            make.top.equalTo(self.snp.top).offset(isX ? 54 : 32)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        
        titleLabel = UILabel()
        titleLabel.text = "激活会员"
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(backButton.snp.centerY)
        }
        
    }
    
}
