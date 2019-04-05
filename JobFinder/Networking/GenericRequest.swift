//
//  GenericRequest.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import Alamofire

class GenericRequest {
    
    var url:String!
    var method:HTTPMethod!
    var params:Parameters!
    
    required init(provider:Provider,params:Parameters) {
        self.url = provider.searchBaseUrl
        self.method = provider.httpMethod
        self.params = params
    }
}
