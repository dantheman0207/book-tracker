//
//  Book.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/26/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Book: NSObject {
    // MARK: Properties
    var displayName: String
    var isbn: String?
    var photo: UIImage?
    var notes: Notes?
 
    init?(name: String, isbn: String, existingNotes: Notes?) {
        
        // Set props
        self.displayName = name
        if let notes = existingNotes {
            self.notes = notes
        } else {
            self.notes = Notes()
        }

        super.init()
    }
    
    func valid(isbn: String) -> Bool {
        // add code validating isbn structure (w/ regex?)
        return true
    }
}
