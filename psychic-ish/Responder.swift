//
//  Responder.swift
//  psychic-ish
//
//  Created by Joel Kelly on 2/13/15.
//  Copyright (c) 2015 Sunder. All rights reserved.
//

import UIKit

class Responder {

    let responseLabel:UILabel!
    let responseCard:UIView!

    var preAnswers: JSON!
    var answers:    JSON!
    var responders: JSON!


    var isActive    = false
    var canRespond  = true
    var timer       = NSTimer()

    init ( card:UIView, label:UILabel ){
        responseCard    = card
        responseLabel   = label

        loadOptions("rude")
    }

    func loadOptions(timber:String){
        canRespond = false;
        ResponderModel.getWithSuccess("https://charlatan.firebaseio.com/\(timber).json" , { (jsonData) -> Void in
            var jsonData        = JSON(data: jsonData)
            self.answers        = jsonData["answers"]
            self.preAnswers     = jsonData["preAnswers"]
            self.responders     = jsonData["responders"]
            self.canRespond     = true
        })
    }

    func respond(){

        if canRespond {
            timer.invalidate()
            ResponseCardAnimator.animate(responseCard, animationDelay: 0.2, direction:false, { self.isActive ? self.answer() : self.prepare() })
            isActive = !isActive
        }
    }

    func answer(){
        canRespond     = false
        setLabel( Chooser.decider(self.responders) + Chooser.decider(self.answers) )
        ResponseCardAnimator.animate(responseCard, animationDelay:1.5, direction:true, {
            self.canRespond = true
            self.timer      = NSTimer.scheduledTimerWithTimeInterval(4.5, target: self, selector: Selector("respond"), userInfo: nil, repeats: false)

        })
    }

    func prepare(){
        setLabel( Chooser.decider(self.preAnswers) )
        ResponseCardAnimator.animate(responseCard, animationDelay:0.5)
    }

    func setLabel(newText: String){
        responseLabel.text = newText
    }
}
