//
//  EventCollectionViewCell.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/28/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var eventLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        eventImageView.contentMode = .scaleAspectFill
        eventImageView.clipsToBounds = true
    }

}
