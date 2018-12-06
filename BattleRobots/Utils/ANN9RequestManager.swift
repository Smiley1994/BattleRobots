//
//  ANN9RequestManager.swift
//  CiYuanMengDongLi
//
//  Created by 晓松 on 2018/4/11.
//  Copyright © 2018年 ciyuanmengdongli. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Alamofire


class ANN9RequestManager: NSObject {
    
    
    class func requestData(_ urlString : String!, parameterJson : String? = nil, success:@escaping (SwiftyJSON.JSON) -> (),failed:((_ err : Any) -> ())? = nil) {
        
        let jsonData = parameterJson?.data(using: .utf8,allowLossyConversion: false)!
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON {
            (response) in
            if response.result.isSuccess {
                let json = JSON(response.data!)
                success(json)
            } else {
                let err = response.result
                failed!(err)
            }
        }
        
    } 
}
