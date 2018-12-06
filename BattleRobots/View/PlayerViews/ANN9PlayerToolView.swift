//
//  ANN9PlayerToolView.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/22.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import AVKit
import MediaPlayer


class ANN9PlayerToolView: UIView {

    var closeButton : UIButton!
    var titleLabel : UILabel!
    var playButton : UIButton!
    var nextVideoButton : UIButton!
    var centerPlayButton : UIButton!
    var videoTimeLabel : UILabel!
    var videoCurrentTimeLabel : UILabel!
    var model : ANN9VideoListModel! {
        didSet {
            titleLabel.text = model.title
        }
    }
    
    let playerButtonSize : CGSize = CGSize(width: 15, height: 15)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createUI()
    }
    
    func createUI() {
        
        closeButton = UIButton(type: .custom)
        closeButton.setImage(UIImage(named: "播放页Close"), for: .normal)
        closeButton.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.addSubview(closeButton)
        closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(0)
            make.top.equalTo(self.snp.top).offset(0)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        let volumeView = MPVolumeView()
        volumeView.setRouteButtonImage(UIImage(named: "video_icon_play_dianji"), for: .normal)
        volumeView.showsVolumeSlider = false
        self.addSubview(volumeView)
        volumeView.snp.makeConstraints { (make) in
            make.right.equalTo(self.snp.right).inset(12)
            make.top.equalTo(self.snp.top).offset(12)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        
        titleLabel = UILabel()
        titleLabel.text = "激活会员激活会员激活会员激活会"
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(closeButton.snp.right).offset(0)
            make.centerY.equalTo(closeButton.snp.centerY)
        }
        
        playButton = UIButton(type: .custom)
        playButton.setImage(UIImage(named: "video_icon_play_dianji"), for: .normal)
        playButton.setImage(UIImage(named: "video_icon_suspend_dianji"), for: .selected)
        self.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(16)
            make.bottom.equalTo(self.snp.bottom).inset(13)
            make.size.equalTo(playerButtonSize)
        }
        
        nextVideoButton = UIButton(type: .custom)
        nextVideoButton.setImage(UIImage(named: "video_icon_Next_dianji"), for: .normal)
        self.addSubview(nextVideoButton)
        nextVideoButton.snp.makeConstraints { (make) in
            make.left.equalTo(playButton.snp.right).offset(13)
            make.bottom.equalTo(self.snp.bottom).inset(13)
            make.size.equalTo(playerButtonSize)
        }
        
        videoCurrentTimeLabel = UILabel()
        videoCurrentTimeLabel.font = UIFont.systemFont(ofSize: 14)
        videoCurrentTimeLabel.textColor = UIColor.white
        videoCurrentTimeLabel.text = "00:00"
        self.addSubview(videoCurrentTimeLabel)
        videoCurrentTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(nextVideoButton.snp.right).offset(13)
            make.centerY.equalTo(nextVideoButton.snp.centerY)
        }
        
        videoTimeLabel = UILabel()
        videoTimeLabel.font = UIFont.systemFont(ofSize: 14)
        videoTimeLabel.textColor = UIColor.white
        videoCurrentTimeLabel.text = "/00:00"
        self.addSubview(videoTimeLabel)
        videoTimeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(videoCurrentTimeLabel.snp.right).offset(0)
            make.centerY.equalTo(nextVideoButton.snp.centerY)
        }
        
        
        self.addSubview(sliderView)
        sliderView.snp.makeConstraints { (make) in
            make.left.equalTo(self.snp.left).offset(fit(8))
            make.right.equalTo(self.snp.right).inset(fit(8))
            make.bottom.equalTo(playButton.snp.top)
            make.height.equalTo(35)
        }
        
    }
    
    
    func setUpTime(avPlayer : AVPlayer) {
        if let duration = avPlayer.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            let secondsText = Int(seconds) % 60
            let minutesText = String(format: "%02d", Int(seconds) / 60)
            videoTimeLabel.text = "\(minutesText):\(secondsText)"
        }
    }
    
    func updateCurrentTime(avPalyer : AVPlayer, progressTime : CMTime) {
        let seconds = CMTimeGetSeconds(progressTime)
        let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
        let minutesString = String(format: "%02d", Int(seconds / 60))
        videoCurrentTimeLabel.text = "\(minutesString):\(secondsString)"
        
        // move the slider thumb
        if let duration = avPalyer.currentItem?.duration {
            let durationSeconds = CMTimeGetSeconds(duration)
            sliderView.value = Float(seconds / durationSeconds)
        }
    }
    
    let sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: UIControlState())
        return slider
    }()
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
