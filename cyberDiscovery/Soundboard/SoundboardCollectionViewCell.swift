//
//  CollectionViewCell.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import UIKit

class SoundboardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var name: UITextView!
    var audioUrl: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        name.centerVertically()
    }
    
    

}

@IBDesignable
extension UITextView {
    
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
    
}
