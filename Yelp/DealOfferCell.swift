//
//  DealOfferCell.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

@objc protocol DealOfferCellDelegate: class {
    optional func dealOfferCell(dealOfferCell: DealOfferCell, didChangeState state:Bool)
}

class DealOfferCell: UITableViewCell {

    @IBOutlet weak var switchOffer: UISwitch!
    
    weak var delegate:DealOfferCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchOffer.onTintColor = UIColor.redColor()
    }

    @IBAction func onSwitchValueChanged(sender: AnyObject) {
        delegate?.dealOfferCell!(self, didChangeState: switchOffer.on)
    }

}
