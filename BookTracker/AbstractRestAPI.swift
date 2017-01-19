//
//  AbstractRestAPI.swift
//  BookTracker
//
//  Created by Daniel Ransom on 1/19/17.
//  Copyright © 2017 Daniel Ransom. All rights reserved.
//

import Foundation

// implements get/post/put/delete but not JSON wrangling
class API {
    var endpoint: String
    init(url_base: String) {
        self.endpoint = url_base;
    }
    
    func get(url apiExtension: String, callback: @escaping (Bool, AnyObject?) ->()) {
        var endpoint = self.endpoint + apiExtension
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        let urlRequest = URLRequest(url: url)
        // set up the session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling GET on " + endpoint)
                print(error!)
                callback(true, nil)
                return
            }
            guard 200...299 = response.statusCode else {
                print("error calling GET on " + endpoint)
                print("HTTP Response Code: " + response.statusCode)
                callback(true, nil)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                callback(true, nil)
                return
            }
            callback(false, responseData as AnyObject);
        }
        
        task.resume()
        
    }
}

protocol AbstractRestAPI {
    var endpoint: String {get}
}

extension AbstractRestAPI {
    get(id) {
    return
    }
}

class BookAPI: AbstractRestApi {
    // MARK: Properties
    let endpoint: String
    
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    
    func get(id) {
        
    }
}
