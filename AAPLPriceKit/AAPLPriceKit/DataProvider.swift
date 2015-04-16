//
//  DataProvider.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation

class DataProvider {
    
    func getAAPLPrice(#onSuccess: (price: Double) -> (), onFailure: (error: NSError?) -> ()) {
        AAPLServiceAgent().getAAPLSharePrice(
            onSuccess: { (quote: Quote) -> () in
                if let ask = quote.ask {
                    onSuccess(price: ask)
                }
            },
            onFailure: { (error: NSError?) -> () in
                onFailure(error: error)
            }
        )
    }
    
}