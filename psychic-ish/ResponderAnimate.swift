//
//  ResponderAnimate.swift
//  psychic-ish
//
//  Created by Joel Kelly on 2/13/15.
//  Copyright (c) 2015 Sunder. All rights reserved.
//

import UIKit
import QuartzCore

let ResponseAnimatorTransform:CATransform3D = {
    let rotationDegrees: CGFloat    = -15.0
    let rotationRadians: CGFloat    = rotationDegrees * (CGFloat(M_PI)/180.0)
    
    var startTransform              = CATransform3DIdentity
        startTransform              = CATransform3DRotate(CATransform3DIdentity, rotationRadians, 0.9, 0.9, 0.0)
        startTransform              = CATransform3DTranslate(startTransform, 0.0, 0.0, -0.9)
        startTransform              = CATransform3DScale(startTransform,  0.9,  0.9,  10000.0)

    return startTransform

}()


class ResponseCardAnimator {

    class func animate(cell:UIView) {
        animate(cell, animationDelay:0.0, direction: true, {})
    }

    class func animate(cell:UIView, animationDelay:Double) {
        animate(cell, animationDelay:animationDelay, direction: true, {})
    }

    class func animate(cell:UIView, animationDelay:Double, direction:Bool, completion: (() -> Void)!){
        let main                        = cell.superview!
        let view                        = cell.layer
        let transforms                  = (ResponseAnimatorTransform, CATransform3DIdentity)
        let alpha : (Float, Float)      = (0.0, 1)
        let curve                       = direction ? UIViewAnimationOptions.CurveEaseIn : UIViewAnimationOptions.CurveEaseIn
        let duration                    = direction ? 1.2 : 0.5
        let background                  = direction ? "#ecf0f1" : "#ffffff"

        view.transform                  = direction ? transforms.0 : transforms.1
        view.opacity                    = direction ? alpha.0 : alpha.1

        UIView.animateWithDuration(duration, delay: animationDelay, options: curve, animations: {


            main.backgroundColor        = UIColor(hexString: background)
            view.transform              = direction ? transforms.1 : transforms.0
            view.opacity                = direction ? alpha.1 : alpha.0

            }, completion: {
                finished in
                completion()
            })

    }
}
