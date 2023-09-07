//
//  APIlist.swift
//  Heka Healthy You
//
//  Created by saeem  on 13/08/23.
//

import Foundation
class APIManager {
    
    static let shared = APIManager()
    
    let loginURL = "https://zylicontechnologies.com/hekaAPI/userAPI/customer/login.php"
    let verifyOTPURL = "https://zylicontechnologies.com/hekaAPI/userAPI/customer/verifyOtp.php"
    let registrationURL = "https://zylicontechnologies.com/hekaAPI/userAPI/registration.php"
    let fetchCustomerDataURL = "https://zylicontechnologies.com/hekaAPI/userAPI/customer/fetchCustomer.php"

}


