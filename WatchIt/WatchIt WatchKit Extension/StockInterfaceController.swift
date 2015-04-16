//
//  StockInterfaceController.swift
//  WatchIt
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import WatchKit
import Foundation
import StockPriceKit

class StockInterfaceController: WKInterfaceController {
    
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
        NSLog("StockInterfaceController: willActivate")
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        NSLog("StockInterfaceController: didDeactivate")
        super.didDeactivate()
    }
    
    
    func setupObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didChangePrice:", name: StockNotification.priceDidChange.rawValue, object: nil)
    }
    
    func removeObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

}
