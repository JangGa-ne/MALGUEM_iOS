//
//  ROUNDVIEW.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/01.
//

import UIKit

class RoundView: UIView {
    
    var LINE: CGFloat = 50.0
    var RADIUS: CGFloat = 2.5
    var RANGE: CGFloat = 0
    var CURRENT_VALUE: CGFloat = 0 { didSet { ANIMATE_SHAPE_LAYER() } }
    
    let BG_LAYER = CAShapeLayer()           // 배경
    let FG_LAYER = CAShapeLayer()           // 전경
    let GD_COLOR = CAGradientLayer()        // 전경(그라데이션)
    
    var ON_OFF: Bool = false
    var ERROR: Bool = false
    
    func SETUP() {
        
        BG_LAYER.fillColor = nil
        BG_LAYER.strokeStart = 0.0
        BG_LAYER.strokeEnd = 1.0
        BG_LAYER.frame = bounds
        layer.addSublayer(BG_LAYER)
        
        FG_LAYER.lineCap = .butt
        FG_LAYER.strokeColor = UIColor.GRAY_F1F1F1.cgColor
        FG_LAYER.fillColor = nil
        FG_LAYER.strokeStart = 0.0
        FG_LAYER.strokeEnd = 0.0
        FG_LAYER.frame = bounds
/// 그라데이션
        GD_COLOR.startPoint = CGPoint(x: 0, y: 0)
        GD_COLOR.endPoint = CGPoint(x: 1, y: 0)
        GD_COLOR.frame.size = CGSize(width: bounds.size.width + 40.0, height: bounds.size.height + 40.0)
        GD_COLOR.mask = FG_LAYER
        BG_LAYER.addSublayer(GD_COLOR)
    }
    
//MARK: 뷰 변경시 그리기
    func CONFIGURE_SHAPE_LAYER(SHAPE: CAShapeLayer) {
        
        SHAPE.frame = bounds
        let START = DEGRESS_TO_RADIANS(VALUE: -180.0)
        let END = DEGRESS_TO_RADIANS(VALUE: 0.0)
        let CENTER = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
        let RADIUS = CGFloat(signOf: bounds.size.width / RADIUS, magnitudeOf: bounds.size.height / RADIUS)
        let PATH = UIBezierPath(arcCenter: CENTER, radius: RADIUS, startAngle: START, endAngle: END, clockwise: true)
        SHAPE.path = PATH.cgPath
    }
    
//MARK: 레이아웃 구성
    override func layoutSubviews() {
        super.layoutSubviews()
        
        CONFIGURE_SHAPE_LAYER(SHAPE: BG_LAYER)
        CONFIGURE_SHAPE_LAYER(SHAPE: FG_LAYER)
    }
    
    override func prepareForInterfaceBuilder() {
        SETUP()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        SETUP()
    }
    
// MARK: 애니메이션
    func ANIMATE_SHAPE_LAYER() {
        
        BG_LAYER.lineWidth = LINE
        FG_LAYER.lineWidth = LINE
        
        if ON_OFF {
            if !ERROR {
                if UIViewController.APPDELEGATE.APP_NAME.contains("SEORAK") {
                    GD_COLOR.colors = [ UIColor.SEORAK_1.cgColor, UIColor.SEORAK_2.cgColor ]
                } else if UIViewController.APPDELEGATE.APP_NAME.contains("MALGUEM") {
                    GD_COLOR.colors = [ UIColor.MALGUEM_1.cgColor, UIColor.MALGUEM_2.cgColor, UIColor.MALGUEM_3.cgColor ]
                }
            } else {
                GD_COLOR.colors = [ UIColor.ERROR_1.cgColor, UIColor.ERROR_2.cgColor, UIColor.ERROR_3.cgColor, UIColor.ERROR_4.cgColor, UIColor.ERROR_5.cgColor ]
            }
        } else {
            GD_COLOR.colors = [ UIColor.darkGray.cgColor, UIColor.gray.cgColor, UIColor.lightGray.cgColor ]
        }
        
        var FROM = FG_LAYER.strokeEnd
        let TO = CURRENT_VALUE / RANGE
        
        if let PRESENT = FG_LAYER.presentation() { FROM = PRESENT.strokeEnd }
        
        let DURATION = 1.0
        
        let ANIMATION = CABasicAnimation(keyPath: "strokeEnd")
        ANIMATION.fromValue = FROM
        ANIMATION.toValue = TO
        ANIMATION.duration = DURATION
        
        FG_LAYER.removeAnimation(forKey: "stroke")
        FG_LAYER.add(ANIMATION, forKey: "stroke")
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        FG_LAYER.strokeEnd = TO
        CATransaction.commit()
    }
}

func DEGRESS_TO_RADIANS (VALUE: CGFloat) -> CGFloat {
    return VALUE * CGFloat(Double.pi) / 180.0
}

func RADIANS_TO_DEGRESS (VALUE: CGFloat) -> CGFloat {
    return VALUE * 180.0 / CGFloat(Double.pi)
}
