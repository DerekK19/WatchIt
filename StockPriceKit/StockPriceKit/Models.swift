//
//  Stock.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation
import ObjectMapper

class Feed: Mappable {
    
    var query: Query?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    init() {}
    
    // Mapper
    func mapping(map: Map) {
        query <- map["query"]
    }
}

class Query: Mappable {
    
    var results: Results?
    
    required init?(_ map: Map) {
        mapping(map)
    }
    init() {}
    
    // Mapper
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class Results: Mappable {
    
    var quote: Quote?

    required init?(_ map: Map) {
        mapping(map)
    }
    init() {}
    
    // Mapper
    func mapping(map: Map) {
        quote <- map["quote"]
    }
}

class Quote: Mappable {
    
    var _ask: String?
    var _bid: String?
    
    var ask: Double? {
        get { return _ask != nil ? (_ask! as NSString).doubleValue : nil }
    }
    var bid: Double? {
        get { return _bid != nil ? (_bid! as NSString).doubleValue : nil }
    }

    
    required init?(_ map: Map) {
        mapping(map)
    }
    init() {}
    
    // Mapper
    func mapping(map: Map) {
        _ask <- map["Ask"]
        _bid <- map["Bid"]
    }
}