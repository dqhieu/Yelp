//
//  CategoryCell.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol CategoryCellDelegate: class {
    optional func categoryCell(categoryCell: CategoryCell, didChangeState state:Bool)
}

class CategoryCell: UITableViewCell {

    @IBOutlet weak var switchCategory: UISwitch!
    @IBOutlet weak var lblCategory: UILabel!
    
    weak var delegate:CategoryCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchCategory.onTintColor = UIColor.redColor()
    }

    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        delegate?.categoryCell!(self, didChangeState: switchCategory.on)
    }
    

}
