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
    var books =  [Book]()
    var reqProtocolDelegate: requestListenerProtocol
    var user: Int?
    
    init(user: Int, reqProtocolDelegate: requestListenerProtocol) {
        // change so protocolDelegate is set after init ???
        self.reqProtocolDelegate = reqProtocolDelegate
        self.user = user
        super.init()

        if ENSession.shared().isAuthenticated {
            load() {
                // notify protocol delegates
                self.reqProtocolDelegate.requestCompleted()
                // for book in books { book.notifyProtocolDelegates() }
            }
        }
    }
    
    func load(closure: @escaping () -> Void ) {
        // @TODO: change to load all notes
        // @TODO:  then for each note in notes, processNote(note)
        
        // Load all Evernote notebooks w/ 'notetakr-' prefix
        ENSession.shared().listNotebooks() {
            if let error = $0.1 {
                print("Error fetching Evernote notebooks....\n" + error.localizedDescription)
            } else if var notebooks = $0.0 {
                notebooks = notebooks.filter({ (i) -> Bool in
                    let notebook = i as! ENNotebook
                    return notebook.name.hasPrefix("notetakr-")
                })
                
                for i in notebooks {
                    let notebook = i as! ENNotebook
                    let book = Book(notebook: notebook)!
                    self.books.append(book)
                }
                closure()
            }
        }
    }
    
    func processNote(noteRef: ENNoteRef) {
        // @TODO: download note
        // @TODO: if book not already in Books create
        // @TODO: book.addNote(downloaded note)
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
