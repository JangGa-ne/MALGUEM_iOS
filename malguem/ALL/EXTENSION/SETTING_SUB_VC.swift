//
//  SETTING_SUB_VC.swift
//  malguem
//
//  Created by 부산광역시교육청 on 2021/05/06.
//

import UIKit

//MARK: CUSTOM 슬라이드 애니메이션 애니메이션
class SETTING_SUB_VC: NSObject, UIViewControllerAnimatedTransitioning {
    
    var ANIMATION: CGFloat = 0.0
    
    var X = false
    var Y = false
    var OPACITY = false
    var IS_PRESENTING = false
    
    let DIMMING_VIEW = UIButton()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(ANIMATION)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let TO_VC = transitionContext.viewController(forKey: .to), let FROM_VC = transitionContext.viewController(forKey: .from) else { return }
        
        let CONTAINER_VIEW = transitionContext.containerView
        
        let FINAL_WIDTH = TO_VC.view.bounds.width
        let FINAL_HEIGHT = TO_VC.view.bounds.height
        
        if IS_PRESENTING {
            
            DIMMING_VIEW.backgroundColor = .black
            DIMMING_VIEW.alpha = 0.0
            DIMMING_VIEW.frame = CONTAINER_VIEW.bounds
            CONTAINER_VIEW.addSubview(DIMMING_VIEW)
            
            if X { TO_VC.view.frame = CGRect(x: -FINAL_WIDTH, y: 0.0, width: FINAL_WIDTH, height: FINAL_HEIGHT) }
            if Y { TO_VC.view.frame = CGRect(x: 0.0, y: FINAL_HEIGHT, width: FINAL_WIDTH, height: FINAL_HEIGHT) }
            if OPACITY { TO_VC.view.frame = CGRect(x: 0.0, y: 0.0, width: FINAL_WIDTH, height: FINAL_HEIGHT) }
            CONTAINER_VIEW.addSubview(TO_VC.view)
        }
            
//        let DURATION = transitionDuration(using: transitionContext)
        let IS_CANCELLED = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: TimeInterval(ANIMATION), animations: {
            
            if self.OPACITY {
                
                let TRANSFORM = { TO_VC.view.alpha = 1.0 }
                let IDENTITY = { FROM_VC.view.alpha = 0.0 }
                
                self.IS_PRESENTING ? TRANSFORM() : IDENTITY()
            } else {
                
                let TRANSFORM = {
                    self.DIMMING_VIEW.alpha = self.ANIMATION
                    if self.X { TO_VC.view.transform = CGAffineTransform(translationX: FINAL_WIDTH, y: 0.0) }
                    if self.Y { TO_VC.view.transform = CGAffineTransform(translationX: 0.0, y: -FINAL_HEIGHT) }
                }
                let IDENTITY = { self.DIMMING_VIEW.alpha = 0.0; FROM_VC.view.transform = .identity }
                
                self.IS_PRESENTING ? TRANSFORM() : IDENTITY()
            }
        }) { (_) in
            transitionContext.completeTransition(!IS_CANCELLED)
        }
    }
}

//MARK: AS 현황
extension AS_RECEIPT: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TRANSITION.ANIMATION = 0.2
        TRANSITION.IS_PRESENTING = true
        TRANSITION.OPACITY = true
        return TRANSITION
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TRANSITION.ANIMATION = 0.2
        TRANSITION.IS_PRESENTING = false
        TRANSITION.OPACITY = true
        return TRANSITION
    }
}

//MARK: 결제수단등록 (서명)
extension PAYMENT_ADD: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TRANSITION.ANIMATION = 0.2
        TRANSITION.IS_PRESENTING = true
        TRANSITION.Y = true
        return TRANSITION
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        TRANSITION.ANIMATION = 0.2
        TRANSITION.IS_PRESENTING = false
        TRANSITION.Y = true
        return TRANSITION
    }
}
