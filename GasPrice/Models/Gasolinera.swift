//
//  Gasolinera.swift
//  GasPrice
//
//  Created by Hector on 07/11/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation

struct Gasolinera: Codable {
    
    var id: Int!
    var Nombre: String!
    var Latitud: Double!
    var Longitud: Double!
    var Regular: Double!
    var Premium: Double!

enum CodingKeys: String, CodingKey {
    
    case id = "id"
    case Nombre = "Nombre"
    case Latitud = "Latitud"
    case Longitud = "Longitud"
    case Regular = "Regular"
    case Premium = "Premium"
    }
    
    init(id: Int, nombre: String, latitud : Double, longitud: Double, regular: Double, premium: Double)
    {
        self.id = id
        self.Nombre = nombre
        self.Latitud = latitud
        self.Longitud = longitud
        self.Regular = regular
        self.Premium = premium
    }
    
}
