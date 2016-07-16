//
//  CategoryCell.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import SevenSwitch

@objc protocol CategoryCellDelegate: class {
    optional func categoryCell(categoryCell: CategoryCell, didChangeState state:Bool)
}

class CategoryCell: UITableViewCell {

    let switchCategory = SevenSwitch()
    @IBOutlet weak var lblCategory: UILabel!
    
    weak var delegate:CategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchCategory.addTarget(self, action: #selector(CategoryCell.onValueChanged), forControlEvents: .ValueChanged)
        switchCategory.onTintColor = UIColor.redColor()
        switchCategory.thumbImage = UIImage(named: "yelp_circle")
        self.accessoryView = switchCategory
    }
    
    func onValueChanged() {
        delegate?.categoryCell!(self, didChangeState: switchCategory.on)
    }
    

}
