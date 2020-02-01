//
//  SparkViewFactory.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

protocol SparkViewFactoryData {
    
    var size: CGSize { get }
    var index: Int { get }
}

protocol SparkViewFactory {
    
    func create(with data: SparkViewFactoryData) -> SparkView
}

struct DefaultSparkViewFactoryData: SparkViewFactoryData {
    
    let size: CGSize
    let index: Int
}
