//
//  CircleColorSparkViewFactory.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

class CircleColorSparkViewFactory: SparkViewFactory {
    
    var colors: [UIColor] {
        return UIColor.sparkColorSet1
    }
    
    func create(with data: SparkViewFactoryData) -> SparkView {
        let color = self.colors[data.index % self.colors.count]
        return CircleColorSparkView(color: color, size: data.size)
    }
}
