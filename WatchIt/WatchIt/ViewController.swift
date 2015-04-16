//
//  ViewController.swift
//  WatchIt
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import UIKit
import StockPriceKit

class ViewController: UIViewController {

    @IBOutlet weak var priceLabel: UILabel!
    
    private let watcher = Stock(symbol: "AAPL")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        priceLabel.text = "Please Wait..."

    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        setupObservers()
    }
    
    override func viewDidDisappear(animated: Bool) {
        
        removeObservers()
        
        super.viewDidDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func didChangePrice(note: NSNotification) {
        dispatch_async(dispatch_get_main_queue()) {
            let amount = self.watcher.latestPrice
            self.priceLabel.text = "$\(amount)"
        }
    }
    
    func setupObservers() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "didChangePrice:", name: StockNotification.priceDidChange.rawValue, object: nil)
    }
    
    func removeObservers() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

