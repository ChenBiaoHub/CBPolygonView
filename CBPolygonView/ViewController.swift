//
//  ViewController.swift
//  CBPolygonView
//
//  Created by 陈彪 on 2018/3/16.
//  Copyright © 2018年 小黑屋. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTestView()
    }
    
    func addTestView() {
        let topView = CBPolygonView.init(frame: .init(x: 0, y: 0, width: screenWidth, height: screenHeight/2.0))
        topView.circles = [0.8, 0.5]
        topView.angle = CGFloat.pi/2.0
        topView.cb_drawPolygon(percent:[0.5, 0.6, 0.4, 0.8, 0.6, 0.8, 0.9] , titles: ["击杀", "金钱", "防御", "魔法", "物理", "助攻","生存"], radius: 120)
        self.view.addSubview(topView)
        
        
        let bottomView = CBPolygonView.init(frame: .init(x: 0, y: screenHeight/2.0, width: screenWidth, height: screenHeight/2.0))
        bottomView.type = .circle
        bottomView.circleType = .dotted
        bottomView.angle = CGFloat.pi/2.0
        bottomView.circles = [0.8, 0.6]
        bottomView.lineColor = .white
        bottomView.fillColor = UIColor.init(white: 1, alpha: 0.5)
        bottomView.titleColor = .yellow
        bottomView.titleFont = UIFont.systemFont(ofSize: 12)
        bottomView.cb_drawPolygon(percent:[0.4, 0.8, 0.6, 0.8, 0.6] , titles: ["生存", "战绩(KDA)", "输出", "发育", "团战"], radius: 80)
        self.view.addSubview(bottomView)
    }
}
