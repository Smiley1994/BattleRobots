//
//  XSIQiYiPlayButton.swift
//  XSSuperDemo-Swfit
//
//  Created by 晓松 on 2018/7/10.
//  Copyright © 2018年 GoodMorning. All rights reserved.
//

import UIKit

public enum IQiYiPlayStatus : Int {
    case IQiYiPlayStatusPause = 0
    case IQiYiPlayStatusPlay
}

//其它动画时长
let AnimationDuration : CGFloat = 0.5
//位移动画时长
let PositionDuration  : CGFloat = 0.3

let TriangleAnimation = "TriangleAnimation"
let RightLineAnimation = "RightLineAnimation"


public class XSIQiYiPlayButton: UIButton,CAAnimationDelegate {

    public var buttonStatus : IQiYiPlayStatus! {
        didSet {
            if isAnimation == true {return}
            
            if buttonStatus == .IQiYiPlayStatusPlay {
                isAnimation = true
                
                linePositiveAnimation()
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.3) {
                    self.actionPositionAnimation()
                }
            } else if buttonStatus == .IQiYiPlayStatusPause {
                isAnimation = true
                actionInverseAnimation()
                
                DispatchQueue.main.asyncAfter(deadline:.now() + 0.5) {
                    self.lineInverseAnimation()
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline:.now() + 0.8) {
                self.isAnimation = false
            }
        }
    }
    var isAnimation : Bool = false
    
    var LineColor : UIColor!
    
    var leftLineLayer : CAShapeLayer!
    var triangleLayer : CAShapeLayer!
    var rightLineLayer : CAShapeLayer!
    var circleLayer : CAShapeLayer!
    
    
    public init(frame : CGRect, status : IQiYiPlayStatus, color : UIColor? = UIColor.white) {
        super.init(frame: frame)
        LineColor = color
        createUI(status : status)
    }
    
    
    
    func createUI(status : IQiYiPlayStatus) {
        addTriangleLayer()
        addLeftLineLayer()
        addRightLineLayer()
        addCircleLayer()
        buttonStatus = status
    }
    
