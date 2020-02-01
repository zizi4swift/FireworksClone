//
//  Firework.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

protocol Firework {
    
    /// 花火ビューの初期位置
    var origin: CGPoint { get set }
    
    /// トラックのサイズを定義する。トラックはすべて同じサイズです
    /// そのため、画面に表示する前に拡大する必要があります
    var scale: CGFloat { get set }
    
    /// スパークビューのサイズ
    var sparkSize: CGSize { get set }
    
    /// トラックを取得
    var trajectoryFactory: SparkTrajectoryFactory { get }
    
    /// スパークビューを取得
    var sparkViewFactory: SparkViewFactory { get }
    
    func sparkViewFactoryData(at index: Int) -> SparkViewFactoryData
    func sparkView(at index: Int) -> SparkView
    func trajectory(at index: Int) -> SparkTrajectory
}

extension Firework {
    
    /// スパークビューと対応するトラックを返すヘルパーメソッド。
    func spark(at index: Int) ->  FireworkSpark {
        return FireworkSpark(self.sparkView(at: index), self.trajectory(at: index))
    }
}
