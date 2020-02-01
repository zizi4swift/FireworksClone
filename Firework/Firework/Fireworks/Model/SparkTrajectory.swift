//
//  SparkTrajectory.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

protocol SparkTrajectory {
    
    /// 軌跡を定義するすべてのポイントを保存します
    var points: [CGPoint] { get set }
    
    /// 軌跡を表すパス
    var path: UIBezierPath { get }
}

/// 2つの制御点を持つベジェ曲線
struct CubicBezierTrajectory: SparkTrajectory {
    // Custom BezierPath: https://www.desmos.com/calculator/epunzldltu
    
    var points = [CGPoint]()
    
    init(_ x0: CGFloat, _ y0: CGFloat,
         _ x1: CGFloat, _ y1: CGFloat,
         _ x2: CGFloat, _ y2: CGFloat,
         _ x3: CGFloat, _ y3: CGFloat) {
        self.points.append(CGPoint(x: x0, y: y0))
        self.points.append(CGPoint(x: x1, y: y1))
        self.points.append(CGPoint(x: x2, y: y2))
        self.points.append(CGPoint(x: x3, y: y3))
    }
    
    var path: UIBezierPath {
        // 最初と最後のポイントは、軌跡の開始点と終了点を定義し、2つの中間ポイントは曲線の曲率を制御するために使用されます
        
        guard self.points.count == 4 else { fatalError("4つのポイントが必要です") }
        
        let path = UIBezierPath()
        path.move(to: self.points[0])
        path.addCurve(to: self.points[3],
                      controlPoint1: self.points[1],
                      controlPoint2: self.points[2])
        return path
    }
}
