//
//  Books.swift
//  BookTracker
//
//  Created by Daniel Ransom on 10/3/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit
import SwiftyJSON

class Books: NSObject {
    // MARK: Properties
    var booksEndpoint: String = "https://readr-api.herokuapp.com/api/user/"
    var books =  [Book]()
    var reqProtocolDelegate: requestListenerProtocol
    var user: Int?
    
    init(user: Int, reqProtocolDelegate: requestListenerProtocol) {
        // change so protocolDelegate is set after init ???
        self.reqProtocolDelegate = reqProtocolDelegate
        self.booksEndpoint += String(user) + "/book/"
        self.user = user

        super.init()
        
        self.getFromAPI()

    }
    
    func getFromAPI() {
        guard let url = URL(string: self.booksEndpoint) else {
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
                print("error calling GET on /book/")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            let json = JSON(data: responseData)
            
            for (index,subJson):(String, JSON) in json {
                //Do something you want
                print(index + " parsed book:")
                print(subJson)
            }
        }
        
        task.resume()
    }
    
    func count() -> Int {
        return books.count
    }
    
    func getBook(index: Int) -> Book {
        return books[index]
    }
    
    func add(book: Book) {
        books.append(book)
    }
    
    func update(book: Book, index: Int) {
        books[index] = book
    }
}
