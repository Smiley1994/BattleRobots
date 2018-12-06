//
//  ArchiveMethod.swift
//  XSCommon
//
//  Created by 晓松 on 2018/7/25.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

import Foundation


// MARK: -- 创建文件夹
/// 创建文件夹 如果存在则不创建
public func CreatFilePath(_ filePath:String) ->Bool {
    
    let fileManager = FileManager.default
    
    // 文件夹是否存在
    if fileManager.fileExists(atPath: filePath) {
        
        return true
    }
    
    do{
        try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        
        return true
        
    }catch{}
    
    return false
}

// MARK: -- 文件链接处理
/// 文件类型
public func GetFileExtension(_ url:URL) ->String {
    
    return url.path.pathExtension()
}

/// 文件名称
public func GetFileName(_ url:URL) ->String {
    return url.path.lastPathComponent().stringByDeletingPathExtension()
}
