//
//  ViewController.swift
//  ColorMonochromeDemo
//
//  Created by J K on 2019/1/6.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imgView: UIImageView!
    var setBtn: UIButton!
    var isSetViewAppear = false //判断set视图收回状态
        
    var setView: SetControlView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = #colorLiteral(red: 1, green: 0.6837530555, blue: 0.7923135099, alpha: 1)
        
        let img = UIImage(named: "yiliya01")
        imgView = UIImageView(image: img!)
        imgView.frame = CGRect(x: 30, y: 100, width: 250, height: 380)
        imgView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 140)
        imgView.layer.cornerRadius = 20
//        imgView.contentMode = UIView.ContentMode.scaleAspectFill
        imgView.layer.masksToBounds = true
        self.view.addSubview(imgView)
        
        setBtn = UIButton(frame: CGRect(x: 30, y: 100, width: 70, height: 30))
        setBtn.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height - 40)
        setBtn.setTitle("Set", for: .normal)
        setBtn.setTitleColor(#colorLiteral(red: 1, green: 0.6837530555, blue: 0.7923135099, alpha: 1), for: .normal)
        setBtn.backgroundColor = #colorLiteral(red: 1, green: 0.9347734548, blue: 0.4786213373, alpha: 1)
        setBtn.layer.cornerRadius = 13
        setBtn.addTarget(self, action: #selector(ViewController.setButton(_:)), for: .touchUpInside)
        self.view.addSubview(setBtn)
        
        //
        setView = SetControlView(frame: CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 260))
        setView?.layer.cornerRadius = 25
        
        setView?.viewControl = self
        
        self.view.addSubview(setView!)
    }
    
    //监视点击事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let tap = touches.first
        if tap?.view == self.view || tap?.view == self.imgView && self.isSetViewAppear == true{
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                //收回set视图
                let rect = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: 260)
                self.setView?.frame = rect
                
                //重新显现"set"按钮
                UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
                    self.setBtn.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height - 40)
                    self.setBtn.alpha = 1
                }, completion: { (complite) in
                })
            }) { (complite) in
                self.isSetViewAppear = false
            }
        }
    }
    
    //点击"set"按钮时调用此方法
    @objc func setButton(_ button: UIButton) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.setBtn.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height - 200)
            self.setBtn.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.3, options: .curveEaseOut, animations: {
                //弹出设置色调视图
                let rect = CGRect(x: 0, y: self.view.frame.height - 240, width: self.view.frame.width, height: 260)
                self.setView?.frame = rect
            }, completion: { (complite) in
            })
        }) { (compilte) in
            self.isSetViewAppear = true
        }
    }
    
}

