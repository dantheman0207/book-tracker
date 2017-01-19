//
//  Notes.swift
//  BookTracker
//
//  Created by Daniel Ransom on 10/3/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Notes: NSObject {
    // MARK: Properties
    public var notes = [Note]()
    public weak var book: Book?
    
    override init() {
        super.init()
    }

    func count() -> Int {
        return notes.count
    }
    
    func createNote(title: String, content: String, images: [UIImage]?) {
        // Update to pass images
        // also update to pass ref so it know to put the note in this notebook
        let note = Note(title: title, content: content)!
        notes.append(note)
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
}
