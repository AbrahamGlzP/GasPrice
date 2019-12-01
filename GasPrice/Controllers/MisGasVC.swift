//
//  MisGasVC.swift
//  GasPrice
//
//  Created by Hector on 10/31/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit

class MisGasVC: UIViewController {

    var misGas = [Place]()
    var favGasStops = [Gasolinera]()
    
    @IBAction func btnAtras(_ sender: Any) {
        dismiss(animated:true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        favGasStops = loadFavGasStops()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        favGasStops = loadFavGasStops()
    }
    

}

extension MisGasVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favGasStops.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GasFavCell") as! GasFavCell
        
        cell.gasTitle.text = favGasStops[indexPath.row].Nombre
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "GasDetailVC") as! GasDetailVC
        controller.nombre = favGasStops[indexPath.row].Nombre
        controller.direccion = "Prueba"
        controller.regular = "Precio: $\(favGasStops[indexPath.row].Regular ?? 0)"
        controller.premium = "Precio: $\(favGasStops[indexPath.row].Premium ?? 0)"
        self.present(controller, animated: true, completion: nil)
    }
    
}
