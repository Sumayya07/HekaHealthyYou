//
//  FetchCustomerModel.swift
//  Heka Healthy You
//
//  Created by saeem  on 21/08/23.
//

import Foundation

struct CustomerResponse: Codable {
    let code: Int?
    let status: String?
    let message: String?
    let customer: CustomerDetail?
}

struct CustomerDetail: Codable {
    let customerId: String?
    let firstName: String?
    let lastName: String?
    let mobileNumber: String?
    let email: String?
    let idType: String?  // Since it can be null in JSON
    let frontImage: String?  // Since it can be null in JSON
    let backImage: String?  // Since it can be null in JSON
    let userProfileStatus: String?
    let status: String?
    let otp: String?
    let userResendStatus: String?
    let userResendTimestamp: String?
    let createdBy: String?
    let createdAt: String?
}

