//
//  AbstractRestAPI.swift
//  BookTracker
//
//  Created by Daniel Ransom on 1/19/17.
//  Copyright © 2017 Daniel Ransom. All rights reserved.
//

import Foundation
import SwiftyJSON

// implements get/post/put/delete but not JSON wrangling
class API {
    var endpoint: String
    init(url: String) {
        self.endpoint = url;
    }
    
    func fetch(url apiExtension: String, callback: @escaping (Bool, Data?) ->()) {
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
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("error calling GET on " + endpoint)
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response Code: " + String(httpResponse.statusCode))
                }
                callback(true, nil)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                callback(true, nil)
                return
            }
            callback(false, responseData);
        }
        
        task.resume()
        
    }
}
enum AbstractError: Error {
    case abstractFuncCalled
}

protocol AbstractRestAPI {
    var endpoint: String {get}
}

class AbstractAPIResponse {
    var data: AnyObject
    var json: JSON?
    init(response: AnyObject) {
        self.data = response
    }
    func subscribe( acceptJSON: @escaping(_: JSON) -> ()) throws {
        throw AbstractError.abstractFuncCalled
    }
}
extension AbstractRestAPI {
    func get(id: String) throws -> AbstractAPIResponse{
        throw AbstractError.abstractFuncCalled
    }
}

class BookAPI: API {
    override init(url: String) {
        super.init(url: url)
    }
    
    /*
 func getAll() -> [JSON]? {
        
    }
    
    func get(id:String) -> JSON? {
        let url = self.endpoint + "/" + id
        // ext
        //self.fetch(url)
        
    }
 */
}
