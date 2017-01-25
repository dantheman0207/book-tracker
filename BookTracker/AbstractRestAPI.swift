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
    var endpoint: String = "https://readr-api.herokuapp.com/api"
    init() {

    }
    
    func fetch(url apiExtension: String, callback: @escaping (Bool, Data?) ->()) {
        let endpoint = self.endpoint + apiExtension
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
    
    func put(url: String, update: Dictionary<String, String?>, callback: @escaping (Bool) ->()) {
        let endpoint = self.endpoint + url
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL: " + endpoint )
            return
        }
        var urlRequest = URLRequest(url: url)
        // set up the session
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: update, options: .prettyPrinted)

        } catch {
            print("couldn't serialize update to " + endpoint)
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling PUT on " + endpoint)
                print(error!)
                callback(true)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("error calling PUT on " + endpoint)
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response Code: " + String(httpResponse.statusCode))
                }
                callback(true)
                return
            }
            callback(false);
        }
        
        task.resume()

    }
    
    func post(url: String, data: Dictionary<String, String?>, callback: @escaping (Bool, JSON?) ->()) {
        let endpoint = self.endpoint + url
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL")
            return
        }
        var urlRequest = URLRequest(url: url)
        // set up the session
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
            
        } catch {
            print("couldn't serialize creation of " + endpoint)
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling POST on " + endpoint)
                print(error!)
                callback(true, nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("error calling POST on " + endpoint)
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response Code: " + String(httpResponse.statusCode))
                }
                callback(true, nil)
                return
            }
            
            if let unwrappedData = data {
                let json = JSON(data: unwrappedData)
                print("posted return data")
                print(json)
                callback(false, json);
            } else {
                callback(true, nil)
            }
        }
        
        task.resume()
        
    }

    func delete(url: String, callback: @escaping (Bool) ->()) {
        let endpoint = self.endpoint + url
        guard let url = URL(string: endpoint) else {
            print("Error: cannot create URL: " + endpoint )
            return
        }
        var urlRequest = URLRequest(url: url)
        // set up the session
        urlRequest.httpMethod = "DELETE"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        // make the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            // check for any errors
            guard error == nil else {
                print("error calling DELETE on " + endpoint)
                print(error!)
                callback(true)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
                print("error calling DELETE on " + endpoint)
                if let httpResponse = response as? HTTPURLResponse {
                    print("HTTP Response Code: " + String(httpResponse.statusCode))
                }
                callback(true)
                return
            }
            callback(false);
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

protocol requestListenerProtocol {
    func requestCompleted()
}
