//
//  ANN9Utils.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/25.
//  Copyright © 2018年 ann9. All rights reserved.
//

import Foundation
import AdSupport
import AVFoundation

func getIdfa() -> String {
    let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
    return idfa
}

func videoPreviewImage(videoUrl : String) -> UIImage {
    let url = videoUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    let asset = AVURLAsset(url: URL(string: url!)!)
    let gen = AVAssetImageGenerator(asset: asset)
    gen.appliesPreferredTrackTransform = true
    gen.maximumSize = CGSize(width: 300, height: 300)
    let time = CMTimeMakeWithSeconds(1.0, 600)
    
    var actualTime = CMTime()
    do {
        let image = try gen.copyCGImage(at: time, actualTime: &actualTime)
        let thumb = UIImage(cgImage: image)
        return thumb
    } catch {
        let placeHoldImage = UIImage(named: "play")
        return placeHoldImage!
    }
}
