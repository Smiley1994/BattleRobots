//
//  Macro.swift
//  CiYuanMengDongLi
//
//  Created by 晓松 on 2018/4/8.
//  Copyright © 2018年 ciyuanmengdongli. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import SwiftyJSON
import Alamofire
import YYWebImage
import XSCommon
import SDWebImage

//当前系统版本
let Version = (UIDevice.current.systemVersion as NSString).floatValue
let ProjectName = Bundle.main.infoDictionary!["CFBundleDisplayName"]!


/// 屏幕宽度
let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width

/// 屏幕高度
let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height

/// iPhone X
let isX:Bool = (ScreenHeight == CGFloat(812) && ScreenWidth == CGFloat(375))

/// iPhone 6p 7p 8p
let isiPhonePlus = (ScreenHeight == CGFloat(736) && ScreenWidth == CGFloat(414))

/// iPhone 6 7 8
let isiPhone = (ScreenHeight == CGFloat(667) && ScreenWidth == CGFloat(375))


/// 导航栏高度
let NavgationBarHeight:CGFloat = isX ? 88 : 64

/// TabBar高度
let TabBarHeight:CGFloat = 49

/// iPhone X 顶部刘海高度
let TopLiuHeight:CGFloat = 30



func RGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1.0)
}

func RGBA(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
}

func fit(_ float:CGFloat) -> CGFloat {
    
    if isiPhone {
        return float
    } else {
        return float * 1.1
    }
}

