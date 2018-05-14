//
//  ViewController.swift
//  circle_app
//
//  Created by tatsumi kentaro on 2018/05/13.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pi = CGFloat(Double.pi)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = 2 * pi // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        path.move(to: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2))
        path.addArc(withCenter: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2), radius: 100, startAngle: start, endAngle: end, clockwise: true) // 円弧
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.orange.cgColor
        layer.path = path.cgPath
        
        self.view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

