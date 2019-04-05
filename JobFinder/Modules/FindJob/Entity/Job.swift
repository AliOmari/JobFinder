//
//  Job.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import UIKit
import ObjectMapper

class Job: Mappable {

    var companyLogo:String?
    var jobTitle:String?
    var companyName:String?
    var location:Any?
    var postDate:String?
    var url:String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        guard let providerJobKeys = DataManager.shared.selectedProvider.searchJobResponseParamterKeys else {
            assertionFailure(R.string.localizable.assert_must_not_be_nil())
            return
        }
        
        companyLogo     <- map[providerJobKeys.companyLogo ?? ""]
        jobTitle        <- map[providerJobKeys.jobTitle ?? ""]
        companyName     <- map[providerJobKeys.companyName ?? ""]
        location        <- map[providerJobKeys.location ?? ""]
        postDate        <- map[providerJobKeys.postDate ?? ""]
        url             <- map[providerJobKeys.url ?? "" ]
    }
    
    func getLocation()->String?{
        if location is String{
            return location as? String
        }
        
        var locationString = ""
        if location is [String]{
            guard let locations = location as? [String] else { return nil }
            for locationStr in locations{
                locationString.append(locationStr)
                locationString.append(" ,")
            }
            locationString.removeLast()
            return locationString
        }
        return nil
    }
    
    func getPostDate()->String?{
        let dateFormat =
            DataManager.shared.selectedProvider
            .searchJobResponseParamterKeys?.postDateFormat ?? ""
        return postDate?.date(withFormat: dateFormat)?.string(withFormat: AppConfig.dateFormat)
    }
}
