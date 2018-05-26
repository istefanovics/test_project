//
//  NetworkModels.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import Gloss

struct Member: JSONDecodable {
    
    let firstName: String?
    let lastName: String?
    let image: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.firstName = "username" <~~ json
        self.lastName = "lastName" <~~ json
        self.image = "image" <~~ json
    }
}

struct ManagementMember: JSONDecodable {
    
    let id: Int?
    let name: String?
    let type: String?
    let image: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.type = "type" <~~ json
        self.image = "image" <~~ json
    }
}

// MARK: - listing

struct GroupListItem: JSONDecodable {
    
    let id: Int?
    let name: String?
    let image: String?
    let members: [Member]
    
    // MARK: - Deserialization
    
    init?(json: JSON) {

        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.image = "image" <~~ json
        
        if let memberJSON: [JSON] = "members" <~~ json, let members = [Member].from(jsonArray: memberJSON) {
            self.members = members
        }
        else
        {
            self.members = [Member]()
        }
    }
}


struct GroupListResponse: JSONDecodable {
    
    let error: Bool?
    let responseCode: String?
    let filtered: Int?
    let total: Int?
    let list: [GroupListItem]
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        
        self.error = "error" <~~ json
        self.responseCode = "responseCode" <~~ json
        self.filtered = "filtered" <~~ json
        self.total = "total" <~~ json
        
        if let groupsJSON: [JSON] = "list" <~~ json, let groups = [GroupListItem].from(jsonArray: groupsJSON) {
            self.list = groups
        }
        else
        {
            self.list = [GroupListItem]()
        }
    }
}

// MARK: - Detail

struct GroupItem: JSONDecodable {
    
    let id: String?
    let name: String?
    let image: String?
    let description: String?
    let members: [Member]
    let memberCount: Int?
    let eventCount: Int?
    let management: [ManagementMember]
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        
        self.id = "id" <~~ json
        self.name = "name" <~~ json
        self.image = "image" <~~ json
        self.description = "description" <~~ json
        
        if let memberJSON: [JSON] = "members" <~~ json, let members = [Member].from(jsonArray: memberJSON) {
            self.members = members
        }
        else
        {
            self.members = [Member]()
        }
        
        self.memberCount = "memberCount" <~~ json
        self.eventCount = "eventCount" <~~ json
        
        if let managementJSON: [JSON] = "management" <~~ json, let management = [ManagementMember].from(jsonArray: managementJSON) {
            self.management = management
        }
        else
        {
            self.management = [ManagementMember]()
        }
    }
}

struct GroupDetailResponse: JSONDecodable {
    
    let error: Bool?
    let responseCode: String?
    let item: GroupItem?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        
        self.error = "error" <~~ json
        self.responseCode = "responseCode" <~~ json
        self.item = "item" <~~ json
    }
}


