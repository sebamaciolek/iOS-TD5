//
//  Annotation.swift
//  TD5
//
//  Created by MACIOLEK Sebastian on 28/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import Foundation
import MapKit

class Annotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var image: String?
    var phone: String?
    var latitude: Double
    var longitude: Double
    var url: String?
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
