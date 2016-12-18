`//
//  Book.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/26/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Book: NSObject {
    // MARK: Properties
    var title: String
    var displayName: String
    var isbn: String?
    var photo: UIImage?
    var notes: Notes
    var notebook: ENNotebook
    
    // MARK: Initialization
    convenience init?(name: String, isbn: String?, pic: UIImage?) {
        
        let prefix = "notetakr-"
        // garbage
        let notebook = ENNotebook()
        let noteStore = ENSession.shared().primaryNoteStore()!
        // noteStore.createNotebook
            
        
        // Todo: Create notebook
        
        // with name: name
        
        // TODO: create & store notebook using passed arguments
        
        
        if name.isEmpty {
            return nil //fail out
        }
        
        // @TODO create notebook on evernote if no notes
        
        // call designated initializer
        self.init(notebook: notebook)

    }
    
    init?(notebook: ENNotebook?) {
        // local var holds magic string
        let prefix = "notetakr-"
        
        // load display name
        let endPrefix = notebook.name.index(after: prefix.endIndex)
        let cleanName = notebook.name.substring(from: endPrefix)
        
        // load notes
        let notesForMe = Notes(book: self)
        
        // load isbn/pic from 'metadata' note
        // @TODO
        
        // Set props
        self.displayName = cleanName
        self.notes = notesForMe
        self.notebook = notebook
    }
    
    func valid(isbn: String) -> Bool {
        // add code validating isbn structure (w/ regex?)
        return true
    }
}
