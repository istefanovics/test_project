//
//  FaroriteGroupManager.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit

class FaroriteGroupManager: NSObject {
    
    static let sharedInstance = FaroriteGroupManager()
    
    var favoritedGroupIds = [Int]()
    private let storeKey = "FavoritedGroupsStoreKey"
    
    override init() {
        super.init()
        
        self.loadData()
    }
    
    // MARK: - Favorite
    
    func favoriteState(groupId: Int) -> Bool {
        return self.favoritedGroupIds.contains(groupId)
    }
    
    func favoriteGroup(id:Int) {
        if (!self.favoritedGroupIds.contains(id))
        {
            favoritedGroupIds.append(id)
            self.saveData()
        }
    }
    
    func unfavoriteGroup(id: Int) {
        if let index = self.favoritedGroupIds.index(of:id) {
            self.favoritedGroupIds.remove(at: index)
            self.saveData()
        }
    }
    
    // MARK: - Storing
    
    private func saveData()  {
        let defaults = UserDefaults.standard
        defaults.set(self.favoritedGroupIds, forKey: self.storeKey)
    }
    
    private func loadData() {
        let defaults = UserDefaults.standard
        self.favoritedGroupIds = defaults.object(forKey: self.storeKey) as? [Int] ?? [Int]()
    }
    
    func removeData() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: self.storeKey)
    }
}
