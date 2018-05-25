//
//  NetworkManager.swift
//  Test Project
//
//  Created by István Stefánovics on 2018. 05. 25..
//  Copyright © 2018. István Stefánovics. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {
    
    enum RequestType: String {
        case groupList
        case groupDetail
    }
    
    static let sharedInstance = NetworkManager()
    private let serverUrl = "http://jwt.hostly.hu/"
    
    func getGroups(atpage: Int, limit: Int, completionHandler: @escaping (GroupList, Error?) -> Void)
    {
        let params = ["page" : atpage,
                      "limit" : limit]
        
        let requestURl = self.generateRequestUrl(type: .groupList, params: params)
        
        Alamofire.request(requestURl)
            .responseJSON { response in
                
        }
    }
    

    
    private func generateRequestUrl(type: RequestType, params: [String: Any]) -> String {
        
        var requestUrl = ""
        var requestName = ""
        
        switch type {
        case .groupList:
            requestName =  "list.php"
        case .groupDetail:
            requestName =  "show.php"
        }
        
        requestUrl = serverUrl + requestName
        
        params.forEach {
            requestUrl += "?\($0)=\($1)"
        }

        return requestUrl
    }
}
