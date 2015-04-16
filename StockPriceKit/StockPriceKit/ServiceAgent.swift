//
//  ServiceAgent.swift
//  AAPLPriceKit
//
//  Created by Derek Knight on 16/04/15.
//  Copyright (c) 2015 Orion Health. All rights reserved.
//

import Foundation
import SwiftyJSON

internal class ServiceAgent {
    
    internal func createRequestWith(httpMethod: String, scheme: String, host: String, path: String, parameters: [String: AnyObject]) -> NSURLRequest? {
        let parameterString = parameters.stringFromHttpParameters()
        let fullURL:String = "\(scheme):\(host)\(path)?\(parameterString)"
        if let requestURL = NSURL(string: fullURL) {
            var request = NSMutableURLRequest(URL: requestURL)
            request.HTTPMethod = httpMethod
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.timeoutInterval = 5
            return request
        }
        return nil
    }
    
    internal func performRequestForJSONString(request: NSURLRequest, onSuccess: (response: String) -> (), onFailure: (error: NSError?) -> ()) {
        performRequest(
            request,
            onSuccess: { (responseData, header) -> () in
                if let bodyString = NSString(data: responseData, encoding: NSUTF8StringEncoding) {
                    onSuccess(response: bodyString as! String)
                } else {
                    // Not valid payload from the server
                    onFailure(error: nil)
                }
            },
            onFailure: { (error) -> () in
                onFailure(error: error)
            }
        )
    }

    private func performRequest(request: NSURLRequest, onSuccess: (responseData: NSData, header: [NSObject : AnyObject]) -> (), onFailure: (error: NSError?) -> ()) {
        var session = NSURLSession.sharedSession()
        var task = session.dataTaskWithRequest(
            request,
            completionHandler: { (data, response, error) -> Void in
                if error == nil {
                    if let responseValue = response as? NSHTTPURLResponse {
                        if let bodyString = NSString(data: data, encoding: NSUTF8StringEncoding) {
                            let responseString = bodyString as! String
                        }
                        if responseValue.statusCode == 200 {
                            onSuccess(responseData: data, header: responseValue.allHeaderFields)
                        } else {
                            // Response not 200
                            onFailure(error: nil)
                        }
                    } else {
                        // Dont have response
                        onFailure(error: nil)
                    }
                } else {
                    // Connection error
                    onFailure(error: error)
                }
            }
        )
        task.resume()
    }
    
}