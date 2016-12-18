//
//  Metadata.swift
//  BookTracker
//
//  Created by Daniel Ransom on 10/20/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class Metadata: NSObject {
    weak var notebook: ENNotebook?
    let notePrefix = "tracker-metadata-"
    
    init?(evernote: ENNotebook) {
        self.notebook = evernote
        
    }
    
    func loadMetadata() {
        ENSession.shared().findNotes(with: ENNoteSearch.init(search: self.notePrefix), in: self.notebook, orScope: ENSessionSearchScope.personal, sortOrder: ENSessionSortOrder.relevance, maxResults: 1) {
            if let error = $0.1 {
                print("Error fetching metadata for " + self.notebook.debugDescription + "with error " + error.localizedDescription)
            } else if let result = $0.0 {
                
            }
        }
    }
}
