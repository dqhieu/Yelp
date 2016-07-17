//
//  DetailViewController.swift
//  Yelp
//
//  Created by Dinh Quang Hieu on 7/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {

    var business:Business!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var imgViewPhoto: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var imgViewRating: UIImageView!
    @IBOutlet weak var lblReview: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        loadData()
        initMapView()
    }

    func initNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }
    
    func loadData() {
        if let imgURL = business.imageURL {
            imgViewPhoto.setImageWithURLRequest(NSURLRequest(URL: imgURL), placeholderImage: nil, success: { (request, respone, image) in
                self.imgViewPhoto.alpha = 0
                UIView.animateWithDuration(0.5, animations: {
                    self.imgViewPhoto.image = image
                    self.imgViewPhoto.alpha = 1
                })
                
                }, failure: nil)
            imgViewPhoto.layer.cornerRadius = 4
        }
        if let imgURL = business.ratingImageURL {
            imgViewRating.setImageWithURLRequest(NSURLRequest(URL: imgURL), placeholderImage: nil, success: { (request, respone, image) in
                self.imgViewRating.alpha = 0
                UIView.animateWithDuration(0.5, animations: {
                    self.imgViewRating.image = image
                    self.imgViewRating.alpha = 1
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

    func initMapView() {
        mapView.delegate = self
        
        let latitude:Double = business.latitude!
        let longitude:Double = business.longitude!
        
        let latitudeDelta:CLLocationDegrees = 0.01
        let longtitudeDelta:CLLocationDegrees = 0.01
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latitudeDelta, longtitudeDelta)
        let location = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = business.name
        annotation.subtitle = business.categories
        annotation.coordinate = location
        mapView.addAnnotation(annotation)
    }

}

extension DetailViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let identifier = "MyCustomAnnotation"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        imageView.setImageWithURL((business?.imageURL)!)
        
        annotationView?.leftCalloutAccessoryView = imageView
        
        return annotationView
    }

}