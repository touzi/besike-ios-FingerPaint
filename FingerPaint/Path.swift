//
//  Path.swift
//  FingerPaint
//
//  Created by touzi on 14/11/1.
//  Copyright (c) 2014年 touzi. All rights reserved.
//  模拟用户绘制的路径
//

import UIKit

class Path {
    var points: [CGPoint] = []
    let color: UIColor
    init(color: UIColor) {
        self.color = color
    }
    
    func add(point: CGPoint) {
        points.append(point)
    }
}
