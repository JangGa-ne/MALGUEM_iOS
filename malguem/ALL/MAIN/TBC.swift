//
//  TBC.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/04/30.
//

import UIKit

class TBC: UITabBarController {
    
    var APPDELEGATE = UIViewController.APPDELEGATE
    var OBJ_PLANT = UIViewController.APPDELEGATE.OBJ_PLANT
    
    var EF_VIEW = UIVisualEffectView()
    
    var P_NAME = UILabel()
    var P_ADDRESS = UILabel()
    
    var BACK_BG = UIView()
    var NEXT_BG = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) { overrideUserInterfaceStyle = .light }
        tabBar.barTintColor = .white
        delegate = self
        
        let H_STACK = UIStackView()
        H_STACK.axis = .horizontal
        H_STACK.alpha = 1.0
        EF_VIEW.contentView.addSubview(H_STACK)
        H_STACK.translatesAutoresizingMaskIntoConstraints = false
        H_STACK.leadingAnchor.constraint(equalTo: EF_VIEW.contentView.leadingAnchor).isActive = true
        H_STACK.trailingAnchor.constraint(equalTo: EF_VIEW.contentView.trailingAnchor).isActive = true
        H_STACK.topAnchor.constraint(equalTo: EF_VIEW.contentView.topAnchor, constant: 5.0).isActive = true
        H_STACK.bottomAnchor.constraint(equalTo: EF_VIEW.contentView.bottomAnchor, constant: -10.0).isActive = true
        
/// 이전 발전소
        BACK_BG.backgroundColor = .clear
        BACK_BG.frame.size.width = 120.0
        BACK_BG.frame.size.height = 60.0
        BACK_BG.alpha = 0.0
        H_STACK.addArrangedSubview(BACK_BG)
        BACK_BG.translatesAutoresizingMaskIntoConstraints = false
        BACK_BG.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        BACK_BG.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        let BACK_IMAGE = UIImageView()
        BACK_IMAGE.image = UIImage(named: "back.png")
        BACK_IMAGE.alpha = 1.0
        BACK_BG.addSubview(BACK_IMAGE)
        BACK_IMAGE.translatesAutoresizingMaskIntoConstraints = false
        BACK_IMAGE.centerYAnchor.constraint(equalTo: BACK_BG.centerYAnchor).isActive = true
        BACK_IMAGE.leadingAnchor.constraint(equalTo: BACK_BG.leadingAnchor, constant: 20.0).isActive = true
        BACK_IMAGE.widthAnchor.constraint(equalToConstant: 12.0).isActive = true
        BACK_IMAGE.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        let BACK_ACTION = UIButton()
        BACK_ACTION.alpha = 1.0
        BACK_ACTION.tag = 0
        BACK_ACTION.addTarget(self, action: #selector(PLANT(_:)), for: .touchUpInside)
        BACK_BG.addSubview(BACK_ACTION)
        BACK_ACTION.translatesAutoresizingMaskIntoConstraints = false
        BACK_ACTION.leftAnchor.constraint(equalTo: BACK_BG.leftAnchor).isActive = true
        BACK_ACTION.rightAnchor.constraint(equalTo: BACK_BG.rightAnchor).isActive = true
        BACK_ACTION.topAnchor.constraint(equalTo: BACK_BG.topAnchor).isActive = true
        BACK_ACTION.bottomAnchor.constraint(equalTo: BACK_BG.bottomAnchor).isActive = true
        
/// 발전소 정보
        let V_STACK = UIStackView()
        V_STACK.axis = .vertical
        V_STACK.alpha = 1.0
        H_STACK.addArrangedSubview(V_STACK)
/// 발전소 이름
        if OBJ_PLANT.count != 0 {
            let DATA = OBJ_PLANT[APPDELEGATE.P_POSITION]
            if DATA.P_NAME == "" { P_NAME.text = "-" } else { P_NAME.text = DATA.P_NAME }
        }
        P_NAME.font = .systemFont(ofSize: 18.0)
        P_NAME.textAlignment = .center
        P_NAME.textColor = .black
        P_NAME.alpha = 1.0
        V_STACK.addArrangedSubview(P_NAME)
/// 발전소 주소
        if OBJ_PLANT.count != 0 {
            let DATA = OBJ_PLANT[APPDELEGATE.P_POSITION]
            if DATA.P_ADDRESS == "" { P_ADDRESS.text = "-" } else { P_ADDRESS.text = DATA.P_ADDRESS }
        }
        P_ADDRESS.font = .systemFont(ofSize: 10.0)
        P_ADDRESS.textAlignment = .center
        P_ADDRESS.textColor = .black
        P_ADDRESS.alpha = 0.7
        V_STACK.addArrangedSubview(P_ADDRESS)
        
/// 다음 발전소
        NEXT_BG.backgroundColor = .clear
        if OBJ_PLANT.count > 1 { NEXT_BG.alpha = 1.0 } else { NEXT_BG.alpha = 0.0 }
        H_STACK.addArrangedSubview(NEXT_BG)
        NEXT_BG.translatesAutoresizingMaskIntoConstraints = false
        NEXT_BG.widthAnchor.constraint(equalToConstant: 80.0).isActive = true
        NEXT_BG.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        
        let NEXT_IMAGE = UIImageView()
        NEXT_IMAGE.image = UIImage(named: "next.png")
        NEXT_IMAGE.alpha = 1.0
        NEXT_BG.addSubview(NEXT_IMAGE)
        NEXT_IMAGE.translatesAutoresizingMaskIntoConstraints = false
        NEXT_IMAGE.centerYAnchor.constraint(equalTo: NEXT_BG.centerYAnchor).isActive = true
        NEXT_IMAGE.trailingAnchor.constraint(equalTo: NEXT_BG.trailingAnchor, constant: -20.0).isActive = true
        NEXT_IMAGE.widthAnchor.constraint(equalToConstant: 12.0).isActive = true
        NEXT_IMAGE.heightAnchor.constraint(equalToConstant: 20.0).isActive = true
        
        let NEXT_ACTION = UIButton()
        NEXT_ACTION.alpha = 1.0
        NEXT_ACTION.tag = 1
        NEXT_ACTION.addTarget(self, action: #selector(PLANT(_:)), for: .touchUpInside)
        NEXT_BG.addSubview(NEXT_ACTION)
        NEXT_ACTION.translatesAutoresizingMaskIntoConstraints = false
        NEXT_ACTION.leftAnchor.constraint(equalTo: NEXT_BG.leftAnchor).isActive = true
        NEXT_ACTION.rightAnchor.constraint(equalTo: NEXT_BG.rightAnchor).isActive = true
        NEXT_ACTION.topAnchor.constraint(equalTo: NEXT_BG.topAnchor).isActive = true
        NEXT_ACTION.bottomAnchor.constraint(equalTo: NEXT_BG.bottomAnchor).isActive = true
        
        ON()
    }
    
/// 발전소 선택
    @objc func PLANT(_ sender: UIButton) {
        
        UIImpactFeedbackGenerator().impactOccurred()
        
        if sender.tag == 0 { APPDELEGATE.P_POSITION -= 1 } else { APPDELEGATE.P_POSITION += 1 }
        
        if APPDELEGATE.P_POSITION > 0 { BACK_BG.alpha = 1.0 } else { BACK_BG.alpha = 0.0 }
        if APPDELEGATE.P_POSITION < OBJ_PLANT.count - 1 { NEXT_BG.alpha = 1.0 } else { NEXT_BG.alpha = 0.0 }
        
        let DATA = OBJ_PLANT[APPDELEGATE.P_POSITION]
        if DATA.P_NAME == "" { P_NAME.text = "-" } else { P_NAME.text = DATA.P_NAME }
        if DATA.P_ADDRESS == "" { P_ADDRESS.text = "-" } else { P_ADDRESS.text = DATA.P_ADDRESS }
        
        REFRESH()
    }
}

