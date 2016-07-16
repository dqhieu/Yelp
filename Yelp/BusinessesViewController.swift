//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit
import SVProgressHUD

class BusinessesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var searchBar: UISearchBar!

    var businesses: [Business]! = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 0
        UIView.animateWithDuration(1) { 
            self.view.alpha = 1
        }
        
        initTableView()
        initSearchBar()
        initNagivationBar()
        
        doSearch("Thai")
    }
    
    func initTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func initSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    func initNagivationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
        let filterImage = UIImage(named: "filter")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: filterImage, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(BusinessesViewController.showSettingsViewController))
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    func showSettingsViewController() {
        performSegueWithIdentifier("segueShowSettings", sender: nil)
    }
    
    func doSearch(text: String) {
        showLoadingProgress("Loading")
        /*
        Business.searchWithTerm(text, completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            self.hideLoadingProgress()
        })*/
        
        
        Business.searchWithTerm(text, sort: .Distance, categories: [], deals: false) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.tableView.reloadData()
            self.hideLoadingProgress()
        }
        

    }
    
    func showLoadingProgress(text: String) {
        SVProgressHUD.showWithStatus(text)
        tableView.userInteractionEnabled = false
    }
    
    func hideLoadingProgress() {
        SVProgressHUD.dismiss()
        tableView.userInteractionEnabled = true
    }
}

extension BusinessesViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true;
    }
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true;
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        doSearch(searchBar.text!)
    }
}

extension BusinessesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if businesses != nil {
                return businesses.count
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
}