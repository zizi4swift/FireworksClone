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

extension SparkTrajectory {
    
    /// 軌跡のサイズに関してUI要件に適合するように軌跡をスケーリングします
    /// 他のすべての変換が適用された後、「shift」の前に使用します
    func scale(by value: CGFloat) -> SparkTrajectory {
        var copy = self
        (0..<self.points.count).forEach { copy.points[$0].multiply(by: value) }
        return copy
    }
    
    /// 軌跡を水平方向に反転します
    func flip() -> SparkTrajectory {
        var copy = self
        (0..<self.points.count).forEach { copy.points[$0].x *= -1 }
        return copy
    }
    
    /// （x、y）だけ軌跡をシフトします。 各ポイントに適用されます。
    /// 他のすべての変換が適用された後、および「scale」の後に使用します。
    func shift(to point: CGPoint) -> SparkTrajectory {
        var copy = self
        let vector = CGVector(dx: point.x, dy: point.y)
        (0..<self.points.count).forEach { copy.points[$0].add(vector: vector)}
        return copy
    }
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
