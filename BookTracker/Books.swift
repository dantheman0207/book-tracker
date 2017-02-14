//
//  Books.swift
//  BookTracker
//
//  Created by Daniel Ransom on 10/3/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit
import SwiftyJSON

class Books: API {
    // MARK: Properties
    var booksEndpoint: String = "/user/"
    var books =  [Book]()
    var reqProtocolDelegate: requestListenerProtocol
    var user: String?
    
    init(user: String, reqProtocolDelegate: requestListenerProtocol) {
        // change so protocolDelegate is set after init ???
        self.reqProtocolDelegate = reqProtocolDelegate
        self.booksEndpoint += String(user) + "/book/"
        self.user = user

        // find a better way to store this global app constant
        super.init()
        
        self.getBooks()

    }
    
    func getBooks() {
        self.books = [Book]()
        self.fetch(url: self.booksEndpoint) {error,responseData in
            if (error) {
                print("couldn't fetch books")
                // call completionHandler cause I guess we're done here
                self.reqProtocolDelegate.requestCompleted()
                return
            } else {
                // parse the result as JSON, since that's what the API provides
                let json = JSON(data: responseData!)
                
                self.processBooks(books: json)
                
                // notify view controller that our data is new
                self.reqProtocolDelegate.requestCompleted()
            }
        }
    }
    
    func processBooks(books: JSON) {
        for (index,subJson):(String, JSON) in books {
            //Do something you want
            print("parsed book (\(index)) :")
            print(subJson)
            self.processBook(book: subJson)
        }
    }
    
    func processBook(book: JSON) {
        let bookName = book["name"].string ?? ""
        let isbn = book["isbn"].string
        let userID = String(book["UserId"].int!)
        let id = String(book["id"].int!)
        let lastPg = book["lastPg"].int
        
        let bookInstance = Book(name: bookName, isbn: isbn, user: userID, id: id, lastPg: lastPg)!
        add(book: bookInstance)
        
    }
    
    func count() -> Int {
        return books.count
    }
    
    func getBook(index: Int) -> Book {
        return books[index]
    }
    
    func removeBook(index: Int) {
        self.books[index].deleteBook()
        self.books.remove(at: index)
    }
    
    func add(book: Book) {
        books.append(book)
    }
    
    func update(book: Book, index: Int) {
        books[index] = book

    }
}
