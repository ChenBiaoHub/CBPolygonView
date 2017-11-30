//
//  CBPolygonView.swift
//  CBPolygonView
//
//  Created by 陈彪 on 2017/11/29.
//  Copyright © 2017年 小黑屋. All rights reserved.
//

import UIKit
enum CBPolygonType {
    /** 原型 */
    case circle
    /** 多边形 */
    case polygon
}

enum CBPolyLineType {
    /** 实线 */
    case soild
    
    /** 虚线 */
    case dotted
}

class CBPolygonView: UIView {
    //MARK: - 公有属性
    /** 连接线颜色 */
    public var lineColor : UIColor = UIColor.init(white: 1, alpha: 0.8)
    /** 连接线宽度 */
    public var lineWidth : CGFloat = 2
    
    /** 标记点图片（有图片会优先使用图片） */
    public var pointImage : UIImage?
    /** 标记点颜色 */
    public var pointColor : UIColor = UIColor.white
    /** 标记点宽度 */
    public var pointWidth : CGFloat = 5
    
    /** 中心点到外圈连线颜色 */
    public var centerLineColor : UIColor = UIColor.init(white: 1, alpha: 0.5)
    /** 中心点到外圈连线线宽 */
    public var centerLineWidth : CGFloat = 1.5
    
    
    /** 线圈类型 */
    public var circleType : CBPolyLineType = .soild
    /** 线圈线宽 */
    public var circleLineWidth : CGFloat = 0.5
    /** 线圈颜色 */
    public var circleLineColor : UIColor = UIColor.init(white: 1, alpha: 1)
    
    
    /** 描述文字距外圈距离 */
    public var titleDistance : CGFloat = 20
    /** 描述文字的字体 */
    public var titleFont : UIFont = UIFont.systemFont(ofSize: 17)
    /** 描述文字 */
    public var titleColor : UIColor = UIColor.init(white: 1, alpha: 1)
    
    /** 内圈 */
    public var circles : [CGFloat] = [0.8, 0.6]
    /** 区域内填充颜色 */
    public var fillColor : UIColor?
    
    
    /** 旋转角度 （180°写成 π ） */
    public var angle : CGFloat = 0.0
    
    /** 样式 */
    public var type : CBPolygonType = CBPolygonType.polygon
    
    //MARK: - 私有属性
    /** 百分比 */
    private var percent : [CGFloat] = []
    
    /** 边数 */
    private var side : Int = 0
    
    /** 大圆边长 */
    private var radius : CGFloat = 0.0
    
    /** 圆上顶点坐标 */
    private var maxApexs : [CGPoint] = []
    
    /** 多边形顶点坐标 */
    private var apexs : [CGPoint] = []
    
    /** 标题 */
    private var titles : [String]?
    
    /** 标题中心点位置 */
    private var titleCenter : [CGPoint] = []

    private var myCenter : CGPoint = CGPoint.init(x: 0, y: 0)
//************************************************************************
//************************************************************************
    //MARK: - func
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        self.myCenter = CGPoint.init(x: frame.width/2.0, y: frame.height/2.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func cb_drawPolygon(percent aPercent : [CGFloat], titles aTitles : [String], radius aRadius : CGFloat) {
        if aPercent.count < 3 {
            print("边数要大于3才能画能力图")
            return
        }
        self.percent = aPercent
        self.side = aPercent.count
        self.radius = aRadius
        self.titles = aTitles
        getAllPoint()
    }
    
    private func getAllPoint() {
        let a = CGFloat.pi * 2.0/CGFloat(self.side)
        for i in 0..<self.side {
            let x1 = self.myCenter.x + (cos(a * CGFloat(i) + self.angle) * self.radius)
            let y1 = self.myCenter.y - (sin(a * CGFloat(i) + self.angle) * self.radius)
            self.maxApexs.append(.init(x: x1, y: y1))
            
            
            let x2 = x1 * self.percent[i] + self.myCenter.x * (1-self.percent[i])
            let y2 = y1 * self.percent[i] + self.myCenter.y * (1-self.percent[i])
            self.apexs.append(.init(x: x2, y: y2))
            
            if (self.titles != nil) {
                if self.titles!.count > 0 {
                    let x3 = self.myCenter.x + (cos(a * CGFloat(i) + self.angle) * (self.radius + self.titleDistance))
                    let y3 = self.myCenter.y - (sin(a * CGFloat(i) + self.angle) * (self.radius + self.titleDistance))
                    self.titleCenter.append(.init(x: x3, y: y3))                    
                }
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        context.setLineWidth(self.circleLineWidth)
        context.setStrokeColor(self.circleLineColor.cgColor)
        if self.circleType == .dotted {
            context.setLineDash(phase: 0, lengths: [2])
        }
        
        switch self.type {
        case .circle:
            context.addArc(center: self.myCenter, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise:true)
            context.drawPath(using: .stroke)
            
            for percent in self.circles {
                context.addArc(center: self.myCenter, radius: radius * percent, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise:true)
                context.drawPath(using: .stroke)
            }
            break
        case .polygon:
            context.addLines(between: self.maxApexs)
            context.closePath()
            context.drawPath(using: .stroke)
            
            
            for percent in self.circles {
                var apexPoints : [CGPoint] = []
                for apex in self.maxApexs {
                    apexPoints.append(.init(x: self.myCenter.x * (1-percent) + apex.x * percent, y:self.myCenter.y * (1-percent) +  apex.y * percent))
                }
                context.addLines(between: apexPoints)
                context.closePath()
                context.drawPath(using: .stroke)
            }
            break
        }
        
        
        
        context.restoreGState()
        //中心点与圆上顶点连线
        context.setLineWidth(self.centerLineWidth)
        context.setStrokeColor(self.centerLineColor.cgColor)
        context.setLineWidth(2)
        context.setStrokeColor(UIColor.init(white: 1, alpha: 0.5).cgColor)
        for maxApex in self.maxApexs {
            context.addLines(between: [self.myCenter, maxApex])
            context.drawPath(using: .stroke)
        }
        
        //多边形
        context.setLineWidth(self.lineWidth)
        context.setStrokeColor(self.lineColor.cgColor)
        context.addLines(between: self.apexs)
        context.closePath()
        if self.fillColor == nil {
            context.drawPath(using: .stroke)
        } else {
            context.setFillColor(self.fillColor!.cgColor)
            context.drawPath(using: .fillStroke)
        }
        
        //点
        for apex in self.apexs {
            if self.pointImage != nil {
                let imageView = UIImageView.init(image: self.pointImage!)
                self.addSubview(imageView)
                imageView.center = apex
            } else {
                let pointView = UIView.init()
                pointView.backgroundColor = self.pointColor
                pointView.frame = CGRect.init(origin: apex, size: CGSize.init(width: self.pointWidth, height: self.pointWidth))
                pointView.center = apex
                
                pointView.layer.cornerRadius = self.pointWidth/2.0
                self.addSubview(pointView)
            }
        }
        
        //标题
        if self.titles != nil {
            if self.titles!.count > 0 {
                for i in 0..<self.percent.count {
                    if i < self.titles!.count {
                        let titleLable = UILabel.init()
                        titleLable.font = self.titleFont
                        titleLable.textColor = self.titleColor
                        titleLable.text = self.titles![i]
                        self.addSubview(titleLable)
                        titleLable.frame = CGRect.init(origin: self.titleCenter[i], size: .init(width: 35, height: 25))
                        titleLable.sizeToFit()
                        titleLable.center = self.titleCenter[i]
                    }
                }
            }
        }
    }
}
