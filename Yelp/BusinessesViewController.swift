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
    
    var searchSettings:YelpSearchSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if searchSettings == nil {
            searchSettings = YelpSearchSettings()
        }
        
        initTableView()
        initSearchBar()
        initNagivationBar()
        
        doSearch(searchSettings!)
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
        searchBar.tintColor = UIColor.whiteColor()
        searchBar.sizeToFit()
        if searchSettings?.term != "" {
            searchBar.text = searchSettings?.term
        }
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
    
    func doSearch(searchSettings: YelpSearchSettings) {
        print("Main start")
        print(searchSettings.categories)
        showLoadingProgress("Loading")
        Business.searchWithTerm(searchSettings.term, sort: searchSettings.sortBy, categories: searchSettings.categories, deals: searchSettings.deal) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses.removeAll()
            
            if searchSettings.maxDistance == 0 {
                self.businesses = businesses
            }
            else {
                for business in businesses {
                    if business.distance < searchSettings.maxDistance {
                        self.businesses.append(business)
                    }
                }
            }
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueShowSettings" {
            print("Main end")
            print(searchSettings!.categories)
            let nvc = segue.destinationViewController as! UINavigationController
            let vc = nvc.topViewController as! SettingsViewController
            vc.searchSettings = self.searchSettings
            //vc.searchSettings?.categories = self.searchSettings?.categories
        }
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
        searchSettings!.term = searchBar.text
        doSearch(searchSettings!)
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