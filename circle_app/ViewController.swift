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
    var uiPath = UIBezierPath()
    var shapeLayer = CAShapeLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        //円の描画
        let pi = CGFloat(Double.pi)
        let start:CGFloat = 0.0 // 開始の角度
        let end :CGFloat = 2 * pi // 終了の角度
        
        let path: UIBezierPath = UIBezierPath();
        //描画するには必ずmoveメソット、addArcメソット必要
        //形に関わる
        path.move(to: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2))
        path.addArc(withCenter: CGPoint(x: self.view.frame.width/2, y: self.view.frame.height/2), radius: 180, startAngle: start, endAngle: end, clockwise: true) // 円弧
        //色やlineの太さをlayerで指定
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.orange.cgColor
        layer.borderColor = UIColor.black.cgColor
        layer.lineWidth = 3.0
        layer.path = path.cgPath
        //viewにlayerを追加
        self.view.layer.addSublayer(layer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //決定ボタンを押した時のメソット
    @IBAction func decide(_ sender: Any) {

        //テキストフィールドが空でない時
        if textField.text != nil{
            //テキストフィールドの文字取得
            num = Int(textField.text!)
            for i in 1 ... num{
                //num_arcではボタン間隔の角度
                let num_arc : Double = Double(360 / num)
                //θでそれそれのθ
                let θ = Double.pi / Double(180) * Double(num_arc * Double(i))
                let button = UIButton()
                //ボタンそれぞれのtagを指定
                button.tag = i
                //ボタンの位置を指定
                button.frame = CGRect(x: CGFloat(Double(self.view.frame.width/2 - 15) + 180 * cos(θ)), y: CGFloat(Double(self.view.frame.height/2 - 15) + 180 * sin(θ)), width: 30, height: 30)
                button.backgroundColor = UIColor.blue
                //ボタンを丸くする処理
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 15
                //ボタンにアクションずけ
                button.addTarget(self, action: #selector(self.btn_click), for: .touchUpInside)
                //viewにボタンを追加
                view.addSubview(button)
            }

        }
        
    }
    //リセット処理
    @IBAction func reset(_ sender: Any) {
        textField.text = ""
        //レイヤー削除処理
        shapeLayer.removeFromSuperlayer()
        uiPath.removeAllPoints()
        posArray = [[CGFloat]]()
        print("posarray\(posArray)")
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
        if posArray.count % 2 == 0{
            let arrayNumber = posArray.count / 2
            for i in 1...arrayNumber{
//                uiPath = UIBezierPath()
//                shapeLayer = CAShapeLayer()
                uiPath.move(to: CGPoint(x: posArray[(i * 2) - 2][0] + 15, y: posArray[(i * 2) - 2][1] + 15))       // ここから
                uiPath.addLine(to: CGPoint(x: posArray[(i * 2) - 1][0] + 15, y: posArray[(i * 2) - 1][1] + 15))  // ここまで線を引く
                shapeLayer.strokeColor = UIColor.black.cgColor  // 微妙に分かりにくい。色は要指定。
                shapeLayer.path = uiPath.cgPath
                view.layer.addSublayer(shapeLayer)
            }
        }
    }
    
}

