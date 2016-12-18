//
//  Note.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/27/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Note: NSObject {
    
    // MARK: Properties
    var title: String
    var content: String
    var images: [UIImage]?
    var note: ENNote?
    
    init?(title: String, content: String, everNote: ENNote?) {
        // create variables
        self.title = title
        self.content = content
        
        if title.isEmpty || content.isEmpty {
            return nil
        }
        
        super.init()

        // either add the note or create it
        if let note = everNote {
                self.note = note
        } else {
            createEverNote(title, content)
        }
        
    }
    
    convenience init?(note: ENNote) {
        // Set content
        let content = note.content.description // does this work as a plaintext version of note content ???
        
        // Get notebook note is within
        // @TODO
        
        // Extract title
        let title = note.title!
        
        // init
        self.init(title: title, content: content, everNote: note)
    }
    
    func createEverNote(_ title: String,_ content: String) {
        let everNote = ENNote.init()
        everNote.title = title
        everNote.content = ENNoteContent.init(string: content)
        
        // @TODO: Make sure we put it in the right notebook ....

        self.note = everNote
    }
    
    
}