    private func addTriangleLayer() {
        let a = self.bounds.size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: a * 0.2, y: a * 0.2))
        path.addLine(to: CGPoint(x: a * 0.2, y: 0))
        path.addLine(to: CGPoint(x: a, y: a * 0.5))
        path.addLine(to: CGPoint(x: a * 0.2, y: a))
        path.addLine(to: CGPoint(x: a * 0.2, y: a * 0.2))
        
        triangleLayer = CAShapeLayer()
        triangleLayer.path = path.cgPath
        triangleLayer.fillColor = UIColor.clear.cgColor
        triangleLayer.strokeColor = LineColor.cgColor
        triangleLayer.lineWidth = LineWidth()
        triangleLayer.lineCap = kCALineCapButt
        triangleLayer.lineJoin = kCALineJoinRound
        triangleLayer.strokeEnd = 0
        self.layer .addSublayer(triangleLayer)
        
    }
    
    private func addLeftLineLayer () {
        let a = self.bounds.size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: a * 0.2, y: 0))
        path.addLine(to: CGPoint(x: a * 0.2, y: a))
        
        leftLineLayer = CAShapeLayer()
        leftLineLayer.path = path.cgPath
        leftLineLayer.fillColor = UIColor.clear.cgColor
        leftLineLayer.strokeColor = LineColor.cgColor
        leftLineLayer.lineWidth = LineWidth()
        leftLineLayer.lineCap = kCALineCapRound
        leftLineLayer.lineJoin = kCALineJoinRound
        self.layer.addSublayer(leftLineLayer)
        
    }
    
    private func addRightLineLayer() {
        let a = self.bounds.size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: a * 0.8, y: a))
        path.addLine(to: CGPoint(x: a * 0.8, y: 0))
        
        rightLineLayer = CAShapeLayer()
        rightLineLayer.path = path.cgPath
        rightLineLayer.fillColor = UIColor.clear.cgColor
        rightLineLayer.strokeColor = LineColor.cgColor
        rightLineLayer.lineWidth = LineWidth()
        rightLineLayer.lineCap = kCALineCapRound
        rightLineLayer.lineJoin = kCALineJoinRound
        self.layer.addSublayer(rightLineLayer)
    }
    
    private func addCircleLayer() {
        let a = self.bounds.size.width
        let path = UIBezierPath()
        path.move(to: CGPoint(x: a * 0.8, y: a * 0.8))
        path.addArc(withCenter: CGPoint(x: a * 0.5, y: a * 0.8), radius: a * 0.3, startAngle: 0, endAngle: .pi, clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = path.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = LineColor.cgColor
        circleLayer.lineWidth = LineWidth()
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineJoin = kCALineJoinRound
        circleLayer.strokeEnd = 0
        self.layer.addSublayer(circleLayer)
    }
    
    
    //MARK: 执行动画 暂停->播放
    private func actionPositionAnimation() {
        strokeEndAnimationFrom(fromValue: 0, toValue: 1, layer: triangleLayer, animationName: TriangleAnimation, duration: AnimationDuration, delegate: self)
        
        strokeEndAnimationFrom(fromValue: 1, toValue: 0, layer: rightLineLayer, animationName: RightLineAnimation, duration: AnimationDuration / 4, delegate: self)
        
        strokeEndAnimationFrom(fromValue: 0, toValue: 1, layer: circleLayer, animationName: nil, duration: AnimationDuration / 4, delegate: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
            self.circleStartAnimationFrom(fromValue: 0, toValue: 1)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.strokeEndAnimationFrom(fromValue: 1, toValue: 0, layer: self.leftLineLayer, animationName: nil, duration: AnimationDuration / 2, delegate: nil)
        }
    }
    
    
    //MARK: 执行动画 播放 -> 暂停
    private func actionInverseAnimation() {
        strokeEndAnimationFrom(fromValue: 1, toValue: 0, layer: triangleLayer, animationName: TriangleAnimation, duration: AnimationDuration, delegate: self)
        
        strokeEndAnimationFrom(fromValue: 0, toValue: 1, layer: leftLineLayer, animationName: nil, duration: AnimationDuration / 2, delegate: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.circleStartAnimationFrom(fromValue: 1, toValue: 0)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.38) {
            
            self.strokeEndAnimationFrom(fromValue: 0, toValue: 1, layer: self.rightLineLayer, animationName: RightLineAnimation, duration: AnimationDuration / 4, delegate: self)
            
            self.strokeEndAnimationFrom(fromValue: 1, toValue: 0, layer: self.circleLayer, animationName: nil, duration: AnimationDuration / 4, delegate: nil)
            
        }
        
    }
    
    
    
    /**
     通用执行strokeEnd动画
     */
    private func strokeEndAnimationFrom(fromValue : CGFloat, toValue : CGFloat, layer : CALayer, animationName : String? = nil, duration : CGFloat, delegate : CAAnimationDelegate? = nil) {
        
        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeEndAnimation.duration = CFTimeInterval(duration)
        strokeEndAnimation.fromValue = fromValue
        strokeEndAnimation.toValue = toValue
        strokeEndAnimation.fillMode = kCAFillModeForwards
        strokeEndAnimation.isRemovedOnCompletion = false
        strokeEndAnimation.setValue(animationName, forKey: "animationName")
        strokeEndAnimation.delegate = delegate
        layer.add(strokeEndAnimation, forKey: nil)
    }
    
    /**
     画弧改变起始位置动画
     */
    private func circleStartAnimationFrom(fromValue : CGFloat, toValue : CGFloat) {
        let circleAnimation = CABasicAnimation(keyPath: "strokeStart")
        circleAnimation.duration = CFTimeInterval(AnimationDuration/4)
        circleAnimation.fromValue = fromValue
        circleAnimation.toValue = toValue
        circleAnimation.fillMode = kCAFillModeForwards
        circleAnimation.isRemovedOnCompletion = false
        circleLayer.add(circleAnimation, forKey: nil)
    }
    
    //MARK: 动画 开始，结束代理方法
    public func animationDidStart(_ anim: CAAnimation) {
        let name = anim.value(forKey: "animationName") as! String
        if name == TriangleAnimation {
            triangleLayer.lineCap = kCALineCapRound
        } else if name == RightLineAnimation {
            rightLineLayer.lineCap = kCALineCapRound
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        let name = anim.value(forKey: "animationName") as! String
        if buttonStatus == IQiYiPlayStatus.IQiYiPlayStatusPlay && name == RightLineAnimation {
            rightLineLayer.lineCap = kCALineCapButt
        } else if name == TriangleAnimation {
            triangleLayer.lineCap = kCALineCapButt
        }
    }
    
    
    private func LineWidth() -> CGFloat {
        return self.bounds.width * 0.2
    }
    
    
    //MARK: 暂停-》播放竖线动画
    private func linePositiveAnimation() {
        let a = self.bounds.size.width;
        
        // 左侧缩放动画
        let leftPath1 = UIBezierPath()
        leftPath1 .move(to: CGPoint(x: 0.2 * a, y: 0.4 * a))
        leftPath1.addLine(to: CGPoint(x: 0.2 * a, y: a))
        leftLineLayer.path = leftPath1.cgPath
        leftLineLayer .add(pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
        
        //右侧竖线位移动画
        let rightpath1 = UIBezierPath()
        rightpath1.move(to: CGPoint(x: 0.8 * a, y: 0.8 * a))
        rightpath1.addLine(to: CGPoint(x: 0.8 * a, y: -0.2 * a))
        rightLineLayer.path = rightpath1.cgPath
        rightLineLayer.add(pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            //左侧位移动画
            let leftPath2 = UIBezierPath()
            leftPath2 .move(to: CGPoint(x: 0.2 * a, y: 0.2 * a))
            leftPath2.addLine(to: CGPoint(x: 0.2 * a, y: a * 0.8))
            self.leftLineLayer.path = leftPath2.cgPath
            self.leftLineLayer.add(self.pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
            
            //右侧竖线位移动画
            let rightpath2 = UIBezierPath()
            rightpath2.move(to: CGPoint(x: 0.8 * a, y: 0.8 * a))
            rightpath2.addLine(to: CGPoint(x: 0.8 * a, y: 0.2 * a))
            self.rightLineLayer.path = rightpath2.cgPath
            self.rightLineLayer.add(self.pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
        }
    }
    
    //MARK: 播放-》暂停竖线动画
    private func lineInverseAnimation() {
        let a = self.bounds.size.width
        
        let leftPath1 = UIBezierPath()
        leftPath1.move(to: CGPoint(x: 0.2 * a, y: 0.4 * a))
        leftPath1.addLine(to: CGPoint(x: 0.2 * a, y: a))
        leftLineLayer.path = leftPath1.cgPath
        leftLineLayer.add(pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
        
        let rightPath1 = UIBezierPath()
        rightPath1.move(to: CGPoint(x: 0.8 * a, y: 0.8 * a))
        rightPath1.addLine(to: CGPoint(x: 0.8 * a, y: -0.2 * a))
        rightLineLayer.path = rightPath1.cgPath
        rightLineLayer.add(pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            
            let leftPath2 = UIBezierPath()
            leftPath2.move(to: CGPoint(x: 0.2 * a, y: 0))
            leftPath2.addLine(to: CGPoint(x: 0.2 * a, y: a))
            self.leftLineLayer.path = leftPath2.cgPath
            self.leftLineLayer.add(self.pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
            
            let rightPath2 = UIBezierPath()
            rightPath2.move(to: CGPoint(x: 0.8 * a, y: a))
            rightPath2.addLine(to: CGPoint(x: 0.8 * a, y: 0))
            self.rightLineLayer.path = rightPath2.cgPath
            self.rightLineLayer.add(self.pathAnimationWithDuration(duration: PositionDuration / 2), forKey: nil)
        }
    }

    /**
     通用path动画方法
     */
    private func pathAnimationWithDuration(duration : CGFloat) -> CABasicAnimation {
        let pathAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.duration = CFTimeInterval(duration)
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        return pathAnimation
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
