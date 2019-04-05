//
//  DataManager.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import UIKit
import ObjectMapper

class DataManager {

    var providers:[Provider]?
    var selectedProvider:Provider!
    
    static let shared = DataManager()
    private init() {}
    
    func run(){
        providers = Mapper<Provider>().mapArray(JSONfile: R.file.providersJson.fullName)
        selectedProvider = providers?.first
    }
}