extension TBC: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        UIImpactFeedbackGenerator().impactOccurred()
        
        if selectedIndex == 1 || selectedIndex == 2 || selectedIndex == 3 { ON() } else { OFF() }
        
        REFRESH()
    }
    
    func REFRESH() {
        
        let DATA = OBJ_PLANT[APPDELEGATE.P_POSITION]
/// 알림
        if selectedIndex == 0 {
            APPDELEGATE.NOTICE_VC?.NETWORK_CHECK(UPDATE: false)
/// 인버터 운행 현황
        } else if selectedIndex == 1 {
            APPDELEGATE.INVERTER_VC?.I_POSITION = 0
            APPDELEGATE.INVERTER_VC?.P_CODE = DATA.P_CODE
            APPDELEGATE.INVERTER_VC?.NETWORK_CHECK()
/// 통합 모니터링
        } else if selectedIndex == 2 {
            APPDELEGATE.MONITORING_VC?.NETWORK_CHECK()
/// 기간 발전량
        } else if selectedIndex == 3 {
            APPDELEGATE.CHART_VC?.P_CODE = DATA.P_CODE
            APPDELEGATE.CHART_VC?.CHART_VIEW.resetZoom()
            APPDELEGATE.CHART_VC?.NETWORK_CHECK()
/// AS 현황
        } else if selectedIndex == 4 {
            APPDELEGATE.AS_RECEIPT_VC?.NETWORK_CHECK()
        }
    }
    
    func ON() {
        
        EF_VIEW.effect = UIBlurEffect(style: .light)
        EF_VIEW.alpha = 1.0
        view.addSubview(EF_VIEW)
        
        EF_VIEW.translatesAutoresizingMaskIntoConstraints = false
        EF_VIEW.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        EF_VIEW.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        EF_VIEW.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -0.5).isActive = true
        EF_VIEW.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
    }
    
    func OFF() {
        
        EF_VIEW.alpha = 0.0
        EF_VIEW.removeFromSuperview()
    }
}

