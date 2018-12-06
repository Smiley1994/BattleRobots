//
//  ANN9VideoListModel.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/7/19.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import SwiftyJSON

class ANN9VideoListModel: NSObject {

    var _id:String!
    
    var mUrl:String!
    
    var thumbnail:String!
    
    var title:String!
    
    var width:Float!
    
    var height:Float!
    
    
    func initWithJson(response : JSON) -> [ANN9VideoListModel] {
        var videoList : [ANN9VideoListModel] = []
        for (_, subjson) : (String, JSON) in response["data"] {
            let videoItem = ANN9VideoListModel()
            videoItem._id = subjson["_id"].string
            videoItem.mUrl = subjson["mUrl"].string
            videoItem.title = subjson["title"]["simpleText"].string
            videoItem.thumbnail = subjson["thumbnail"]["url"].string
            videoItem.width = subjson["thumbnail"]["width"].float
            videoItem.height = subjson["thumbnail"]["height"].float
            videoList.append(videoItem)
        }
        return videoList
    }
    
}
