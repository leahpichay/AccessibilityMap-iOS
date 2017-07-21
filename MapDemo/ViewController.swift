//
//  ViewController.swift
//  MapDemo
//
//  Created by R on 9/30/16.
//  Copyright © 2016 R. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    let campusMarket = CLLocationCoordinate2D(latitude: 35.303529, longitude: -120.662795)
    
    let cscBuilding = CLLocationCoordinate2D(latitude: 35.300066, longitude: -120.662065)
    
    var CSCLocales = [CSCLocale]()
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var map: MKMapView!

    @IBOutlet weak var mapSegCntl: UISegmentedControl!
    
    @IBAction func getDirections(_ sender: AnyObject) {
        let campusMarketPlacemark = MKPlacemark(coordinate: campusMarket)
        let cscPlacemark = MKPlacemark(coordinate: cscBuilding)
        
        let campusMarketMapItem = MKMapItem(placemark: campusMarketPlacemark)
        let cscMapItem = MKMapItem(placemark: cscPlacemark)
        
        
        let mapItems = [campusMarketMapItem,cscMapItem]
        let directionOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        MKMapItem.openMaps(with: mapItems, launchOptions: directionOptions)
    }
    
    @IBAction func mapTypeChanged(_ sender: UISegmentedControl) {
        map.mapType = MKMapType(rawValue: UInt(sender.selectedSegmentIndex))!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //map.setCenter(startLocation, animated: true)
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let startRegion = MKCoordinateRegion(center: cscBuilding, span: span)
        map.setRegion(startRegion, animated: true)
        
        gatherCSCLocales()
        placeAnnotations()
        configureLocationManager()
    }
    
    func configureLocationManager() {
        CLLocationManager.locationServicesEnabled()
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
        locationManager.distanceFilter = 100.0
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for nextLocation in locations {
            var newRegion = map.region
            newRegion.center = nextLocation.coordinate
            map.setRegion(newRegion, animated: true)
        }
    }
    
    func gatherCSCLocales() {
        
        let cscBldg = CSCLocale(coord: cscBuilding, named: "CSC Building", detail: "Class HQ")
        let campMkt = CSCLocale(coord: campusMarket, named: "Campus Market", detail: "Food HQ")
        CSCLocales.append(cscBldg)
        CSCLocales.append(campMkt)
    }
    
    func placeAnnotations() {
        map.addAnnotations(CSCLocales)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation.subtitle! == "Class HQ") {
            let pinView = MKPinAnnotationView()
            pinView.pinTintColor = .red
            pinView.canShowCallout = true
            return pinView
        }
        
        if (annotation.subtitle! == "Food HQ") {
            let pinView = MKPinAnnotationView()
            pinView.pinTintColor = .green
            pinView.canShowCallout = true
            return pinView
        }
        
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

