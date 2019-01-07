//
//  SetControlView.swift
//  ColorMonochromeDemo
//
//  Created by J K on 2019/1/6.
//  Copyright © 2019 Kims. All rights reserved.
//

import UIKit
import CoreImage

class SetControlView: UIView {

    weak var viewControl: ViewController?
    
    private var icon: UIView!
    private var backView: UIView!
    private var frontView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        let rect = frame
        self.backgroundColor = #colorLiteral(red: 1, green: 0.8361527734, blue: 0.8423714004, alpha: 1)
        
        icon = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        icon.center = CGPoint(x: 0, y: 10)
        icon.backgroundColor = #colorLiteral(red: 0.3843945129, green: 0.5439332918, blue: 1, alpha: 1)
        icon.layer.cornerRadius = 10
    
        backView = UIView(frame: CGRect(x: 30, y: 100, width: 180, height: 20))
        backView.center = CGPoint(x: rect.size.width/2, y: rect.size.height/2)
        backView.backgroundColor = #colorLiteral(red: 1, green: 0.9026003211, blue: 0.9632787625, alpha: 1)
        backView.layer.cornerRadius = 10
        
        frontView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 20))
        frontView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        frontView.layer.cornerRadius = 10
        
        backView.addSubview(frontView)
        backView.addSubview(icon)
        self.addSubview(backView)
    }

    // 根据触屏的移动位置来实现slider效果
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let loc = touch?.location(in: self)
        let previousLoc = touch?.previousLocation(in: self)

        let disX = (loc?.x)! - (previousLoc?.x)!  //偏移值
        let n = self.icon.center.x + disX
        
        //如果icon位移坐标大于调节条的最大x坐标，或小于调节条的最小x坐标时，跳出该方法
        if n > self.backView.frame.width && touch?.view == self.icon {
            return
        }else if n < 0 && touch?.view == self.icon {
            return
        }
        //icon只被允许在调节条范围内移动
        if n <= self.backView.frame.width && n >= 0 && touch?.view == self.icon {
            self.icon.center.x += disX
            self.frontView.frame.size.width = self.icon.center.x
        }
    }
    
    //触摸事件停止时修改图片色调
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let n = Int((self.icon.center.x / self.backView.frame.size.width)*10)
        let nn = Double(n)/10.0
        
        let imgs = UIImage(named: "yiliya01")
        
        //设置滤镜
        let ciImg = CIImage(image: imgs!)
        let filter = CIFilter(name: "CIColorMonochrome")
        let color = CIColor(red: 0.6, green: 0.7, blue: 0.3)
        filter?.setValue(color, forKey: kCIInputColorKey)
        filter?.setValue(nn, forKey: kCIInputIntensityKey)
        filter?.setValue(ciImg, forKey: kCIInputImageKey)
        let outImage = filter?.outputImage
        
        DispatchQueue.main.async {
            self.viewControl!.imgView.image = UIImage(ciImage: outImage!)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
