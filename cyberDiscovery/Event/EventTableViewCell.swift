//
//  EventTableViewCell.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var subtext: UITextView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var time: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
