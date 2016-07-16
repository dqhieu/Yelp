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
            if let imgURL = business.imageURL {
                imgViewPhoto.setImageWithURLRequest(NSURLRequest(URL: imgURL), placeholderImage: nil, success: { (request, respone, image) in
                    self.imgViewPhoto.alpha = 0
                    UIView.animateWithDuration(0.5, animations: {
                        self.imgViewPhoto.image = image
                        self.imgViewPhoto.alpha = 1
                    })

                    }, failure: nil)
            }
            if let imgURL = business.ratingImageURL {
                imgViewStar.setImageWithURLRequest(NSURLRequest(URL: imgURL), placeholderImage: nil, success: { (request, respone, image) in
                    self.imgViewStar.alpha = 0
                    UIView.animateWithDuration(0.5, animations: {
                        self.imgViewStar.image = image
                        self.imgViewStar.alpha = 1
                    })
                    }, failure: nil)
            }
            if let name = business.name {
                lblName.text = name
            }
            if let distance = business.distance {
                lblDistance.text = String(format: "%.2f mi", distance)
            }
            if let reviewCount = business.reviewCount {
                lblReview.text = "\(reviewCount.integerValue) reviews"
            }
            if let address = business.address {
                lblAddress.text = address
            }
            if let category = business.categories {
                lblCategory.text = category
            }
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
