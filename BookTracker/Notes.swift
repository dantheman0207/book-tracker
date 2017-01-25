//
//  Notes.swift
//  BookTracker
//
//  Created by Daniel Ransom on 10/3/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit
import SwiftyJSON

class Notes: API {
    // MARK: Properties
    var notesEndpoint: String
    public var notes = [Note]()
    public var book: Book
    var listeners = [requestListenerProtocol]()
    
    init(book: Book) {
        self.notesEndpoint = "/user/" + book.user + "/book/" + book.id + "/note/"
        self.book = book
        super.init()
    }
    
    func addListener(listener: requestListenerProtocol) {
        self.listeners.append(listener)
    }
    func getNotes() {
        self.notes = [Note]()
        
        self.fetch(url: self.notesEndpoint) { error, responseData in
            if (error) {
                print("couldn't fetch notes")
                return
            } else {
                let json = JSON(data: responseData!)
                self.processNotes(notes: json)
                self.notifyListeners()            }
        }
    
    }
    
    func notifyListeners() {
        for listener in self.listeners {
            listener.requestCompleted()
        }
    }
    
    func processNotes(notes: JSON) {
        for (index,subJson):(String, JSON) in notes {
            print("parsed note (\(index)) :")
            print(subJson)
            self.processNote(note: subJson)
        }
    }
    
    func processNote(note: JSON) {
        let id = String(note["id"].int!)
        let title = note["title"].string ?? "failed to load title"
        let content = note["content"].string ?? "failed to load content"
        let pg = note["pg"].string
        let endPg = note["endPg"].string
        
        let note = Note(title: title, content: content, id: id, pg: pg, endPg: endPg, UserId: self.book.user, BookId: self.book.id)
        
        self.add(note: note!)
    }

    func count() -> Int {
        return notes.count
    }
    
    func getNote(index: Int) -> Note {
        return notes[index]
    }
    
    func add(note: Note) {
        notes.append(note)
    }
    
    func update(note: Note, index: Int) {
        notes[index] = note
    }
    
    func remove(noteAtIndex index: Int) {
        notes.remove(at: index)
    }
}
