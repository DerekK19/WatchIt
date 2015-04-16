//
//  AAPLStock.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation

public enum AAPLPriceNotification: String {
    case didChange = "AAPLPriceNotification.didChange"
}

public class AAPLStock {
    
    private var latestPrice: Double! {
        didSet {
            NSNotificationCenter.defaultCenter().postNotificationName(AAPLPriceNotification.didChange.rawValue, object: self)
        }
    }
    
    public init () {
        DataProvider().getAAPLPrice(
            onSuccess: { (price: Double) -> () in
                self.latestPrice = price
            },
            onFailure: { (error: NSError?) -> () in
                NSLog("getAAPLPrice Failed:\n\(error?.description)")
            }
        )
    }
    
    public func currentPrice() -> Double {
        return latestPrice
    }

}