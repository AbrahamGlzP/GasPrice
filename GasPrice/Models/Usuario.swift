//
//  Usuario.swift
//  GasPrice
//
//  Created by Hector on 07/11/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation

struct Usuario: Codable {
    var id: Int!
    var Nombre: String!
    var Apellido: String!
    var Correo: String!
    var Contrasena: String!
    var Usuario: String!
    
    enum CodingKeys: String, CodingKey {
    
    case id = "id"
    case Nombre = "Nombre"
    case Apellido = "Apellido"
    case Correo = "Correo"
    case Contrasena = "Contrasena"
    case Usuario = "Usuario"
    }
    
    init(id: Int, nombre: String, apellido :String, correo: String, contrasena: String, usuario: String)
       {
           self.id = id
           self.Nombre = nombre
           self.Apellido = apellido
           self.Correo = correo
           self.Contrasena = contrasena
           self.Usuario = usuario
       }
    
} 
