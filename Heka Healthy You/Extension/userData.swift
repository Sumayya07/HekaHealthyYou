//
//  userData.swift
//  Heka Healthy You
//
//  Created by Sumayya Siddiqui on 22/08/23.
//
import Foundation

struct User {
    var email: String
    var lastName: String
    var firstName: String
    var customerId: String
    var mobileNumber: String

}

class UserManager {
    static let shared = UserManager()
    
    var currentUser: User? {
        didSet {
            if let user = currentUser {
                print("User data updated:")
                print("Email: \(user.email)")
                print("First Name: \(user.firstName)")
                print("Last Name: \(user.lastName)")
                print("Customer ID: \(user.customerId)")
                print("Mobile Number: \(user.mobileNumber)")
                
            } else {
                print("currentUser set to nil.")
            }
        }
    }
    
    private init() {
        print("UserManager initialized.")
    }
}

