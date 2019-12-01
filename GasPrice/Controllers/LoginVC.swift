//
//  LoginVC.swift
//  GasPrice
//
//  Created by Hector on 08/11/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    var usuario: Usuario!
    @IBOutlet weak var txtCorreo: UITextField!
    @IBAction func btnAtras(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var txtContrasena: UITextField!
    @IBAction func iniciarSesion(_ sender: Any) {
        
        DispatchQueue.main.async {
            if self.txtCorreo.text!.isEmpty || self.txtContrasena.text!.isEmpty
                   {
                       let alert = UIAlertController(title: "Alerta", message: "No puedes dejar campos vacíos", preferredStyle: UIAlertController.Style.alert)
                       alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                       return
                   }
                   
                   
                   
                   guard let url = URL(string:GasPriceAPI.BASE_URL + "users/signin")else{return}
                   var request = URLRequest(url:url)
                   request.httpMethod = "POST"
                   request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                   request.addValue(self.txtCorreo.text!, forHTTPHeaderField: "Correo")
                   request.addValue(self.txtContrasena.text!, forHTTPHeaderField: "Contrasena")
                
                   
                   let session = URLSession.shared
                   let task = session.dataTask(with: request){(data,response,_) in
                       
                       guard let data = data else{return}
                       
                       do{
                        self.usuario = try JSONDecoder().decode(Usuario.self, from: data)
                           DispatchQueue.main.async(execute: { () -> Void in
                               
                               //Si retorno usuario existente
                            if self.usuario.id != nil{
                                var clientAux = [Usuario]()
                                clientAux.append(self.usuario)
                                saveClient(clientAux)
                                
                                  
                               }
                               else{
                                   let alert = UIAlertController(title: "Alerta", message: "No existe este usuario", preferredStyle: UIAlertController.Style.alert)
                                   alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                                   self.present(alert, animated: true, completion: nil)
                               }
                           })
                       }catch let error{
                           print(error)
                           
                           //Si el usuario esta vacio o no retorno un usuario
                           let alert = UIAlertController(title: "Alerta", message: "No existe este usuario", preferredStyle: UIAlertController.Style.alert)
                           alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                           self.present(alert, animated: true, completion: nil)
                       }
                   }
                   task.resume()
                   

            
            self.dismiss(animated: true, completion: nil)
        }
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtCorreo.text = "RubyOn@Rails.com"
        txtContrasena.text = "API-Master115"
        // Do any additional setup after loading the view.
    }
    

}
