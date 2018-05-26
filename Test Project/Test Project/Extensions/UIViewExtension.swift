//
//  UIViewExtension.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 26..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit

extension UIView {
     func roundCorners(cornerSize: CGFloat) {
        self.layer.cornerRadius = cornerSize;
        self.layer.masksToBounds = true;
    }
    
    func addBorder(color: UIColor, width: CGFloat)
    {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
