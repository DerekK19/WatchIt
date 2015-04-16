//
//  GlanceController.swift
//  WatchIt WatchKit Extension
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import WatchKit
import Foundation
import AAPLPriceKit

class GlanceController: WKInterfaceController {

    @IBOutlet weak var label: WKInterfaceLabel!
    
    private let watcher = AAPLStock()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }
    
    override init () {
        // Initialize variables here.
        super.init ()
        
        // It is now safe to access interface objects.
        setupObservers()
    }
    
    deinit {
        removeObservers()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        NSLog("GlanceController: willActivate")
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("GlanceController: didDeactivate")
        super.didDeactivate()
    }
    
    func didChangePrice(note: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            let amount = self.watcher.currentPrice()
            self.label.setText("$\(amount)")
        }
    }

    
    func setupObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didChangePrice:", name: AAPLPriceNotification.didChange.rawValue, object: nil)
    }
    
    func removeObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}