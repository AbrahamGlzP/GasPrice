//
//  MenuVC.swift
//  GasPrice
//
//  Created by Hector on 10/25/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {

    var mapReference: MapVC!
    var usuario = [Usuario]()
    
    @IBOutlet weak var txtNomUsuario: UILabel!
    
    @IBOutlet weak var txtCorreoElectronico: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

           usuario = loadClient()
             if !loadClient().isEmpty{
                 txtNomUsuario.text = usuario[0].Nombre
                 
                 txtCorreoElectronico.text = usuario[0].Correo
             }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
        usuario = loadClient()
        if !loadClient().isEmpty{
            txtNomUsuario.text = usuario[0].Nombre
            
            txtCorreoElectronico.text = usuario[0].Correo
        }
        
        
    }
    
    @IBAction func closeClicked(_ sender: Any) {
        backFunction(viewRef: self)
    }
    @IBAction func btnMisGasolineras(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "MisGasVc")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
}
