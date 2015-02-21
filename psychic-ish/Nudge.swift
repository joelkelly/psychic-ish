//
//  Responder.swift
//  psychic-ish
//
//  Created by Joel Kelly on 2/13/15.
//  Copyright (c) 2015 Sunder. All rights reserved.
//

import UIKit

class Nudge {

    let nudgeLabel      :UILabel!
    let nudgeCard       :UIView!

    var isActive    = false
    var timer       = NSTimer()
    var nudgeCount  = 3

    var nudges:JSON!

    init ( card:UIView, label:UILabel ){//, nudgeText:JSON ){
        nudgeCard       = card
        nudgeLabel      = label

        nudgeCard.layer.opacity = 0.0
//        loadCopy(nudgeText)

    }

    func loadCopy(nudgeText:JSON){
        nudges          = nudgeText
    }

    func startNudging(){
        nudgeCard.layer.opacity = 0.0
        timer  = NSTimer.scheduledTimerWithTimeInterval(15.0, target: self, selector: Selector("nudge"), userInfo: nil, repeats: false)
    }

    func stopNudging(){
        timer.invalidate()
        if isActive {
            ResponseCardAnimator.animate(nudgeCard, animationDelay: 0.2, direction:false, {
                self.isActive = false
            })
        }
    }

    @objc func nudge(){

        setLabel( "Maybe you should share this ... or not ... whatever" )//Chooser.decider(self.nudges) )
        ResponseCardAnimator.animate(nudgeCard, animationDelay: 0.0, direction:true, {
            self.isActive = true
        })

    }


    func setLabel(newText: String){
        nudgeLabel.text = newText
    }

}
