//
//  CircleColorSparkView.swift
//  Firework
//
//  Created by setsu on 2020/02/01.
//  Copyright © 2020 setsu. All rights reserved.
//

import UIKit

final class CircleColorSparkView: SparkView {
    
    init(color: UIColor, size: CGSize) {
        super.init(frame: CGRect(origin: .zero, size: size))
        self.backgroundColor = color
        self.layer.cornerRadius = self.frame.width / 2.0
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}


