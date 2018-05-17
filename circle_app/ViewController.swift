//
//  ViewController.swift
//  circle_app
//
//  Created by tatsumi kentaro on 2018/05/13.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    var num : Int!
    var posArray = [[CGFloat]]()
    var mainPosArray = [[[CGFloat]]]()
    var count :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let pi = CGFloat(Double.pi)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = 2 * pi // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        path.move(to: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2))
        path.addArc(withCenter: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2), radius: 180, startAngle: start, endAngle: end, clockwise: true) // 円弧
        
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.orange.cgColor
        layer.borderColor = UIColor.black.cgColor
        layer.lineWidth = 3.0
        layer.path = path.cgPath
        
        self.view.layer.addSublayer(layer)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func decide(_ sender: Any) {
        if textField.text != nil{
            num = Int(textField.text!)
            for i in 1 ... num{
                let num_arc : Double = Double(360 / num)
                let θ = Double.pi / Double(180) * Double(num_arc * Double(i))
                let button = UIButton()
                button.tag = i
                button.frame = CGRect(x: CGFloat(Double(self.view.frame.width/2 - 15) + 180 * cos(θ)), y: CGFloat(Double(self.view.frame.height/2 - 15) + 180 * sin(θ)), width: 30, height: 30)
                print("θ\(θ)")
                print("X:\(Double(self.view.frame.width/2) + 20 * cos(θ)),Y:\(Double(self.view.frame.height/2) + 20 * sin(θ))")
                button.backgroundColor = UIColor.blue
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 15
                button.addTarget(self, action: #selector(self.btn_click), for: .touchUpInside)
                print(i)
                view.addSubview(button)
            }

        }
        
    }
    
    @IBAction func reset(_ sender: Any) {
        textField.text = ""
        for v in view.subviews{
            if let v = v as? UIButton, v.tag >= 1 && v.tag <= num {
                v.removeFromSuperview()
            }
        }
    }
    
    @objc func btn_click(_ sender: UIButton) {
        print(sender.tag)
        sender.backgroundColor = UIColor.red
        print("X:\(sender.frame.origin.x),Y:\(sender.frame.origin.y)")
//        sender.isEnabled = false
        let pos = [sender.frame.origin.x,sender.frame.origin.y]
        posArray.append(pos)
        print(posArray)
        if posArray.count % 2 == 0{
            let num = posArray.count / 2
            for i in 1...num{
                let uiPath = UIBezierPath()
                let shapeLayer = CAShapeLayer()
                uiPath.move(to: CGPoint(x: posArray[(i * 2) - 2][0] + 15, y: posArray[(i * 2) - 2][1] + 15))       // ここから
                uiPath.addLine(to: CGPoint(x: posArray[(i * 2) - 1][0] + 15, y: posArray[(i * 2) - 1][1] + 15))  // ここまで線を引く
                shapeLayer.strokeColor = UIColor.blue.cgColor  // 微妙に分かりにくい。色は要指定。
                shapeLayer.path = uiPath.cgPath
                view.layer.addSublayer(shapeLayer)
            }
        }
    }
    
}

