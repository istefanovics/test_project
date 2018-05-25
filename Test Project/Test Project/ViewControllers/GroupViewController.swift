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
            
            if let groupList = groupList
            {
                self.groupList = groupList.list
                self.groupCollectionView.reloadData()
            }
            else
            {
                
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
}

//extension GroupViewController: UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        let photoObject = self.photos[indexPath.item]
//        let isUpdateAllowed = self.selectedPhotosScrollView.getSelectedPhotos().count < ICConstants.maxSelectableImageCount || photoObject.isSelected
//
//        if isUpdateAllowed {
//            self.updatePhotoObject(photoObject)
//        }
//    }
//}

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
        
        if let imageUrlString = groupItem.image
        {
            cell.groupImageView.sd_setImage(with: URL(string: imageUrlString), placeholderImage: UIImage(named: "placeholder"), completed: nil)
        }
        
//        cell.setSelected(isSelected: photos[indexPath.item].isSelected)
//
//        let photoObject = self.photos[indexPath.item]
//
//        let scale = UIScreen.main.scale
//        let targetSize = self.collectionView(collectionView, layout: collectionView.collectionViewLayout, sizeForItemAt: indexPath)
//        let requiredImageSize = CGSize(width: targetSize.width  * scale, height: targetSize.height * scale)
//
//        if let asset = photoObject.asset
//        {
//            PHImageManager.default().requestImage(for: asset, targetSize: requiredImageSize, contentMode: .aspectFill, options: nil) { (image, info) in
//
//                cell.photoImageView.image = image
//            }
//        }
        
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
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0.0;
//    }
}






