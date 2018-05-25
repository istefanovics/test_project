//
//  MemberPictureListView.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit
import SDWebImage

class MemberPictureListView: UIView {

    var imageURLs = [String]()
    {
        didSet {
            self.setupImageViews()
            self.invalidateIntrinsicContentSize()
        }
    }
    
    var imageViews = [UIImageView]()

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDefaults()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupDefaults()
    }
    
    func setupDefaults() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupImageViews() {
        let viewNeededCount = max(self.imageURLs.count - self.imageViews.count, 0)
        
        if (viewNeededCount > 0)
        {
            for _ in 1...viewNeededCount
            {
                let imageView  = UIImageView()
                imageView.contentMode = .scaleToFill
                imageView.layer.borderColor = UIColor.white.cgColor
                imageView.layer.borderWidth = 2.0
                
                self.imageViews.append(imageView)
                self.addSubview(imageView)
                self.sendSubview(toBack: imageView)
            }
        }
        
        for (index, element) in self.imageViews.enumerated() {
            
            if (index > self.imageURLs.count - 1)
            {
                element.isHidden = true
            }
            else
            {
                let urlString = self.imageURLs[index]
                element.sd_setImage(with: URL(string: urlString), placeholderImage: UIImage(named: "placeholder"), completed: nil)
                element.isHidden = false
            }
        }
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageHeight = self.frame.height
        let offsetX = imageHeight * (2/3)
        
        var lastItemFrame = CGRect.zero
        
        for (index, imageView) in self.imageViews.enumerated() {
            
            if (index < self.imageURLs.count)
            {
                let originX = index == 0 ? 0 : lastItemFrame.origin.x + offsetX
                
                let calculatedFrame = CGRect(x: originX, y: 0.0, width: imageHeight, height: imageHeight)
                imageView.frame = calculatedFrame
                lastItemFrame = calculatedFrame
                
                self.setRoundedCorners(forView: imageView, cornerSize: imageHeight / 2)
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        if (self.imageURLs.count == 0)
        {
            return CGSize.zero
        }
        
        return CGSize(width: self.calculateRequiredWidth(), height: UIViewNoIntrinsicMetric)
    }
    
    func calculateRequiredWidth() -> CGFloat {
        let itemWidth = self.frame.height
        var calculatedWidth = itemWidth
        let itemCount = self.imageURLs.count
        
        if (itemCount > 1)
        {
            calculatedWidth += ((calculatedWidth * (2/3)) * CGFloat(itemCount - 1))
        }
        
        return calculatedWidth
    }
    
    // MARK: - Helper
    
    private func setRoundedCorners(forView view:UIView, cornerSize: CGFloat) {
        view.layer.cornerRadius = cornerSize;
        view.layer.masksToBounds = true;
    }
}
