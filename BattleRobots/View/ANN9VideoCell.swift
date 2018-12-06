//
//  ANN9VideoCell.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/20.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import SDWebImage

class ANN9VideoCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    var titleLabel : UILabel!
    var playImageView : UIImageView!
    
    var model : ANN9VideoListModel! {
        didSet {
            let url : URL = URL(string: model.thumbnail)!
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "video_icon_Next_dianji"))
            titleLabel.text = model.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(contentView)
        }
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(fit(12))
            make.top.equalTo(contentView.snp.top).offset(fit(12))
            make.right.equalTo(contentView.snp.right).inset(fit(12))
        }
        
        playImageView = UIImageView(image: UIImage(named: "Icon_home_play"))
        contentView.addSubview(playImageView)
        playImageView.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.size.equalTo(CGSize(width: fit(44), height: fit(44)))
        }
        
    }
    
    
}
