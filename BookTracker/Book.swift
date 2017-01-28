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
    public var user: String
    public var id: String
    public var lastPg: Int?
    
    init?(name: String, isbn: String?, user: String, id: String?, lastPg: Int?) {
        
        // Set props
        self.user = user
        self.displayName = name
        self.isbn = isbn
        self.lastPg = lastPg
        self.id = id ?? "NOT CREATED"

        super.init()

        if self.id == "NOT CREATED" {
            self.create()
        }        
    }
    
    func create() {
        let endpoint = "/user/" + self.user + "/book/"
        let data = self.data()
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
        if self.id != "NOT CREATED" {
            let endpoint = "/user/" + self.user + "/book/" + self.id
            let update = self.data()
            self.put(url: endpoint, update: update) {error in
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
    
    func data() -> Dictionary<String, String?> {
        var data = ["name": self.displayName]
        if let isbn = self.isbn {
            data["isbn"] = isbn
        }
        if let lastPg = self.lastPg {
            data["lastPg"] = String(lastPg)
        }
        
        return data

    }
    
    func valid(isbn: String) -> Bool {
        // add code validating isbn structure (w/ regex?)
        return true
    }
}
