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
    
    func getGroups(atpage: Int, limit: Int, completionHandler: @escaping (GroupListResponse?, Error?) -> Void)
    {
        var responseGroupList: GroupListResponse?
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
                responseGroupList = GroupListResponse(json: json)
            }
            
            completionHandler(responseGroupList, responseError)
        }
    }
    
    func getDetail(forGroupId id: Int , completionHandler: @escaping (GroupDetailResponse?, Error?) -> Void)
    {
        var responseGroupList: GroupDetailResponse?
        var responseError : Error?
        
        let params = ["id" : id]
        let requestURL = "\(serverUrlString)/show.php"
        
        Alamofire.request(requestURL, method: .post, parameters: params, encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
            
            if let error = response.result.error
            {
                responseError = error
            }
            else
            {
                let json = response.result.value as! JSON
                responseGroupList = GroupDetailResponse(json: json)
            }
            
            completionHandler(responseGroupList, responseError)
        }
    }
}
