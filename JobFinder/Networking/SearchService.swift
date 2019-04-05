//
//  SearchService.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//


import Alamofire
import ObjectMapper

class SearchService {
    
    static func search(_ request:GenericRequest, success: @escaping ([Job]) -> Void, failure: @escaping (_ error: Error) -> Void) {
        APIClient.request(request.method, url: request.url, params: request.params, success: { response, headers in
            let jobs = Mapper<Job>().mapArray(JSONArray: response as! JSONArray)
            success(jobs)
        }, failure: { error in
            failure(error)
        })
    }
}
