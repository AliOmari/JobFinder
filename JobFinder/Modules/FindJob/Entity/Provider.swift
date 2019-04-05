//
//  Provider.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import ObjectMapper
import Alamofire

class Provider:Mappable{

    var displayName:String?
    var searchBaseUrl:String?
    var httpMethod:HTTPMethod?
    var searchUrlParameterKeys:ProviderUrlParameters?
    var searchJobResponseParamterKeys:ProviderJobResoponseParameters?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        displayName                     <- map["displayName"]
        searchBaseUrl                   <- map["searchBaseUrl"]
        httpMethod                      <- map["httpMethod"]
        searchUrlParameterKeys          <- map["searchUrlParameterKeys"]
        searchJobResponseParamterKeys   <- map["searchJobResponseParamterKeys"]
    }
    
    func getParams(lat:Double?,lng:Double?,position:String,pageNumber:Int = 0,pageSize:Int = AppConfig.dataSizeInPage)->Parameters{
        var parameters:Parameters = [:]
        
        guard let urlParameters = searchUrlParameterKeys else { return parameters }
        
        if let latParameter = urlParameters.lat, let lat = lat{
            parameters[latParameter] = lat
        }
        if let lngParameter = urlParameters.lng, let lng = lng{
            parameters[lngParameter] = lng
        }
        if let latLngParameter = urlParameters.latLng, let lat = lat , let lng = lng{
            let latLng = "\(lat),\(lng)"
            parameters[latLngParameter] = latLng
        }
        if let positionParameter = urlParameters.position{
            parameters[positionParameter] = position
        }
        if let pageSizeParameter = urlParameters.pageSize{
            parameters[pageSizeParameter] = pageSize
        }
        if let paginationParameter = urlParameters.pagination{
            parameters[paginationParameter] = pageNumber
        }
        if let fromRecordParameter = urlParameters.fromRecord{
            let fromRecord = pageNumber * pageSize
            parameters[fromRecordParameter] = fromRecord
        }
        
        return parameters
    }
}
class ProviderUrlParameters:Mappable{
    // We are going to search depends on two filters
    //1. location which in most API will be presented as lng,lat
    //2. position or title
    //and since every provider has different parameters keys so we are going to store them
    var lat:String?
    var lng:String?
    var latLng:String?
    var position:String?
    var pageSize:String?
    var pagination:String?
    var fromRecord:String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        lat         <- map["lat"]
        lng         <- map["lng"]
        latLng      <- map["latLng"]
        position    <- map["position"]
        pageSize    <- map["pageSize"]
        pagination  <- map["pagination"]
        fromRecord  <- map["fromRecord"]
    }
}
class ProviderJobResoponseParameters:Mappable{
    // since we have multiple responses from each provider, so we have different response parameters
    var companyLogo:String?
    var jobTitle:String?
    var companyName:String?
    var location:String?
    var postDate:String?
    var postDateFormat:String?
    var url:String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        companyLogo     <- map["companyLogo"]
        jobTitle        <- map["jobTitle"]
        companyName     <- map["companyName"]
        location        <- map["location"]
        postDate        <- map["postDate"]
        postDateFormat  <- map["postDateFormat"]
        url             <- map["url"]
    }
}

