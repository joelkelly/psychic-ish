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

    init ( card:UIView, label:UILabel ){
        responseCard  = card
        responseLabel = label
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
            ResponseCardAnimator.animate(responseCard, animationDelay: 0.2, direction:false, { self.isActive ? self.answer() : self.prepare() })
            isActive = !isActive
        }
    }

    func answer(){
        self.canRespond     = false
        self.setLabel( Chooser.decider(self.responders) + Chooser.decider(self.answers) )
        ResponseCardAnimator.animate(responseCard, animationDelay:1.0, direction:true, {

            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * Int64(NSEC_PER_SEC)), dispatch_get_main_queue(), {
                self.canRespond     = true
                self.respond()
            });

        })
    }

    func prepare(){
        self.setLabel( Chooser.decider(self.preAnswers) )
        ResponseCardAnimator.animate(responseCard, animationDelay:0.5)
    }

    func setLabel(newText: String){
        responseLabel.text = newText
    }
}
