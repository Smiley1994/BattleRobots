//
//  XSExtesion+String.swift
//  XSExtension
//
//  Created by 晓松 on 2018/5/23.
//  Copyright © 2018年 ciyuanmengdongli. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /**
     根据 正则表达式 截取字符串
     
     - parameter regex: 正则表达式
     
     - returns: 字符串数组
     */
    
    public func matchesForRegex(regex: String) -> [String]? {
        do {
            let regularExpression = try NSRegularExpression(pattern: regex, options: [])
            let range = NSMakeRange(0, self.count)
            let results = regularExpression.matches(in: self, options: [], range: range)
            let string = self as NSString
            return results.map { string.substring(with: $0.range)}
        } catch {
            return nil
        }
    }
    
    /**
     String 的 length
     
     - returns: Int
     */
    public var length:Int {
        get{return (self as NSString).length}
    }
    
    /**
     String 转换 intValue = int32Value
     
     - returns: Int
     */
    public func int32Value() ->Int32{
        return NSString(string: self).intValue
    }
    
    /**
     String 转换 boolValue
     
     - returns: Bool
     */
    public func boolValue() ->Bool{
        return NSString(string: self).boolValue
    }
    
    /**
     String 转换 integerValue
     
     - returns: Int
     */
    public func integerValue() ->Int{
        return NSString(string: self).integerValue
    }
    
    /**
     String 转换 floatValue
     
     - returns: float
     */
    public func floatValue() ->Float{
        return NSString(string: self).floatValue
    }
    
    /**
     String 转换 CGFloatValue
     
     - returns: CGFloat
     */
    public func CGFloatValue() ->CGFloat{
        return CGFloat(self.floatValue())
    }
    
    /**
     String 转换 doubleValue
     
     - returns: double
     */
    public func doubleValue() ->Double{
        return NSString(string: self).doubleValue
    }
    
    /**
     截取字符串
     
     - returns: String
     */
    public func substring(_ range:NSRange) ->String {
        
        return NSString(string: self).substring(with: range)
    }
    
    /**
     获得文件的后缀名（不带'.'）
     
     - returns: String
     */
    public func pathExtension() ->String {
        
        return NSString(string: self).pathExtension
    }
    
    /**
     从路径中获得完整的文件名（带后缀）
     
     - returns: String
     */
    public func lastPathComponent() ->String {
        
        return NSString(string: self).lastPathComponent
    }
    
    /**
     获得文件名（不带后缀）

     - returns: String
     */
    public func stringByDeletingPathExtension() ->String {
        
        return NSString(string: self).deletingPathExtension
    }
    
    /// 计算字符串大小
    public func size(font:UIFont,constrainedToSize:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) ->CGSize {
        
        let string:NSString = self as NSString
        
        return string.boundingRect(with: constrainedToSize, options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: [NSAttributedStringKey.font:font], context: nil).size
    }
    
    /// 替换字符
    public func replacing(pattern:String, template:String) ->String {
        
        if isEmpty {return self}
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.stringByReplacingMatches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length), withTemplate: template)
            
        } catch {return self}
    }
    
    /// 正则搜索相关字符位置
    public func matches(pattern:String) ->[NSTextCheckingResult] {
        
        if isEmpty {return []}
        
        do {
            let regularExpression = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            
            return regularExpression.matches(in: self, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, length))
            
        } catch {return []}
    }
    
    /// 是否存在正则匹配到的内容
    public func isExist(pattern:String) ->Bool {
        
        let result:[NSTextCheckingResult] = matches(pattern: pattern)
        
        return !result.isEmpty
    }
    
    
    /// 时间戳转时间
    public func date() ->String {
        let currentDate = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "yyyyMMddHHmmss"
        let dateString = timeFormatter.string(from: currentDate)
        return dateString
    }
    
    //将原始的url编码为合法的url
     public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    //将编码后的url转换回原始的url
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
}

extension NSAttributedString{
    
    /// 计算多态字符串的size
    public func size(constrainedToSize:CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)) ->CGSize{
        
        return self.boundingRect(with: constrainedToSize, options: [NSStringDrawingOptions.usesLineFragmentOrigin,NSStringDrawingOptions.usesFontLeading], context: nil).size
    }
}

