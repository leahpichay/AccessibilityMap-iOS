//
//  CSCLocale.swift
//  MapDemo
//
//  Created by R on 11/7/16.
//  Copyright © 2016 R. All rights reserved.
//

import Foundation
import MapKit

class CSCLocale : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    
    init(coord: CLLocationCoordinate2D, named: String, detail: String) {
        coordinate = coord
        title = named
        subtitle = detail
        
        super.init()
    }
    
}
