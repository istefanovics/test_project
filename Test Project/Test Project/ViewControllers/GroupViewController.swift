//
//  groupViewController.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit
import SDWebImage

class GroupViewController: UIViewController {
    
    @IBOutlet weak var groupCollectionView: UICollectionView!
    
    private let cellIdentifier = "groupListCellIdentifier"
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right:20.0)
    var groupList = [GroupListItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData(page: 1)
    }
    
    func loadData(page: Int) {
        NetworkManager.sharedInstance.getGroups(atpage: 1, limit: 30) { (groupList, error) in
            
            if let error = error
            {
                self.showError(message: error.localizedDescription)
            }
            else if let groupList = groupList
            {
                self.groupList = groupList.list
                self.groupCollectionView.reloadData()
            }
            else
            {
               self.showError(message: "Failed to load Data")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showError(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension GroupViewController: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return groupList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)  as!  GroupCollectionViewCell
        let groupItem = self.groupList[indexPath.row]
        
        cell.titleLabel.text = groupItem.name
        cell.memberCountLabel.text = "\(groupItem.members.count) tag"
        
        if let groupId = groupItem.id
        {
            cell.favoriteActionBlock = { cell in
                
                if cell.starButton.isSelected
                {
                    FavoriteGroupManager.sharedInstance.favoriteGroup(id: groupId)
                }
                else
                {
                    FavoriteGroupManager.sharedInstance.unfavoriteGroup(id: groupId)
                }
            }
            
            cell.starButton.isSelected = FavoriteGroupManager.sharedInstance.favoriteState(groupId: groupId)
        }
        
        if let imageUrlString = groupItem.image
        {
            cell.groupImageView.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage(named: "placeholder"), completed: nil)
        }
        
        cell.memberListView.imageURLs = groupItem.members.enumerated().map({(offset, member: Member) -> String in
            if let imageUrl = member.image
            {
                return imageUrl
            }
            else
            {
                return ""
            }
        })
        
        return cell
    }
}

extension GroupViewController : UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let paddingSpace = self.sectionInsets.left * 3
        let availableWidth = self.view.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        let ratio = CGFloat(158.0/200.0)
        let height = widthPerItem / ratio
        
        return CGSize(width: widthPerItem, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return self.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.sectionInsets.left
    }
}
