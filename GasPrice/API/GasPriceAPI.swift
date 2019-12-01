//
//  GasPriceAPI.swift
//  GasPrice
//
//  Created by Hector on 07/11/19.
//  Copyright © 2019 Cactacea. All rights reserved.
//

import Foundation

class GasPriceAPI {
    static let BASE_URL = "https://gasprice-api.herokuapp.com/"
    
    static func isValidEmail(email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}
