//
//  ClassicFireworkAnimator.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

struct ClassicFireworkAnimator: SparkViewAnimator {
    
    init() {}
    
    func animate(spark: FireworkSpark, duration: TimeInterval) {
        
        // スパークビューをトラックに合わせ、スパークを（ランダムに）ズームしながら不透明度を変更する
        
        spark.sparkView.isHidden = false
        
        CATransaction.begin()
        
        // Position
        let positionAnim = CAKeyframeAnimation(keyPath: "position")
        positionAnim.path = spark.trajectory.path.cgPath
        positionAnim.calculationMode = .linear
        positionAnim.rotationMode = .rotateAuto
        positionAnim.duration = duration
        
        // Scale
        let randomMaxScale = 1.0 + CGFloat(arc4random_uniform(7)) / 10.0
        let randomMinScale = 0.5 + CGFloat(arc4random_uniform(3)) / 10.0
        
        let fromTransform = CATransform3DIdentity
        let byTransform = CATransform3DScale(fromTransform, randomMaxScale, randomMaxScale, randomMaxScale)
        let toTransform = CATransform3DScale(CATransform3DIdentity, randomMinScale, randomMinScale, randomMinScale)
        let transformAnim = CAKeyframeAnimation(keyPath: "transform")
        
        transformAnim.values = [
            NSValue(caTransform3D: fromTransform),
            NSValue(caTransform3D: byTransform),
            NSValue(caTransform3D: toTransform)
        ]
        
        transformAnim.duration = duration
        transformAnim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        spark.sparkView.layer.transform = toTransform
        
        // Opacity
        let opacityAnim = CAKeyframeAnimation(keyPath: "opacity")
        opacityAnim.values = [1.0, 0.0]
        opacityAnim.keyTimes = [0.95, 0.98]
        opacityAnim.duration = duration
        spark.sparkView.layer.opacity = 0.0
        
        // Group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [positionAnim, transformAnim, opacityAnim]
        groupAnimation.duration = duration
        
        CATransaction.setCompletionBlock {
            spark.sparkView.removeFromSuperview()
        }
        
        spark.sparkView.layer.add(groupAnimation, forKey: "spark-animation")
        
        CATransaction.commit()
    }
}
