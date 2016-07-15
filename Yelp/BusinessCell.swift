//
//  BusinessCell.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/15/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var imgViewPhoto: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var imgViewStar: UIImageView!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    var business: Business! {
        didSet {
            imgViewPhoto.setImageWithURLRequest(NSURLRequest(URL: business.imageURL!), placeholderImage: nil, success: { (request, respone, image) in
                self.imgViewPhoto.alpha = 0
                UIView.animateWithDuration(0.5, animations: {
                    self.imgViewPhoto.image = image
                    self.imgViewPhoto.alpha = 1
                })
                }, failure: nil)
            
            
            
            imgViewStar.setImageWithURLRequest(NSURLRequest(URL: business.ratingImageURL!), placeholderImage: nil, success: { (request, respone, image) in
                    self.imgViewStar.alpha = 0
                    UIView.animateWithDuration(0.5, animations: {
                        self.imgViewStar.image = image
                        self.imgViewStar.alpha = 1
                    })
            }, failure: nil)
            lblName.text = business.name!
            lblDistance.text = business.distance!
            lblReview.text = "\(business.reviewCount!.integerValue) reviews"
            lblAddress.text = business.address!
            lblCategory.text = business.categories
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
