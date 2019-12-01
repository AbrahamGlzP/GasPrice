//
//  GasDetailVC.swift
//  GasPrice
//
//  Created by Hector on 11/1/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit

class GasDetailVC: UIViewController {

    var nombre:String!
    var direccion:String!
    var regular:String!
    var premium:String!
    
    @IBOutlet weak var precioPremium: UILabel!
    @IBOutlet weak var precioRegular: UILabel!
    @IBOutlet weak var nombreGas: UILabel!
    @IBOutlet weak var direccionGas: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        nombreGas.text = nombre
        direccionGas.text = direccion
        precioRegular.text = regular
        precioPremium.text = premium
    }
    


}
