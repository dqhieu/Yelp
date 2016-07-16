//
//  YelpSearchSettings.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

struct YelpSearchSettings {
    var term:String! = ""
    var sortBy:YelpSortMode! = YelpSortMode.Distance
    var categories:[String]! = []
    var maxDistance:Double! = 0
    var deal:Bool! = false
}
