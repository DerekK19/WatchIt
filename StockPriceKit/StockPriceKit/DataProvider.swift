//
//  DataProvider.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation

class DataProvider {
    
    func getStockQuote(#symbol: String, onSuccess: (price: Double) -> (), onFailure: (error: NSError?) -> ()) {
        StockServiceAgent().getStockQuote(
            symbol: symbol,
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