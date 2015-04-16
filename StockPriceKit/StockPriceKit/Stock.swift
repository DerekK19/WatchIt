//
//  AAPLStock.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation

public enum StockNotification: String {
    case priceDidChange = "StockNotification.priceDidChange"
}

public class Stock {
    
    private var symbol : String
    public var latestPrice: Double {
        get {
            return _latestPrice
        }
    }
    private var _latestPrice: Double! {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(StockNotification.priceDidChange.rawValue, object: self)
        }
    }
    
    public init (symbol: String) {
        self.symbol = symbol
        getLatest()
    }
    
    public func getLatest () {
        DataProvider().getStockQuote(
            symbol: symbol,
            onSuccess: { (price: Double) -> () in
                self._latestPrice = price
            },
            onFailure: { (error: NSError?) -> () in
                if let err = error {
                    NSLog("getStockQuote Failed:\n\(err.description)")
                }
            }
        )
    }

}