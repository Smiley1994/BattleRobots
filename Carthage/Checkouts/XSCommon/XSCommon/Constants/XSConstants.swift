//
//  XSConstants.swift
//  XSCommon
//
//  Created by 晓松 on 2018/8/24.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

import Foundation

//当前系统版本
public let Version = (UIDevice.current.systemVersion as NSString).floatValue
public let ProjectName = Bundle.main.infoDictionary!["CFBundleDisplayName"]!


/// 屏幕宽度
public let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width

/// 屏幕高度
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height

/// iPhone X
public let isX:Bool = (ScreenHeight == CGFloat(812) && ScreenWidth == CGFloat(375))

/// iPhone 6p 7p 8p
public let isiPhonePlus = (ScreenHeight == CGFloat(736) && ScreenWidth == CGFloat(414))

/// iPhone 6 7 8
public let isiPhone = (ScreenHeight == CGFloat(667) && ScreenWidth == CGFloat(375))


/// 导航栏高度
public let NavgationBarHeight:CGFloat = isX ? 88 : 64

/// TabBar高度
public let TabBarHeight:CGFloat = 49

/// iPhone X 顶部刘海高度
public let TopLiuHeight:CGFloat = 30
