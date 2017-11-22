//
//  ProfileHeaderCollectionViewCell.swift
//  UteGolf
//
//  Created by Keanu Interone on 11/21/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class ProfileHeaderCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = 8
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        backgroundColor = .white
    }

}
