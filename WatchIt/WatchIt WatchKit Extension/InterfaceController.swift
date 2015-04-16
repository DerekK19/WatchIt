//
//  InterfaceController.swift
//  WatchIt WatchKit Extension
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import WatchKit
import Foundation
import StockPriceKit

class InterfaceController: StockInterfaceController {

    private var amount = 0
    
    @IBOutlet weak var label: WKInterfaceLabel!

    private let watcher = Stock(symbol: "AAPL")
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
    }

    override init () {
        // Initialize variables here.
        super.init ()
        
        // It is now safe to access interface objects.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func didPressMe() {
        self.label.setText("Please wait...")
        watcher.getLatest()
    }
    
    func didChangePrice(note: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            let amount = self.watcher.latestPrice
            self.label.setText("$\(amount)")
        }
    }

}
