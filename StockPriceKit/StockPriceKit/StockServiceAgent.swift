//
//  AAPLServiceAgent.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

class StockServiceAgent : ServiceAgent {
    
    internal func getStockQuote (#symbol: String, onSuccess: (quote: Quote) -> (), onFailure: (error: NSError?) -> ()) {
        
        /*
        
        https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20yahoo.finance.quotes%20where%20symbol%20in%20(%22AAPL%22)%0A%09%09&format=json&diagnostics=true&env=http%3A%2F%2Fdatatables.org%2Falltables.env&callback=
        */
        let root = "/v1/public/yql"
        let parameters = [
            "q": "select * from yahoo.finance.quotes where symbol in (\"\(symbol)\")",
            "format" : "json",
            "diagnostics" : "true",
            "env" : "http://datatables.org/alltables.env",
            "callback" : ""
        ]
        if let request = createRequestWith("GET", scheme: "https", host: "query.yahooapis.com", path:root, parameters: parameters) {
            
            performRequestForJSONString(
                request,
                onSuccess: { (response: String) -> () in
                    if let feed = Mapper<Feed>().map(response) {
                        if let quote = feed.query?.results?.quote {
                            onSuccess(quote: quote)
                        }
                    }
                },
                onFailure: { (error: NSError?) -> () in
                    onFailure(error: error)
                }
            )
        }
        
    }
}