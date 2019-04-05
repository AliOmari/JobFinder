//
//  JobTableCell.swift
//  JobFinder
//
//  Created by Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//

import UIKit
import AlamofireImage

class JobTableCell: UITableViewCell {

    @IBOutlet weak var imgCompanyLogo: UIImageView!
    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var lblCompanyName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblPostDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func populate(job:Job){
        if let logoUrl = URL(string:job.companyLogo ?? ""){
            imgCompanyLogo.af_setImage(withURL: logoUrl, placeholderImage: R.image.place_holder()!)
        }
        lblJobTitle.text = job.jobTitle
        lblCompanyName.text = job.companyName
        lblLocation.text = job.getLocation()
        lblPostDate.text = job.getPostDate()
    }
}
