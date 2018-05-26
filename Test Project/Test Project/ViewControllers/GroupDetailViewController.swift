//
//  GroupDetailViewController.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 26..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit
import SDWebImage

class GroupDetailViewController: UIViewController {

    @IBOutlet weak var groupImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var memberCountLabel: UILabel!
    @IBOutlet weak var eventCountlabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollBackgroundView: UIView!
    @IBOutlet weak var memberCountContainerView: UIView!
    @IBOutlet weak var eventCountContainerView: UIView!
    
    var groupId = 1
    private var group : GroupItem?
    private let cellIdentifier = "ManagementCellReuseIdentifier"
    private let itemSpace = CGFloat(20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupImageView.roundCorners(cornerSize: self.groupImageView.frame.width / 2)
        self.memberCountContainerView.roundCorners(cornerSize: 12.0)
        self.eventCountContainerView.roundCorners(cornerSize: 12.0)
        self.contentView.roundCorners(cornerSize: 15.0)
        self.scrollBackgroundView.roundCorners(cornerSize: 15.0)
        
        let borderColor = UIColor(red:220/255, green:221/255, blue:225/255, alpha: 1)
        
        self.memberCountContainerView.addBorder(color: borderColor, width: 1)
        self.eventCountContainerView.addBorder(color: borderColor, width: 1)
        self.scrollBackgroundView.addBorder(color: borderColor, width: 1)
        
        self.loadData(forGroupId: self.groupId)
    }
    
    func loadData(forGroupId id: Int) {
        
        NetworkManager.sharedInstance.getDetail(forGroupId: id) { (groupDetailResponse, error) in
            if let error = error
            {
                self.showError(message: error.localizedDescription)
            }
            else if let groupDetailResponse = groupDetailResponse
            {
                self.group = groupDetailResponse.item
                self.updateUI()
            }
            else
            {
                self.showError(message: "Failed to load the Data")
            }
        }
    }
    
    func updateUI() {
        if let group = self.group
        {
            if let imageURLString = group.image
            {
                self.groupImageView.sd_setImage(with: URL(string: imageURLString), placeholderImage: UIImage(named: "placeholder"), completed: nil)
            }
            
            self.titleLabel.text = group.name
            self.descriptionLabel.text = group.description
            self.memberCountLabel.text = "\(group.memberCount ?? 0)"
            self.eventCountlabel.text = "\(group.eventCount ?? 0)"
            
            self.collectionView.reloadData()
        }
    }
}

extension GroupDetailViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        var count = 0
        
        if let managements = self.group?.management
        {
            count = managements.count
        }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)  as!  ManagementCollectionViewCell
        if let managementItem = self.group?.management[indexPath.row]
        {
            cell.rankTitleLabel.text = managementItem.type ?? ""
            cell.nameLabel.text = managementItem.type ?? ""
            
            if let imageUrlString = managementItem.image
            {
                cell.thumbnailImageView.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage(named: "placeholder"), completed: nil)
            }
        }
        
        return cell
    }
}

extension GroupDetailViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = self.collectionView.frame.width - self.itemSpace
        let widthPerItem = availableWidth / 2
        let ratio = CGFloat(135.0/125.0)
        let height = widthPerItem / ratio
        
        return CGSize(width: widthPerItem, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.itemSpace
    }
}
