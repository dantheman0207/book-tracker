//
//  BookTableViewCell.swift
//  BookTracker
//
//  Created by Daniel Ransom on 9/26/16.
//  Copyright © 2016 Daniel Ransom. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var lastPgNr: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
