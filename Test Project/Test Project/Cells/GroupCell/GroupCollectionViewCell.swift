//
//  GroupCollectionViewCell.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var memberListView: MemberPictureListView!
    
    var favoriteActionBlock: ((GroupCollectionViewCell)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = UIColor(red: 219.0/255.0, green: 220.0/255.0, blue: 225.0/255.0, alpha: 1)
        
        self.groupImageView.roundCorners(cornerSize: self.groupImageView.bounds.width / 2)
        self.containerView.roundCorners(cornerSize: 15.0)
        self.contentView.roundCorners(cornerSize: 15.0)
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if let favoriteActionBlock  = self.favoriteActionBlock
        {
            favoriteActionBlock(self)
        }
    }
}
