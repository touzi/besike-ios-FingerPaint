//
//  ViewController.swift
//  FingerPaint
//
//  Created by touzi on 14/10/30.
//  Copyright (c) 2014年 touzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var canvasView: CanvasView!
    
    weak var clearButton: UIButton!
    
    var colorButton: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //实例化view，应该为相同的根视图
        let canvasView = CanvasView(frame:view.frame)
        self.canvasView = canvasView
        self.canvasView.backgroundColor = UIColor.whiteColor()
        //self.canvasView.currentColor = UIColor.redColor()
        
        //将画布视图添加到根视图
        self.view.addSubview(self.canvasView)

        
        //将颜色块添加到视图层
        setupColorPickers()
        
        //清除画板
        setupClearButton()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupColorPickers() {
        //添加颜色版
        
        let colors : [UIColor] = [
            // 0x000000
            UIColor(red: 0, green: 0, blue: 0, alpha: 1),
            // 0x17A3A5
            UIColor(red: 0x17/255.0, green: 0xA3/255.0, blue: 0xA5/255.0, alpha: 1),
            // 0x8DBF67
            UIColor(red: 0x8D/255.0, green: 0xBF/255.0, blue: 0x67/255.0, alpha: 1),
            // 0xFCCB5F
            UIColor(red: 0xFC/255.0, green: 0xCB/255.0, blue: 0x5F/255.0, alpha: 1),
            // 0xFC6E59
            UIColor(red: 0xFC/255.0, green: 0x6E/255.0, blue: 0x59/255.0, alpha: 1),
        ]
        
        //(x,y)每个颜色块房子的位置
        let positions = [
            (33,43),(86,43),(138,43),(190,43),(242,43)
        ]
        
        //颜色快大小
        let size = (44,44)
        
        //TODO: 创建UIButton ，并添加到视图层
        for i in 0...4 {
            //创建一个按钮块
            let button = UIButton(frame: CGRect(x: positions[i].0, y: positions[i].1, width: size.0, height: size.1))
            //按钮块的背景颜色
            button.backgroundColor = colors[i]
            
            //为button添加一个事件(操作名称colorPickerTapped：遵循Objective-C的命名约定。它有一个“：”结尾。尝试删除“：”看看会发生什么。)
            button.addTarget(self, action: "colorPickerTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            
            //按钮点击时添加阴影效果
            button.layer.shadowColor = UIColor(white: 0.4, alpha: 1).CGColor
            button.layer.shadowOffset = CGSize(width: 0, height: 0)
            //控制阴影的深浅。0为取消阴影
            button.layer.shadowRadius = 3
            //是否透明显示
            //button.layer.shadowOpacity = 1
            
            colorButton.append(button)
            
            //在画布中显示按钮块
            view.addSubview(button)
        }
        
    }
    
    func setupClearButton() {
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        self.clearButton = button
        button.frame = CGRect(x: 267, y: 518, width: 37, height: 30)
        button.setTitle("Clear", forState: UIControlState.Normal)
        
        button.addTarget(self, action: "clearAll:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    
    
    
    
    func colorPickerTapped(button: UIButton) {
        println("tapped: \(button.backgroundColor)")
        
        for button in colorButton {
            if(button.layer.shadowOpacity == 1) {
                button.layer.shadowOpacity = 0
            }
        }
        
        canvasView.currentColor = button.backgroundColor!
            
        button.layer.shadowOpacity = 1
    }
    
    func clearAll(button: UIButton) {
        canvasView.paths.removeAll()
        canvasView.newPath = nil
        canvasView.setNeedsDisplay()
    }


}

