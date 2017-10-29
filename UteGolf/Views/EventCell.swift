//
//  EventCell.swift
//  UteGolf
//
//  Created by Keanu Interone on 10/18/17.
//  Copyright © 2017 Keanu Interone. All rights reserved.
//

import UIKit

class EventCell: UICollectionViewCell {
    
    var imageView : UIImageView!
    var label : UILabel!
    var blurEffectView : UIVisualEffectView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.green
        contentView.addSubview(imageView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(blurEffectView)
        
        label = UILabel()
        label.text = "Event Name"
        label.font = UIFont.systemFont(ofSize: 30)
        contentView.addSubview(label)
        
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true
        
        contentView.backgroundColor = UIColor.purple
    }
    
    override func layoutSubviews() {
        let padding = CGFloat(10)
        let height = contentView.frame.height
        let width = contentView.frame.width
        
        imageView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        blurEffectView.frame = CGRect(x: width * (2.0/5.0), y: 0, width: width * (3.0/5.0), height: height)
        
        label.frame = CGRect(x: blurEffectView.frame.minX + padding, y: padding, width: width - (blurEffectView.frame.minX + padding), height: 40)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
