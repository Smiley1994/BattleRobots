//
//  ANN9UIColor.swift
//  CiYuanMengDongLi
//
//  Created by 晓松 on 2018/4/8.
//  Copyright © 2018年 ciyuanmengdongli. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    func formateTime() -> String {
        let formatter = DateFormatter();
        formatter.dateFormat = "yyyy年MM月dd日"
        let timeString = formatter.string(from: self)
        return timeString
    }
    
    func formateDate(dateStr : String) -> Date {
        //设置转换格式
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy年MM月dd日"
        //按照转换格式设置时间（月份缩写 日期 年 时区代码（GMT指格林威治时间，相当于零时区））
        let newDate = formatter.date(from: dateStr)
        //输出转换结果
        print("\(newDate!)")
        return newDate!
    }
}
