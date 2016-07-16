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
    
    var isMoreDataLoading = false
    var loadingMoreView:InfiniteScrollActivityView?
    var isNoMoreData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if searchSettings == nil {
            searchSettings = YelpSearchSettings()
        }
        
        initTableView()
        initSearchBar()
        initNagivationBar()
        initInfiniteLoading()
        
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
    
    func initInfiniteLoading() {
        // Set up Infinite Scroll loading indicator
        let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.hidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
    }
    
    func showSettingsViewController() {
        performSegueWithIdentifier("segueShowSettings", sender: nil)
    }
    
    func doSearch(searchSettings: YelpSearchSettings) {
        //print("Main start")
        //print(searchSettings.categories)
        showLoadingProgress("Loading")
        Business.searchWithTerm(searchSettings.term, sort: searchSettings.sortBy, categories: searchSettings.categories, deals: searchSettings.deal, offset: searchSettings.offset) { (businesses: [Business]!, error: NSError!) -> Void in
            if searchSettings.offset == 0 {
                self.businesses.removeAll()
            }
            
            if businesses != nil {
                if searchSettings.maxDistance == 0 {
                    self.businesses.appendContentsOf(businesses)
                }
                else {
                    for business in businesses {
                        if business.distance < searchSettings.maxDistance {
                            self.businesses.append(business)
                        }
                    }
                }
                
                // Make sure that businesses will be sorted
                switch searchSettings.sortBy.rawValue {
                case YelpSortMode.Distance.rawValue:
                    self.businesses.sortInPlace({ (b1, b2) -> Bool in
                        b1.distance < b2.distance
                    })
                case YelpSortMode.HighestRated.rawValue:
                    self.businesses.sortInPlace({ (b1, b2) -> Bool in
                        b1.rating > b2.rating
                    })
                default:
                    break
                }

            }
            
            
            self.isMoreDataLoading = false
            self.isNoMoreData = false
            self.tableView.reloadData()
            self.hideLoadingProgress()
            self.loadingMoreView!.stopAnimating()
        }
    }
    
    func showLoadingProgress(text: String) {
        SVProgressHUD.showWithStatus(text)
        tableView.userInteractionEnabled = false
        searchBar.userInteractionEnabled = false
        navigationItem.leftBarButtonItem?.enabled = false
    }
    
    func hideLoadingProgress() {
        SVProgressHUD.dismiss()
        tableView.userInteractionEnabled = true
        searchBar.userInteractionEnabled = true
        navigationItem.leftBarButtonItem?.enabled = true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueShowSettings" {
            //print("Main end")
            //print(searchSettings!.categories)
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
        searchSettings?.offset = 0
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
                if !isNoMoreData {
                    return businesses.count
                }
                else {
                    return businesses.count + 1
                }
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == businesses.count && isNoMoreData {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No more result"
            cell.textLabel?.font = UIFont(name: "Avenir Next", size: 17)
            cell.textLabel?.textColor = UIColor.redColor()
            cell.textLabel?.textAlignment = .Center
            cell.selectionStyle = .None
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("BusinessCell") as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}

extension BusinessesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.dragging) {
                if searchSettings?.offset < businesses.count {

                    isMoreDataLoading = true
                    isNoMoreData = false
                
                    // Update position of loadingMoreView, and start loading indicator
                    let frame = CGRectMake(0, tableView.contentSize.height, tableView.bounds.size.width, InfiniteScrollActivityView.defaultHeight)
                    loadingMoreView?.frame = frame
                    loadingMoreView!.startAnimating()
                
                    // Code to load more results
                    searchSettings?.offset = businesses.count
                    doSearch(searchSettings!)
                }
                else {
                    if !isNoMoreData {
                        isNoMoreData = true
                        tableView.reloadData()
                    }
                }
            }
        }
    }
}

class InfiniteScrollActivityView: UIView {
    var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
    static let defaultHeight:CGFloat = 60.0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupActivityIndicator()
    }
    
    override init(frame aRect: CGRect) {
        super.init(frame: aRect)
        setupActivityIndicator()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicatorView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
    }
    
    func setupActivityIndicator() {
        activityIndicatorView.activityIndicatorViewStyle = .Gray
        activityIndicatorView.hidesWhenStopped = true
        self.addSubview(activityIndicatorView)
    }
    
    func stopAnimating() {
        self.activityIndicatorView.stopAnimating()
        self.hidden = true
    }
    
    func startAnimating() {
        self.hidden = false
        self.activityIndicatorView.startAnimating()
    }
}