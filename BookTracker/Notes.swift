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
    
    init(book: Book) {
        super.init()
        self.book = book
        notes = loadEvernoteNotes()
    }
    
    func loadEvernoteNotes() -> [Note] {
        var evernoteNotes: [Note]
            evernoteNotes = [Note]()
        // load notes
        ENSession.shared().listNotebooks() {
            let notebook = ($0.0![0] as! ENNotebook)
            
            ENSession.shared().findNotes(with: ENNoteSearch.init(search: "pg."), in: notebook, orScope: ENSessionSearchScope.personal, sortOrder: ENSessionSortOrder.title, maxResults: 100) {
                if let error = $0.1 {
                    print("Error fetching notes....\n" + error.localizedDescription)
                } else if let results = $0.0 {
                    for i in results {
                        let noteRef = (i as! ENSessionFindNotesResult).noteRef
                        ENSession.shared().downloadNote(noteRef, progress: nil) {
                            if let error = $0.1 {
                                print("Error downloading note...." + error.localizedDescription)
                            } else if let note = $0.0 {
                                for i in note.tagNames {
                                    if String(describing: i).contains(self.book!.title) {
                                        evernoteNotes.append((Note(note:note)!))
                                    }
                                }
                            }
                        }
                        
                    }
                }
            }
        }
        
        return evernoteNotes
    }
    
    func count() -> Int {
        return notes.count
    }
    
    func createNote(title: String, content: String, images: [UIImage]?) {
        // Update to pass images
        // also update to pass ref so it know to put the note in this notebook
        let note = Note(title: title, content: content, everNote: nil)!
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
