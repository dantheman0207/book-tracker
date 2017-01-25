//
//  Book.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/26/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Book: API {
    // MARK: Properties
    public var displayName: String
    public var isbn: String?
    public var photo: UIImage?
    public var user: String
    public var id: String
 
    init?(name: String, isbn: String?, user: String, id: String?) {
        
        // Set props
        self.user = user
        self.displayName = name
        self.id = id ?? "NOT CREATED"

        super.init()

        if self.id == "NOT CREATED" {
            self.create()
        }        
    }
    
    func create() {
        var data = ["name": self.displayName]
        if let isbn = self.isbn {
            data["isbn"] = isbn
        }
        let endpoint = "/user/" + self.user + "/book/"
        self.post(url: endpoint, data: data) { error, data in
            if (error) {
                print("error creating book at :" + endpoint)
            } else if data != nil {
                self.id = data!.string!
                print("created book with id: " + self.id)
            }
        }
    }
    
    func update() {
        var data = ["name": self.displayName]
        if let isbn = self.isbn {
            data["isbn"] = isbn
        }
        if self.id != "NOT CREATED" {
            let endpoint = "/user/" + self.user + "/book/" + self.id
            self.put(url: endpoint, update: data) {error in
                if (error) {
                    print("error updating book at " + endpoint)
                }
            }
        }
    }
    
    func deleteBook() {
        let endpoint = "/user/" + self.user + "/book/" + self.id
        self.delete(url: endpoint) {error in
            if (error) {
                print("error deleting book at " + endpoint)
            }
        }
    }
    
    func valid(isbn: String) -> Bool {
        // add code validating isbn structure (w/ regex?)
        return true
    }
}
