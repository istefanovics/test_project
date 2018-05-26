//
//  FullSizeTableView.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 26..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit

class FullSizeCollectionView: UICollectionView {

    override var contentSize: CGSize {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
