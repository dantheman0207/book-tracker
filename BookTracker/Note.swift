//
//  Note.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/27/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Note: API {
    
    // MARK: Properties
    public var title: String
    public var content: String
    public var id: String
    public var images: [UIImage]?
    public var pg: String?
    public var endPg: String?
    var BookId: String
    var UserId: String
    
    init?(title: String, content: String, id: String?, pg: String?, endPg: String?, UserId: String, BookId: String) {
        // create variables
        self.title = title
        self.content = content
        self.id = id ?? "NOT SET"
        self.pg = pg
        self.endPg = endPg
        self.UserId = UserId
        self.BookId = BookId
        
        super.init()
        
        guard (id != nil) else {
            self.create()
            return
        }
    }
    
    func create() {
        var data = ["title": self.title, "content": self.content, "pg": self.pg]
        if let endPg = self.endPg {
            data["endPg"] = endPg
        }
        
        let endpoint = "/user/" + self.UserId + "/book/" + self.BookId + "/note/"
        self.post(url: endpoint, data: data) { error, data in
            if (error) {
                print("couldn't create note at " + endpoint)
            } else {
                self.id = data!.string!
            }
        }
    }
    
    func deleteNote() {
        // MARK: TODO
        // first add delete func to API, then implement here
        let endpoint = "/user/" + self.UserId + "/book/" + self.BookId + "/note/" + self.id
        self.delete(url: endpoint) {error in
            if (error) {
                print("error deleting note at " + endpoint)
            }
        }
    }
    
    func update() {
        
        let update = ["title": self.title, "content": self.content, "pg": self.pg, "endPg": self.endPg]
        // MARK: TODO
        // extend API, implement HTTP PUT to update contents of note on server
        let endpoint = "/user/" + self.UserId + "/book/" + self.BookId + "/note/" + self.id
        self.put(url: endpoint, update: update) { error in
            if (error) {
                print("couldn't update note at " + endpoint)
            }
        }
    }
}
