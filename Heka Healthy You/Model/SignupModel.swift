//
//  SignupModel.swift
//  Heka Healthy You
//
//  Created by saeem  on 21/08/23.
//

import Foundation


struct UserRegistrationResponse: Codable {
    let code: Int?
    let status: String?
    let message: String?
    let customer: CustomerData?
}

struct CustomerData: Codable {
    let customerId: String?
    let firstName: String?
    let lastName: String?
    let mobileNumber: String?
    let email: String?
    let idType: String?
    let frontImage: String?
    let backImage: String?
    let userProfileStatus: String?
    let status: String?
    let otp: String?
    let userResendStatus: String?
    let userResendTimestamp: String?
    let createdBy: String?
    let createdAt: String?
}
