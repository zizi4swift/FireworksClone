//
//  ClassicSparkTrajectoryFactoryProtocol.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

protocol ClassicSparkTrajectoryFactoryProtocol: SparkTrajectoryFactory {
    
    func randomTopRight() -> SparkTrajectory
    func randomBottomRight() -> SparkTrajectory
}
