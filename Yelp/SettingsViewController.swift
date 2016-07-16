//
//  SettingsViewController.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var distances = [
        ["distance": "Auto", "value": "0"],
        ["distance": "0.3 miles", "value": "0.3"],
        ["distance": "1 miles", "value": "1"],
        ["distance": "5 miles", "value": "5"],
        ["distance": "10 miles", "value": "10"],
    ]
    var distanceSelectedIndex = 0
    var isDistanceExpanded = false

    var sorts = [
        ["by": "Best match"],
        ["by": "Distance"],
        ["by": "Highest rated"],
    ]
    var sortSelectedIndex = 0
    var isSortExpanded = false
    
    let categories = [["name" : "Afghan", "code": "afghani"],
                      ["name" : "African", "code": "african"],
                      ["name" : "American, New", "code": "newamerican"],
                      ["name" : "American, Traditional", "code": "tradamerican"],
                      ["name" : "Arabian", "code": "arabian"],
                      ["name" : "Argentine", "code": "argentine"],
                      ["name" : "Armenian", "code": "armenian"],
                      ["name" : "Asian Fusion", "code": "asianfusion"],
                      ["name" : "Asturian", "code": "asturian"],
                      ["name" : "Australian", "code": "australian"],
                      ["name" : "Austrian", "code": "austrian"],
                      ["name" : "Baguettes", "code": "baguettes"],
                      ["name" : "Bangladeshi", "code": "bangladeshi"],
                      ["name" : "Barbeque", "code": "bbq"],
                      ["name" : "Basque", "code": "basque"],
                      ["name" : "Bavarian", "code": "bavarian"],
                      ["name" : "Beer Garden", "code": "beergarden"],
                      ["name" : "Beer Hall", "code": "beerhall"],
                      ["name" : "Beisl", "code": "beisl"],
                      ["name" : "Belgian", "code": "belgian"],
                      ["name" : "Bistros", "code": "bistros"],
                      ["name" : "Black Sea", "code": "blacksea"],
                      ["name" : "Brasseries", "code": "brasseries"],
                      ["name" : "Brazilian", "code": "brazilian"],
                      ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
                      ["name" : "British", "code": "british"],
                      ["name" : "Buffets", "code": "buffets"],
                      ["name" : "Bulgarian", "code": "bulgarian"],
                      ["name" : "Burgers", "code": "burgers"],
                      ["name" : "Burmese", "code": "burmese"],
                      ["name" : "Cafes", "code": "cafes"],
                      ["name" : "Cafeteria", "code": "cafeteria"],
                      ["name" : "Cajun/Creole", "code": "cajun"],
                      ["name" : "Cambodian", "code": "cambodian"],
                      ["name" : "Canadian", "code": "New)"],
                      ["name" : "Canteen", "code": "canteen"],
                      ["name" : "Caribbean", "code": "caribbean"],
                      ["name" : "Catalan", "code": "catalan"],
                      ["name" : "Chech", "code": "chech"],
                      ["name" : "Cheesesteaks", "code": "cheesesteaks"],
                      ["name" : "Chicken Shop", "code": "chickenshop"],
                      ["name" : "Chicken Wings", "code": "chicken_wings"],
                      ["name" : "Chilean", "code": "chilean"],
                      ["name" : "Chinese", "code": "chinese"],
                      ["name" : "Comfort Food", "code": "comfortfood"],
                      ["name" : "Corsican", "code": "corsican"],
                      ["name" : "Creperies", "code": "creperies"],
                      ["name" : "Cuban", "code": "cuban"],
                      ["name" : "Curry Sausage", "code": "currysausage"],
                      ["name" : "Cypriot", "code": "cypriot"],
                      ["name" : "Czech", "code": "czech"],
                      ["name" : "Czech/Slovakian", "code": "czechslovakian"],
                      ["name" : "Danish", "code": "danish"],
                      ["name" : "Delis", "code": "delis"],
                      ["name" : "Diners", "code": "diners"],
                      ["name" : "Dumplings", "code": "dumplings"],
                      ["name" : "Eastern European", "code": "eastern_european"],
                      ["name" : "Ethiopian", "code": "ethiopian"],
                      ["name" : "Fast Food", "code": "hotdogs"],
                      ["name" : "Filipino", "code": "filipino"],
                      ["name" : "Fish & Chips", "code": "fishnchips"],
                      ["name" : "Fondue", "code": "fondue"],
                      ["name" : "Food Court", "code": "food_court"],
                      ["name" : "Food Stands", "code": "foodstands"],
                      ["name" : "French", "code": "french"],
                      ["name" : "French Southwest", "code": "sud_ouest"],
                      ["name" : "Galician", "code": "galician"],
                      ["name" : "Gastropubs", "code": "gastropubs"],
                      ["name" : "Georgian", "code": "georgian"],
                      ["name" : "German", "code": "german"],
                      ["name" : "Giblets", "code": "giblets"],
                      ["name" : "Gluten-Free", "code": "gluten_free"],
                      ["name" : "Greek", "code": "greek"],
                      ["name" : "Halal", "code": "halal"],
                      ["name" : "Hawaiian", "code": "hawaiian"],
                      ["name" : "Heuriger", "code": "heuriger"],
                      ["name" : "Himalayan/Nepalese", "code": "himalayan"],
                      ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
                      ["name" : "Hot Dogs", "code": "hotdog"],
                      ["name" : "Hot Pot", "code": "hotpot"],
                      ["name" : "Hungarian", "code": "hungarian"],
                      ["name" : "Iberian", "code": "iberian"],
                      ["name" : "Indian", "code": "indpak"],
                      ["name" : "Indonesian", "code": "indonesian"],
                      ["name" : "International", "code": "international"],
                      ["name" : "Irish", "code": "irish"],
                      ["name" : "Island Pub", "code": "island_pub"],
                      ["name" : "Israeli", "code": "israeli"],
                      ["name" : "Italian", "code": "italian"],
                      ["name" : "Japanese", "code": "japanese"],
                      ["name" : "Jewish", "code": "jewish"],
                      ["name" : "Kebab", "code": "kebab"],
                      ["name" : "Korean", "code": "korean"],
                      ["name" : "Kosher", "code": "kosher"],
                      ["name" : "Kurdish", "code": "kurdish"],
                      ["name" : "Laos", "code": "laos"],
                      ["name" : "Laotian", "code": "laotian"],
                      ["name" : "Latin American", "code": "latin"],
                      ["name" : "Live/Raw Food", "code": "raw_food"],
                      ["name" : "Lyonnais", "code": "lyonnais"],
                      ["name" : "Malaysian", "code": "malaysian"],
                      ["name" : "Meatballs", "code": "meatballs"],
                      ["name" : "Mediterranean", "code": "mediterranean"],
                      ["name" : "Mexican", "code": "mexican"],
                      ["name" : "Middle Eastern", "code": "mideastern"],
                      ["name" : "Milk Bars", "code": "milkbars"],
                      ["name" : "Modern Australian", "code": "modern_australian"],
                      ["name" : "Modern European", "code": "modern_european"],
                      ["name" : "Mongolian", "code": "mongolian"],
                      ["name" : "Moroccan", "code": "moroccan"],
                      ["name" : "New Zealand", "code": "newzealand"],
                      ["name" : "Night Food", "code": "nightfood"],
                      ["name" : "Norcinerie", "code": "norcinerie"],
                      ["name" : "Open Sandwiches", "code": "opensandwiches"],
                      ["name" : "Oriental", "code": "oriental"],
                      ["name" : "Pakistani", "code": "pakistani"],
                      ["name" : "Parent Cafes", "code": "eltern_cafes"],
                      ["name" : "Parma", "code": "parma"],
                      ["name" : "Persian/Iranian", "code": "persian"],
                      ["name" : "Peruvian", "code": "peruvian"],
                      ["name" : "Pita", "code": "pita"],
                      ["name" : "Pizza", "code": "pizza"],
                      ["name" : "Polish", "code": "polish"],
                      ["name" : "Portuguese", "code": "portuguese"],
                      ["name" : "Potatoes", "code": "potatoes"],
                      ["name" : "Poutineries", "code": "poutineries"],
                      ["name" : "Pub Food", "code": "pubfood"],
                      ["name" : "Rice", "code": "riceshop"],
                      ["name" : "Romanian", "code": "romanian"],
                      ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
                      ["name" : "Rumanian", "code": "rumanian"],
                      ["name" : "Russian", "code": "russian"],
                      ["name" : "Salad", "code": "salad"],
                      ["name" : "Sandwiches", "code": "sandwiches"],
                      ["name" : "Scandinavian", "code": "scandinavian"],
                      ["name" : "Scottish", "code": "scottish"],
                      ["name" : "Seafood", "code": "seafood"],
                      ["name" : "Serbo Croatian", "code": "serbocroatian"],
                      ["name" : "Signature Cuisine", "code": "signature_cuisine"],
                      ["name" : "Singaporean", "code": "singaporean"],
                      ["name" : "Slovakian", "code": "slovakian"],
                      ["name" : "Soul Food", "code": "soulfood"],
                      ["name" : "Soup", "code": "soup"],
                      ["name" : "Southern", "code": "southern"],
                      ["name" : "Spanish", "code": "spanish"],
                      ["name" : "Steakhouses", "code": "steak"],
                      ["name" : "Sushi Bars", "code": "sushi"],
                      ["name" : "Swabian", "code": "swabian"],
                      ["name" : "Swedish", "code": "swedish"],
                      ["name" : "Swiss Food", "code": "swissfood"],
                      ["name" : "Tabernas", "code": "tabernas"],
                      ["name" : "Taiwanese", "code": "taiwanese"],
                      ["name" : "Tapas Bars", "code": "tapas"],
                      ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
                      ["name" : "Tex-Mex", "code": "tex-mex"],
                      ["name" : "Thai", "code": "thai"],
                      ["name" : "Traditional Norwegian", "code": "norwegian"],
                      ["name" : "Traditional Swedish", "code": "traditional_swedish"],
                      ["name" : "Trattorie", "code": "trattorie"],
                      ["name" : "Turkish", "code": "turkish"],
                      ["name" : "Ukrainian", "code": "ukrainian"],
                      ["name" : "Uzbek", "code": "uzbek"],
                      ["name" : "Vegan", "code": "vegan"],
                      ["name" : "Vegetarian", "code": "vegetarian"],
                      ["name" : "Venison", "code": "venison"],
                      ["name" : "Vietnamese", "code": "vietnamese"],
                      ["name" : "Wok", "code": "wok"],
                      ["name" : "Wraps", "code": "wraps"],
                      ["name" : "Yugoslav", "code": "yugoslav"]]
    
    var categoriesState = [Bool](count:169, repeatedValue: false) // categories size
    var isCategoriesExpanded = false
    let categoriesPreview = 5
    
    var searchSettings:YelpSearchSettings?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initTableView()
        initNavigationBar()
        loadSearchSettings()
    }

    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.sectionIndexColor = UIColor.redColor()
    }
    
    func initNavigationBar() {
        navigationController?.navigationBar.barTintColor = UIColor.redColor()
    }
    
    func loadSearchSettings() {
        //print("Settings start")
        //print(searchSettings!.categories)
        // load category
        for (index, category) in categories.enumerate() {
            for scategory in searchSettings!.categories {
                if scategory == category["code"] {
                    categoriesState[index] = true
                }
            }
        }
        // load distance
        switch searchSettings!.maxDistance {
        case 0:
            distanceSelectedIndex = 0
        case 0.3:
            distanceSelectedIndex = 1
        case 1:
            distanceSelectedIndex = 2
        case 5:
            distanceSelectedIndex = 3
        case 10:
            distanceSelectedIndex = 4
        default:
            distanceSelectedIndex = 0
        }
        // load sort
        switch searchSettings!.sortBy.rawValue {
        case YelpSortMode.BestMatched.rawValue:
            sortSelectedIndex = 0
        case YelpSortMode.Distance.rawValue:
            sortSelectedIndex = 1
        case YelpSortMode.HighestRated.rawValue:
            sortSelectedIndex = 2
        default:
            sortSelectedIndex = 0
        }
    }

    @IBAction func onCancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segueSave" {
            setCategories()
            let nvc = segue.destinationViewController as! UINavigationController
            let vc = nvc.topViewController as! BusinessesViewController
            vc.searchSettings = self.searchSettings!
            vc.searchSettings!.offset = 0
            //print("Settings end")
            //print(searchSettings!.categories)
            //vc.searchSettings?.categories = self.searchSettings?.categories
        }
    }
    
    func setCategories() {
        for (index, state) in categoriesState.enumerate() {
            let code = categories[index]["code"]
            if state {
                if !(self.searchSettings?.categories.contains(code!))! {
                    self.searchSettings?.categories.append(code!)
                }
            }
            else {
                for (sindex, value) in (self.searchSettings?.categories.enumerate())! {
                    if value == code {
                        self.searchSettings?.categories.removeAtIndex(sindex)
                    }
                }
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // Section Deal Offer
        if section == 0 {
            
        }
        // Section Distance
        else if section == 1 {
            return "Distance"
        }
        // Section Sort
        else if section == 2 {
            return "Sort by"
        }
        // Section Category
        else if section == 3 {
            return "Categories"
        }
        return nil
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Section Deal Offer
        if section == 0 {
            return 1
        }
        // Section Distance
        else if section == 1 {
            if isDistanceExpanded {
                return distances.count
            }
            else {
                return 1
            }
        }
        // Section Sort
        else if section == 2 {
            if isSortExpanded {
                return sorts.count
            }
            else {
                return 1
            }
        }
        // Section Category
        else if section == 3 {
            if isCategoriesExpanded {
                return categories.count
            }
            else {
                return categoriesPreview + 1
            }
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Section Deal Offer
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DealOfferCell") as! DealOfferCell
            cell.delegate = self
            cell.switchOffer.on = searchSettings!.deal
            return cell
        }
        // Section Distance
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCellWithIdentifier("DistanceCell") as! DistanceCell
            if isDistanceExpanded {
                cell.lblDistance.text = distances[indexPath.row]["distance"]
            }
            else {
                cell.lblDistance.text = distances[distanceSelectedIndex]["distance"]
            }
            return cell
        }
        // Section Sort
        else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCellWithIdentifier("SortCell") as! SortCell
            if isSortExpanded {
                cell.lblSortBy.text = sorts[indexPath.row]["by"]
            }
            else {
                cell.lblSortBy.text = sorts[sortSelectedIndex]["by"]
            }
            return cell
        }
        // Section Category
        else if indexPath.section == 3 {
            if isCategoriesExpanded {
                let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! CategoryCell
                cell.lblCategory.text = categories[indexPath.row]["name"]
                cell.delegate = self
                cell.switchCategory.on = categoriesState[indexPath.row]
                return cell
            }
            else {
                if indexPath.row < categoriesPreview {
                    let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell") as! CategoryCell
                    cell.lblCategory.text = categories[indexPath.row]["name"]
                    cell.delegate = self
                    cell.switchCategory.on = categoriesState[indexPath.row]
                    return cell
                }
                else {
                    let cell = tableView.dequeueReusableCellWithIdentifier("SeeAllCell")! as UITableViewCell
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        // Section Distance
        if indexPath.section == 1 {
            distanceSelectedIndex = indexPath.row
            searchSettings!.maxDistance = Double(distances[distanceSelectedIndex]["value"]!)
            isDistanceExpanded = !isDistanceExpanded
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
        }
        // Section Sort
        else if indexPath.section == 2 {
            sortSelectedIndex = indexPath.row
            switch sortSelectedIndex {
            case 0:
                searchSettings!.sortBy = YelpSortMode.BestMatched
            case 1:
                searchSettings!.sortBy = YelpSortMode.Distance
            case 2:
                searchSettings!.sortBy = YelpSortMode.HighestRated
            default:
                searchSettings!.sortBy = YelpSortMode.Distance
            }
            isSortExpanded = !isSortExpanded
            tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
        }
        // Section Category
        else if indexPath.section == 3 {
            if !isCategoriesExpanded {
                // if click on "See All"
                if indexPath.row == categoriesPreview {
                    isCategoriesExpanded = true
                    tableView.reloadSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
                }
            }
            
            
        }
    }

}

extension SettingsViewController: DealOfferCellDelegate {
    func dealOfferCell(dealOfferCell: DealOfferCell, didChangeState state: Bool) {
        searchSettings!.deal = state
    }
}

extension SettingsViewController: CategoryCellDelegate {
    func categoryCell(categoryCell: CategoryCell, didChangeState state: Bool) {
        if let indexPath = tableView.indexPathForCell(categoryCell) {
            categoriesState[indexPath.row] = !categoriesState[indexPath.row]
        }
    }
}