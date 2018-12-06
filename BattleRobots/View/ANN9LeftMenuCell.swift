//
//  ANN9LeftMenuCell.swift
//  CiYuanMengDongLi
//
//  Created by 晓松 on 2018/5/23.
//  Copyright © 2018年 ciyuanmengdongli. All rights reserved.
//

import UIKit
import YYWebImage

class ANN9LeftMenuCell: UITableViewCell {
    
    class func cellWithTableView(tableView:UITableView) ->ANN9LeftMenuCell {
        let ANN9LeftMenuCellId = "ANN9LeftMenuCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ANN9LeftMenuCellId) as? ANN9LeftMenuCell
        
        if (cell == nil) {
            cell = ANN9LeftMenuCell(style:UITableViewCellStyle.default,reuseIdentifier:ANN9LeftMenuCellId)
        }
        
        return cell!
    }
    
    var iconImageView : UIImageView!
    var titleLabel : UILabel!
    var vipImageView : UIImageView!
    var model : ANN9LeftMenuModel! {
        didSet {
            
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        self.selectionStyle = .none
        self.createSubView()
    }
    
    func createSubView () {
        
        self.contentView.backgroundColor = RGB(141, 107, 240)
        
        iconImageView = UIImageView()
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { (make) in
            make.left.equalTo(contentView.snp.left).offset(fit(18))
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: fit(21), height: fit(21)))
        }
        
        titleLabel = UILabel()
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: fit(16))
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(iconImageView.snp.right).offset(fit(22))
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        vipImageView = UIImageView()
        contentView.addSubview(vipImageView)
        vipImageView.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel.snp.right).offset(fit(27))
            make.centerY.equalTo(contentView.snp.centerY)
            make.size.equalTo(CGSize(width: fit(24), height: fit(14)))
        }
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = RGB(125, 91, 225)
        self.selectedBackgroundView = selectedBackgroundView
        
    }
    
    func setupAdmodel(model : ANN9LeftMenuAdModel) {
        iconImageView.yy_setImage(with: URL(string: model.iconUrl))
        titleLabel.text = model.title
    }
    
    func setupModel(model : ANN9LeftMenuModel) {
        iconImageView.image = UIImage(named: model.icon)
        titleLabel.text = model.title
        if model.vipIcon != nil {
            vipImageView.image = UIImage(named: model.vipIcon)
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
