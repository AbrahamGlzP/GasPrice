//
//  Place.swift
//  GasPrice
//
//  Created by Hector on 10/26/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation

class Place {
    var lat:Double
    var lon:Double
    var nombre:String
    var edificio:String
    
    init(lat:Double, lon:Double, nombre:String, edificio:String)
    {
        self.lat = lat
        self.lon = lon
        self.nombre = nombre
        self.edificio = edificio
    }
}
