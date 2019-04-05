//
//  UIHelper.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class UIHelper {
    static private let indicatorActivityData = ActivityData(type: .ballRotateChase, color: UIColor.blue ,backgroundColor: .clear)
    
    static func addShadowAndCornerRadius(for view:UIView,radius:CGFloat = 10.0){
        view.cornerRadius = radius
        view.addShadow(ofColor: UIColor.gray, radius: radius, offset: CGSize(width: 5.0, height: 5.0), opacity: 0.2)
    }
    
    static func showNetworkActivityIndicator(){
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(UIHelper.indicatorActivityData, nil)
    }
    
    static func hideNetworkActivityIndicator(){
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
    }
}
