//
//  GasStop.swift
//  GasPrice
//
//  Created by Hector on 10/31/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation
import UIKit
class GasStop {
    var nombre:Double
    var ubicacion:Double
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
