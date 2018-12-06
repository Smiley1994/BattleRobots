//
//  XSPlayerView.swift
//  BattleRobots
//
//  Created by 晓松 on 2018/6/25.
//  Copyright © 2018年 ann9. All rights reserved.
//

import UIKit
import AVKit

class XSPlayerView: UIView {

    var toolView : ANN9PlayerToolView!
    
    var playerItem:AVPlayerItem!
    var avPlayer:AVPlayer!
    var playerLayer:AVPlayerLayer!
    //时间观察者
    var timeObserver: Any!
    
    let LoadedTimeRanges : String = "loadedTimeRanges"
    let Status : String = "status"
    

    init (frame : CGRect, model : ANN9VideoListModel) {
        super.init(frame: frame)
        createPlayer(videoUrl: model.mUrl)
        createToolView()
        
        toolView.model = model
    }
    
    func createPlayer(videoUrl : String) {
        // 检测连接是否存在 不存在报错
        guard let url = URL(string: videoUrl) else { fatalError("连接错误") }
        playerItem = AVPlayerItem(url: url) // 创建视频资源
        // 监听缓冲进度改变
        playerItem.addObserver(self, forKeyPath: LoadedTimeRanges, options: NSKeyValueObservingOptions.new, context: nil)
        // 监听状态改变
        playerItem.addObserver(self, forKeyPath: Status, options: NSKeyValueObservingOptions.new, context: nil)
        // 将视频资源赋值给视频播放对象
        avPlayer = AVPlayer(playerItem: playerItem)
        // 初始化视频显示layer
        playerLayer = AVPlayerLayer(player: avPlayer)
        // 设置显示模式
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.contentsScale = UIScreen.main.scale
        // 位置放在最底下
        self.layer.insertSublayer(playerLayer, at: 0)
        
        let interval = CMTime(value: 1, timescale: 1)
        
        timeObserver = avPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main) { (progressTime) in
            self.toolView.updateCurrentTime(avPalyer: self.avPlayer, progressTime: progressTime)
        }
        
    }
    
    func createToolView() {
        toolView = ANN9PlayerToolView()
        toolView.backgroundColor = UIColor.clear
        toolView.sliderView.addTarget(self, action: #selector(sliderTouchUpOutside), for: .touchUpInside)
        toolView.playButton.addTarget(self, action: #selector(playClick), for: .touchUpInside)
        toolView.nextVideoButton.addTarget(self, action: #selector(nextVideoClick), for: .touchUpInside)
        self.addSubview(toolView)
        toolView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    @objc func sliderTouchUpOutside() { 
        if let duration = avPlayer?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            if totalSeconds > 0.0 {
                let value = Float64(toolView.sliderView.value) * Float64(totalSeconds)
                let seekTime = CMTime(value: Int64(value), timescale: 1)
                avPlayer?.seek(to: seekTime, completionHandler: { (completedSeek) in
                    self.avPlayer.play()
                })
            }
        }
    }
    
    /// player && pause
    @objc func playClick() {
        if let player = avPlayer{
            
            if player.rate == 0{
                player.play()
                toolView.playButton.isSelected = true
            }else if player.rate == 1{
                player.pause()
                toolView.playButton.isSelected = false
            }
        }
    }
    
    /// nextVideo
    @objc func nextVideoClick() {
        
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let playerItem = object as? AVPlayerItem else { return }
        if keyPath == LoadedTimeRanges{
            // 缓冲进度
            self.toolView.setUpTime(avPlayer: avPlayer)
            
        }else if keyPath == Status{
            // 监听状态改变
            if playerItem.status == AVPlayerItemStatus.readyToPlay{
                // 只有在这个状态下才能播放
                avPlayer.play()
                toolView.playButton.isSelected = true
            }else{
                print("加载异常\n",playerItem.status,"\n",AVPlayerItemStatus.readyToPlay)
            }
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = bounds
    }
    
    func playerFinish() {

        avPlayer.pause()
        avPlayer.currentItem?.cancelPendingSeeks()
        avPlayer.currentItem?.asset.cancelLoading()
        playerItem.removeObserver(self, forKeyPath: LoadedTimeRanges)
        playerItem.removeObserver(self, forKeyPath: Status)
        avPlayer.removeTimeObserver(timeObserver)
        avPlayer = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
