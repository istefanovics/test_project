//
//  NetworkManager.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit
import Alamofire
import Gloss

class NetworkManager: NSObject {
    
    enum RequestType: String {
        case groupList
        case groupDetail
    }
    
    static let sharedInstance = NetworkManager()
    private let serverUrlString = "http://jwt.hostly.hu"
    
    func getGroups(atpage: Int, limit: Int, completionHandler: @escaping (GroupList?, Error?) -> Void)
    {
        var responseGroupList: GroupList?
        var responseError : Error?
        
        let params = ["page" : atpage,
                      "limit" : limit]
        
        let requestURL = "\(serverUrlString)/list.php"
        
        Alamofire.request(requestURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let error = response.result.error
            {
                responseError = error
            }
            else
            {
                let json = response.result.value as! JSON
                responseGroupList = GroupList(json: json)
            }
            
            completionHandler(responseGroupList, responseError)
        }
    }
}
