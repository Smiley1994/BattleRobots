//
//  ANN9VIPRightView.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/21.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit

class CommonView: UIView {
    
    var imageView : UIImageView!
    var subImageview : UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.left.equalTo(self).offset(7)
            make.right.equalTo(self).inset(7)
        }
        
        subImageview = UIImageView()
        subImageview.contentMode = .scaleAspectFit
        addSubview(subImageview)
        subImageview.snp.makeConstraints { (make) in
            make.left.right.equalTo(self)
            make.top.equalTo(imageView.snp.bottom).offset(7)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class ANN9VIPRightView: UIView {

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
        self.layer.borderWidth = 1
        
        
        let firstRightView = CommonView()
        firstRightView.imageView.image = UIImage(named: "会员-22")
        firstRightView.subImageview.image = UIImage(named: "尊贵标识")
        self.addSubview(firstRightView)
        firstRightView.snp.makeConstraints { (make) in
            make.left.top.equalTo(self).offset(25)
            make.width.equalTo(fit(65))
        }
        
        let secondRightView = CommonView()
        secondRightView.imageView.image = UIImage(named: "视频")
        secondRightView.subImageview.image = UIImage(named: "视频免费")
        self.addSubview(secondRightView)
        secondRightView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(25)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(fit(65))
        }
        
        
        let thirdRightView = CommonView()
        thirdRightView.imageView.image = UIImage(named: "会员权益")
        thirdRightView.subImageview.image = UIImage(named: "第三方权益")
        self.addSubview(thirdRightView)
        thirdRightView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(25)
            make.right.equalTo(self).inset(25)
            make.width.equalTo(fit(65))
        }
        
        
    }

}
