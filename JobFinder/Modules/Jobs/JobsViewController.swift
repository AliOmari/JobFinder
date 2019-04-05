//
//  JobsViewController.swift
//  JobFinder
//
//  Created Ali Omari on 4/4/19.
//  Copyright © 2019 Ali Omari. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class JobsViewController: BaseViewController, JobsViewProtocol {
    
    var presenter: JobsPresenterProtocol?
    @IBOutlet weak var tableJobs: UITableView!
    
    var lastDisplayedIndex:IndexPath?
    var activityIndicatorLoadingView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func setupViews() {
        tableJobs.register(UINib(resource: R.nib.jobTableCell),
                           forCellReuseIdentifier: R.reuseIdentifier.jobTableCell.identifier)
        tableJobs.delegate = self
        tableJobs.dataSource = self
        activityIndicatorLoadingView = UIActivityIndicatorView(style: .gray)
        activityIndicatorLoadingView.hidesWhenStopped = true
        tableJobs.tableFooterView = activityIndicatorLoadingView
    }
    
    func populate() {
        tableJobs.reloadData()
    }
    
    func changeActivityIndicatorVisibility(isHidden: Bool) {
        if isHidden{
            activityIndicatorLoadingView.stopAnimating()
        }else{
            activityIndicatorLoadingView.startAnimating()
        }
        tableJobs.tableFooterView?.isHidden = isHidden
    }
}
extension JobsViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.jobs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: R.reuseIdentifier.jobTableCell.identifier,
            for: indexPath) as! JobTableCell
        cell.populate(job: presenter!.jobs[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        lastDisplayedIndex = indexPath
        presenter?.didDisplayDataAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let job = presenter!.jobs[indexPath.row]
        presenter?.didClickOnJob(job: job)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
