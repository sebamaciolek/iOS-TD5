//
//  POI.swift
//  TD5
//
//  Created by Marine on 20/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import Foundation

class POI {
    var id:Int
    var name:String
    var image:String
    var latitude:Double
    var longitude:Double
    var phone:String
    var mail:String
    var url:String
    var description:String
    
    init(id:Int, name:String, image:String, latitude:Double, longitude:Double, phone:String, mail:String, url:String, description:String){
        
        self.id = id
        self.name = name
        self.image = image
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
        self.mail = mail
        self.url = url
        self.description = description
        
    }
}
