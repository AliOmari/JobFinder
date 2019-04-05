//
//  BaseViewController.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import UIKit
import PMAlertController

class BaseViewController: UIViewController,BaseViewProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        styleViews()
    }
    
    func showLoadingIndicator() {
        UIHelper.showNetworkActivityIndicator()
    }
    
    func hideLoadingIndicator() {
        UIHelper.hideNetworkActivityIndicator()
    }
    
    func showMessage(title: String, message: String) {
        presentMessageController(title: title, message: message)
    }
    
    private func presentMessageController(title: String, message: String){
        
        let messageVC = PMAlertController(title: title,
                                          description:message,
                                          image: nil,
                                          style: .alert)
        
        messageVC.addAction(PMAlertAction(title:R.string.localizable.ok_title(),
                                          style: .cancel))
        
        present(messageVC, animated: true, completion: nil)
    }
    
    func setupViews(){
    }
    
    func styleViews(){
    }
}
