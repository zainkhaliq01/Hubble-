//
//  MainViewController.swift
//  Hubble
//
//  Created by Zain Khaliq on 5/27/17.
//  Copyright © 2017 Hubble. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var MapView: MKMapView!
    
    var updateCount = 0
    
    var manger = CLLocationManager() //incharge of tracking location asks permision etc
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        manger.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("Ready to go")
            MapView.showsUserLocation = true
            manger.startUpdatingLocation()
           
        } else {
            manger.requestWhenInUseAuthorization()

            
        }
        
        
    
    }
// using a new var called updateCount this function allows the app to zoom into our current location where ass the above funtion only tells our location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if updateCount < 3 {
            let region = MKCoordinateRegionMakeWithDistance(manger.location!.coordinate, 1000, 1000)
            MapView.setRegion(region, animated: false)
            updateCount += 1
        } else {
          manger.stopUpdatingLocation() //safes battery so the function doesnt reapeat itself over and over
        }
    }
    //when clicked go to current location 
    @IBAction func MyLocation(_ sender: Any) {
        if let coord = manger.location?.coordinate {
        let region = MKCoordinateRegionMakeWithDistance(coord, 1000, 1000)
        MapView.setRegion(region, animated: true)
        }

    }

}
