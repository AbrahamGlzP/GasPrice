//
//  utils.swift
//  GasPrice
//
//  Created by Hector on 10/25/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation
import UIKit

//Metodo para regresar a la vista anterior usado normalmente para regresar al home
func backFunction(viewRef : UIViewController){
    if let nav = viewRef.navigationController {
        nav.popViewController(animated: true)
    } else {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        viewRef.view.window!.layer.add(transition, forKey: kCATransition)
        viewRef.dismiss(animated: false, completion: nil)
    }
}


extension CATransition {

//New viewController will appear from bottom of screen.
func segueFromBottom() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromTop
    return self
}
//New viewController will appear from top of screen.
func segueFromTop() -> CATransition {
    self.duration = 0.375 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromBottom
    return self
}
 //New viewController will appear from left side of screen.
func segueFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.moveIn
    self.subtype = CATransitionSubtype.fromLeft
    return self
}
//New viewController will pop from right side of screen.
func popFromRight() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromRight
    return self
}
//New viewController will appear from left side of screen.
func popFromLeft() -> CATransition {
    self.duration = 0.1 //set the duration to whatever you'd like.
    self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
    self.type = CATransitionType.reveal
    self.subtype = CATransitionSubtype.fromLeft
    return self
   }
    
}

//Metodo para guardar el cliente, hacer un arreglo de clientes
func saveClient(_ client: [Usuario]) {
    let data = client.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "usuarioLogged")
}

//Metodo para cargar cliente, siempre usar el indice 0
func loadClient() -> [Usuario] {
    guard let encodedData = UserDefaults.standard.array(forKey: "usuarioLogged") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(Usuario.self, from: $0) }
}

//Metodo para guardar las sucursales, hacer un arreglo de sucursales
func saveGasStops(_ sucursales: [Gasolinera]) {
    let data = sucursales.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "gasolinera")
}

//Metodo para cargar las sucursales
func loadGasStops() -> [Gasolinera] {
    guard let encodedData = UserDefaults.standard.array(forKey: "gasolinera") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(Gasolinera.self, from: $0) }
}

//Metodo para guardar las sucursales, hacer un arreglo de sucursales
func saveFavGasStops(_ sucursales: [Gasolinera]) {
    let data = sucursales.map { try? JSONEncoder().encode($0) }
    UserDefaults.standard.set(data, forKey: "gasolineraFav")
}

//Metodo para cargar las sucursales
func loadFavGasStops() -> [Gasolinera] {
    guard let encodedData = UserDefaults.standard.array(forKey: "gasolineraFav") as? [Data] else {
        return []
    }
    return encodedData.map { try! JSONDecoder().decode(Gasolinera.self, from: $0) }
}

