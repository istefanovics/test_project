//
//  ManagementCollectionViewCell.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 26..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit

class ManagementCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var rankTitleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameLabelBottomConstraint: NSLayoutConstraint!
    
    let borderColor = UIColor(red:220/255, green:221/255, blue:225/255, alpha: 1)
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.thumbnailImageView.roundCorners(cornerSize: self.thumbnailImageView.bounds.width / 2.0)
        self.contentView.roundCorners(cornerSize: 12.0)
        self.contentView.addBorder(color: self.borderColor, width: 1)
        self.nameLabelBottomConstraint.constant = 5 * UIScreen.main.scale
    }
}
