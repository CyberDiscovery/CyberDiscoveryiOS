//
//  Card.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import UIKit

@IBDesignable
class Card: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.borderColor = UIColor(white: 231/255, alpha: 1).cgColor
        self.layer.borderWidth = 1
    }

}
