//
//  InterfaceController.swift
//  WatchIt WatchKit Extension
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    private var amount = 0
    
    @IBOutlet weak var label: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }

    override init () {
        // Initialize variables here.
        super.init ()
        
        // It is now safe to access interface objects.
        showPrice()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        NSLog("InterfaceController: willActivate")
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("InterfaceController: didDeactivate")
        super.didDeactivate()
    }

    @IBAction func didPressMe() {
        amount += 10
        showPrice()
    }
    
    private func showPrice() {
        label.setText("$\(amount)")
    }

}
