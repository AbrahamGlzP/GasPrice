//
//  AppDelegate.swift
//  GasPrice
//
//  Created by Hector on 10/24/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    var gasolineras = [Gasolinera]()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UserDefaults.standard.removeObject(forKey: "usuarioLogged")
        getGasolineras()
        
        UserDefaults.standard.removeObject(forKey: "gasolineraFav")
        getGasolineras()

        
        return true
    }
    
    func getGasolineras(){
        
        guard let url = URL(string:GasPriceAPI.BASE_URL + "gas_stops")else{return}
        
        var request = URLRequest(url:url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let task = session.dataTask(with: request){(data,response,_) in
            guard let data = data else{return}
            
            do{
                self.gasolineras = try JSONDecoder().decode([Gasolinera].self, from: data)
                saveGasStops(self.gasolineras)
                print(self.gasolineras)
                
            }catch let error{
                print(error)
            }
        }
        task.resume()
        
        //addPlaces()
    }

}

