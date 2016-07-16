//
//  DealOfferCell.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/16/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import SevenSwitch

@objc protocol DealOfferCellDelegate: class {
    optional func dealOfferCell(dealOfferCell: DealOfferCell, didChangeState state:Bool)
}

class DealOfferCell: UITableViewCell {

    //@IBOutlet weak var switchOffer: UISwitch!
    let switchOffer = SevenSwitch()
    
    weak var delegate:DealOfferCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        switchOffer.addTarget(self, action: #selector(DealOfferCell.onValueChanged), forControlEvents: .ValueChanged)
        switchOffer.onTintColor = UIColor.redColor()
        switchOffer.thumbImage = UIImage(named: "yelp_circle")
        self.accessoryView = switchOffer
    }

    func onValueChanged() {
        delegate?.dealOfferCell!(self, didChangeState: switchOffer.on)
    }
    
    //@IBAction func onSwitchValueChanged(sender: AnyObject) {
    //    delegate?.dealOfferCell!(self, didChangeState: switchOffer.on)
    //}

}
