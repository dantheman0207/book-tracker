//
//  Books.swift
//  BookTracker
//
//  Created by Daniel Ransom on 10/3/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

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
                print("error calling GET on /todos/1")
                print(error!)
                return
            }
            // make sure we got data
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let books = try JSONSerialization.jsonObject(with: responseData, options: []) as? [[String: Any]] else {
                    print("error trying to convert data to JSON")
                    return
                }
                
                if let firstBook = books[0]["id"] as? String {
                    print("the first book's id: " + firstBook)
                }
                else {
                    print("error getting id of first book")
                }
                
                // now we have the todo, let's just print it to prove we can access it
                print("The todo is: " + String(describing: books))
                
            } catch  {
                print("error trying to convert data to JSON")
                return
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
