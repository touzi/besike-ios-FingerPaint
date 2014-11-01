//
//  CanvasView.swift
//  FingerPaint
//
//  Created by touzi on 14/10/30.
//  Copyright (c) 2014年 touzi. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    
    var newPath : Path!
    var paths : [Path] = [Path]()

    let zigzag = [(100,100),
                  (100,150),(150,150),
                            (150,200)]
    
    //用于接收颜色块的颜色
    var currentColor : UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        //重写drawRect方法
        
        for path in paths {
            drawPash(path)
        }
        
        if(newPath != nil) {
            drawPash(newPath)
        }
        
        
        
        
        
        
        //获取绘图环境
//        let context = UIGraphicsGetCurrentContext()
        
        //创建形状（垂直线）到context
        
//        CGContextBeginPath(context)
//        CGContextMoveToPoint(context, 10, 20)
//        CGContextAddLineToPoint(context, 10, 200)
        
        //配置绘图环境
//        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        
        //配置到系统绘画
//        CGContextStrokePath(context)
        
        
        //用zigzag绘制折现
        
//        var startX: CGFloat = 50
//        var startY: CGFloat = 50
//        
//        var endX: CGFloat = startX
//        var endY: CGFloat = startY
//        
//        for(x,y) in zigzag {
//            endX = CGFloat(x)
//            endY = CGFloat(y)
//            if(startX != 50){
//                CGContextBeginPath(context)
//                CGContextMoveToPoint(context, startX, startY)
//                CGContextAddLineToPoint(context, endX, endY)
//                CGContextSetStrokeColorWithColor(context, currentColor.CGColor)
//                CGContextStrokePath(context)
//            }
//            startX = endX
//            startY = endY
//        }
    }
    
    
    func drawPash(path : Path) {
        //获取绘图环境
        let context = UIGraphicsGetCurrentContext()
        var startX: CGFloat = 50
        var startY: CGFloat = 50
        
        var endX: CGFloat = startX
        var endY: CGFloat = startY
        
        for point: CGPoint in path.points {
            endX = CGFloat(point.x)
            endY = CGFloat(point.y)
            if(startX != 50){
                CGContextBeginPath(context)
                CGContextMoveToPoint(context, startX, startY)
                CGContextAddLineToPoint(context, endX, endY)
                CGContextSetStrokeColorWithColor(context, path.color.CGColor)
                CGContextStrokePath(context)
            }
            startX = endX
            startY = endY
        }

    }
    
    //覆盖touchesBegan方法，为触摸事件作出反应
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        newPath = Path(color: currentColor)
        
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        newPath.add(point)
        println("touch point--> \(point)")
        setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        // TODO: Add a new touch point to the path
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        newPath.add(point)
        println("touch point--> \(point)")
        setNeedsDisplay()
        
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        // TODO: Add the end touch point
        
        let t = touches.anyObject() as UITouch
        let point = t.locationInView(self)
        newPath.add(point)
        paths.append(newPath)
        println("touch point--> \(point)")
        setNeedsDisplay()

    }
    
}
