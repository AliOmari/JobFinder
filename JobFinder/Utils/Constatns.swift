//
//  Constatns.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//


typealias JSONDictionary = [String:Any]
typealias JSONArray = [[String:Any]]
typealias RawData = String

struct ApiKey {
    //Add your google api key here to get places
    static let googlePlacesApiKey = "YOUR_API_KEY_HERE"
}

struct AppConfig {
    //Date format that you wish to appear in jobs post date
    static let dateFormat = "dd/MM/yyyy"
    //For some providers you can identify page number of data in each page,
    //you can edit the number from here, but on the other hand some providers don't
    //provide user controll in data size like GitHub, they force you in 50 job a time.
    static let dataSizeInPage = 10
}
