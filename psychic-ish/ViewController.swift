//
//  ViewController.swift
//  psychic-ish
//
//  Created by Joel Kelly on 2/13/15.
//  Copyright (c) 2015 Sunder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ResponseCard: UIView!
    @IBOutlet weak var ResponseLabel: UILabel!

    var responder:Responder!

    override func viewDidLoad() {

        super.viewDidLoad()
        responder = Responder(card: ResponseCard, label: ResponseLabel)

    }


    @IBAction func viewTapped(sender : AnyObject) {
        responder.respond()
    }

    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if (motion == .MotionShake) { responder.respond() }
    }

}

