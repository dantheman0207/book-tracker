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
    
    init?(title: String, content: String) {
        // create variables
        self.title = title
        self.content = content
        
        if title.isEmpty || content.isEmpty {
            return nil
        }
        
        super.init()
        
    }
}
