//
//  LoginViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 13/07/23.
//

import UIKit
import Reachability
import MBProgressHUD
import Toast

class LoginViewController: UIViewController, UITextFieldDelegate, CustomTextFieldDelegate {
    
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewMobileNumber: UIView!
    @IBOutlet var viewOne: UIView!
    @IBOutlet var viewTwo: UIView!
    @IBOutlet var viewThree: UIView!
    @IBOutlet var viewFour: UIView!
    @IBOutlet var viewFive: UIView!
    @IBOutlet var viewSix: UIView!
    @IBOutlet var viewDigits: UIView!
    
    @IBOutlet var loginsuccessfulview: UIView!
    @IBOutlet var txtFieldNumber: UITextField!
    
    @IBOutlet var phoneNoLabel: UITextField!
    @IBOutlet var btnSendOtp: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    
    @IBOutlet var otp1: CustomTextField!
    @IBOutlet var otp2: CustomTextField!
    @IBOutlet var otp3: CustomTextField!
    @IBOutlet var otp4: CustomTextField!
    @IBOutlet var otp5: CustomTextField!
    @IBOutlet var otp6: CustomTextField!
    
    var reachability: Reachability?
    var userId: String?
    var timer: Timer?
    var remainingTime = 60
    var countdownTimer: Timer!
    var totalTime = 60
    var customerId = ""
    var userProfileStatus = ""
    var mobileNumber: String?


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        viewDigits.isHidden = true
        loginsuccessfulview.isHidden = true
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor
        
        viewMobileNumber.layer.cornerRadius = 8
        viewMobileNumber.layer.borderWidth = 1
        viewMobileNumber.layer.borderColor = UIColor.black.cgColor
        
        viewOne.layer.cornerRadius = 8
        viewOne.layer.borderWidth = 1
        viewOne.layer.borderColor = UIColor.black.cgColor
        
        viewTwo.layer.cornerRadius = 8
        viewTwo.layer.borderWidth = 1
        viewTwo.layer.borderColor = UIColor.black.cgColor
        
        viewThree.layer.cornerRadius = 8
        viewThree.layer.borderWidth = 1
        viewThree.layer.borderColor = UIColor.black.cgColor
        
        viewFour.layer.cornerRadius = 8
        viewFour.layer.borderWidth = 1
        viewFour.layer.borderColor = UIColor.black.cgColor
        
        viewFive.layer.cornerRadius = 8
        viewFive.layer.borderWidth = 1
        viewFive.layer.borderColor = UIColor.black.cgColor
        
        viewSix.layer.cornerRadius = 8
        viewSix.layer.borderWidth = 1
        viewSix.layer.borderColor = UIColor.black.cgColor
        
        viewDigits.layer.cornerRadius = 12
        loginsuccessfulview.layer.cornerRadius = 12
        
        btnSendOtp.layer.cornerRadius = 8
        btnSendOtp.isEnabled = false // Add this line

        btnSubmit.layer.cornerRadius = 8
        
        btnSubmit.backgroundColor = UIColor.gray
        
        phoneNoLabel.delegate = self
        
        phoneNoLabel.keyboardType = .numberPad // Use the number pad keyboard
        phoneNoLabel.textContentType = .telephoneNumber // Enable autofill for telephone numbers

        
        
        phoneNoLabel.addTarget(self, action: #selector(txtFieldNumberDidChange), for: .editingChanged)
        
        otp1.deletionDelegate = self
              otp2.deletionDelegate = self
              otp3.deletionDelegate = self
              otp4.deletionDelegate = self
              otp5.deletionDelegate = self
              otp6.deletionDelegate = self

              otp1.delegate = self
              otp2.delegate = self
              otp3.delegate = self
              otp4.delegate = self
              otp5.delegate = self
              otp6.delegate = self
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    func textFieldDidDeleteBackward(_ textField: CustomTextField) {
            switch textField {
            case otp2:
                otp1.becomeFirstResponder()
            case otp3:
                otp2.becomeFirstResponder()
            case otp4:
                otp3.becomeFirstResponder()
            case otp5:
                otp4.becomeFirstResponder()
            case otp6:
                otp5.becomeFirstResponder()
            default:
                break
            }

            updateSubmitButtonColor()
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            let currentText = textField.text ?? ""
            let newText = (currentText as NSString).replacingCharacters(in: range, with: string)

            if textField == phoneNoLabel {
                return newText.count <= 10
            }

            if newText.count == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    switch textField {
                    case self.otp1:
                        self.otp2.becomeFirstResponder()
                    case self.otp2:
                        self.otp3.becomeFirstResponder()
                    case self.otp3:
                        self.otp4.becomeFirstResponder()
                    case self.otp4:
                        self.otp5.becomeFirstResponder()
                    case self.otp5:
                        self.otp6.becomeFirstResponder()
                    case self.otp6:
                        self.otp6.resignFirstResponder()
                    default:
                        break
                    }
                    self.updateSubmitButtonColor()
                }
            }
            return newText.count <= 1
        }
    
    func updateSubmitButtonColor() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) { [weak self] in
            if self?.areAllOTPFieldsFilled() == true {
                self?.btnSubmit.backgroundColor = UIColor(hexString: "#3F6B68")
            } else {
                self?.btnSubmit.backgroundColor = UIColor.systemGray // Or whatever your default color is
            }
        }
    }


    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func Sendotp(_ sender: Any) {
        SignupAPI()
           
           // Disable the button
           btnSendOtp.isEnabled = false
           
           // Set initial title for countdown
           btnSendOtp.setTitle("Resend in \(totalTime) seconds", for: .disabled)
           
           // Start the countdown
           startCountdown()
    }
    
    func startCountdown() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter() {
        if totalTime > 0 {
            totalTime -= 1
            btnSendOtp.setTitle("\(totalTime) seconds", for: .disabled)
            btnSendOtp.backgroundColor = UIColor.gray
        } else {
            btnSendOtp.setTitle("Send OTP", for: .normal)
            btnSendOtp.isEnabled = true
            btnSendOtp.backgroundColor = UIColor(hexString: "#3F6B68")
            resetCountdownTimer()
        }
    }

    func resetCountdownTimer() {
        countdownTimer.invalidate()
        totalTime = 60
    }

    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        print("Sending Customer ID: \(customerId ?? "nil")")

        guard let numberText = phoneNoLabel.text else {
            return
        }

        // Retrieving OTP text from each field
        let otpPart1 = otp1.text ?? ""
        let otpPart2 = otp2.text ?? ""
        let otpPart3 = otp3.text ?? ""
        let otpPart4 = otp4.text ?? ""
        let otpPart5 = otp5.text ?? ""
        let otpPart6 = otp6.text ?? ""

        let otpText = otpPart1 + otpPart2 + otpPart3 + otpPart4 + otpPart5 + otpPart6

        if numberText.count < 10 {
            // Show a pop-up for invalid phone number
            viewDigits.isHidden = true

            // Hide the pop-up after 3 seconds
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                self.viewDigits.isHidden = true
//            }
        } else if otpText.count < 6 {
            // Show a pop-up for invalid OTP
//            viewOTP.isHidden = false  // assuming you have a view named `viewOTP` for OTP pop-up, replace with appropriate name if different
            self.view.makeToast("Enter Complete OTP", duration: 3.0, position: .bottom)

            // Hide the pop-up after 3 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                self.viewOTP.isHidden = true
            }
        } else if numberText.count == 10 && otpText.count == 6 {
            // Both phone number and OTP are correctly filled
            verifyOTP()
        }
    }

    
    func areAllOTPFieldsFilled() -> Bool {
        return !(otp1.text?.isEmpty ?? true) &&
               !(otp2.text?.isEmpty ?? true) &&
               !(otp3.text?.isEmpty ?? true) &&
               !(otp4.text?.isEmpty ?? true) &&
               !(otp5.text?.isEmpty ?? true) &&
               !(otp6.text?.isEmpty ?? true)
    }
    
    
    @objc func txtFieldNumberDidChange(_ textField: UITextField) {
        guard let text = textField.text else {
            btnSendOtp.isEnabled = false
            btnSendOtp.backgroundColor = UIColor.gray
            return
        }
        
        if text.count >= 10 {
            btnSendOtp.isEnabled = true
            btnSendOtp.backgroundColor = UIColor(hexString: "#3F6B68")
        } else {
            btnSendOtp.isEnabled = false
            btnSendOtp.backgroundColor = UIColor.gray
        }
    }

}

extension LoginViewController {
    
    struct Response: Codable {
        let code: Int
        let userProfileStatus: String
        let userResendStatus: Int
        let status: String
        let message: String
        let customerId: String
        let userId: String
    }
    
    struct MinimalResponse: Codable {
        let customerId: String
        let userProfileStatus: String
    }

    
    func SignupAPI() {
        
        var reachability: Reachability?
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to start notifier")
            return
        }
        
        guard reachability?.connection != .unavailable else {
            SimpleAlert(withTitle: "", message: "Please Check your Internet")
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        let url = URL(string: APIManager.shared.loginURL)!
        var request = URLRequest(url: url)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let mobileNumber = phoneNoLabel.text ?? ""
        self.mobileNumber = mobileNumber

        print("Sending mobile number to API: \(mobileNumber)")
        let dataBody = createDataBody(withParameters: ["data": "{\"mobileNumber\":\"\(mobileNumber)\"}"], boundary: boundary)
        request.httpBody = dataBody
        
        request.httpMethod = "POST"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
                  if let data = data {
                      print("Raw API Response: \(String(data: data, encoding: .utf8) ?? "Invalid data received")")
                      let decoder = JSONDecoder()
                      do {
                          let apiResponse = try decoder.decode(Response.self, from: data)
                          DispatchQueue.main.async {
                              MBProgressHUD.hide(for: self.view, animated: true)
                              
                              switch apiResponse.status {
                              case "Success":
                                  self.userId = apiResponse.userId
                                  self.customerId = apiResponse.customerId
                                  print("Received Customer ID: \(apiResponse.customerId)")
                                  self.SimpleAlert(withTitle: "Success", message: "OTP Sent Successfully")
                              case "Unauthorized":
                                  self.SimpleAlert(withTitle: "Unauthorized", message: "Invalid credentials or session expired.")
                              default:
                                  self.SimpleAlert(withTitle: "Error", message: apiResponse.message)
                              }
                          }
                      } catch {
                          print("Decoding Error: \(error)")

                          // Attempt to decode only the customerId
                          if let minimalResponse = try? decoder.decode(MinimalResponse.self, from: data) {
                                                self.customerId = minimalResponse.customerId
                                                self.userProfileStatus = minimalResponse.userProfileStatus
                                                print("Received Customer ID from fallback decoding: \(minimalResponse.customerId)")
                                                print("Received UserProfileStatus from fallback decoding: \(minimalResponse.userProfileStatus)")
                                            }


                          DispatchQueue.main.async {
                              self.SimpleAlert(withTitle: "Success", message: "OTP Sent Successfully")
                              MBProgressHUD.hide(for: self.view, animated: true)
                          }
                      }
                  } else {
                      DispatchQueue.main.async {
                          self.SimpleAlert(withTitle: "Success", message: "OTP Sent Successfully")
                          MBProgressHUD.hide(for: self.view, animated: true)
                          print("Error \(String(describing: error))")
                      }
                  }
              }
              dataTask.resume()
    
}

    
    private func createDataBody(withParameters params: [String: String], boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()
        
        for (key, value) in params {
            body.append("--\(boundary)\(lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
            body.append("\(value)\(lineBreak)")
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

// MARK: FOR VERIFY OTP
extension LoginViewController {
    
    struct OTPResponse: Codable {
             let code: Int
             let status: String
             let message: String
             let userProfileStatus: UserProfileStatus
             let customer: Customer?
           
           struct Customer: Codable {
               let customerId: String
               let firstName: String
               let lastName: String
               let mobileNumber: String
               let email: String
               let idType: String?
               let frontImage: String?
               let backImage: String?
               let userProfileStatus: String
               let status: String
               let otp: String
               let userResendStatus: String
               let userResendTimestamp: String
               let createdBy: String
               let createdAt: String
           }
       }
    enum UserProfileStatus: Codable {
           case int(Int)
           case string(String)

           init(from decoder: Decoder) throws {
               let container = try decoder.singleValueContainer()
               if let intValue = try? container.decode(Int.self) {
                   self = .int(intValue)
                   return
               }
               if let stringValue = try? container.decode(String.self) {
                   self = .string(stringValue)
                   return
               }
               throw DecodingError.typeMismatch(UserProfileStatus.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Mismatched Types"))
           }
           
           func encode(to encoder: Encoder) throws {
               var container = encoder.singleValueContainer()
               switch self {
               case .int(let intValue):
                   try container.encode(intValue)
               case .string(let stringValue):
                   try container.encode(stringValue)
               }
           }
       }
    
    
    func verifyOTP() {
        
        var reachability: Reachability?
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to start notifier")
            return
        }
        
        guard reachability?.connection != .unavailable else {
            SimpleAlert(withTitle: "", message: "Please Check your Internet")
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        let url = URL(string: APIManager.shared.verifyOTPURL)! // Change this URL to your OTP verification URL
        var request = URLRequest(url: url)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        print("Stored Customer ID: \(self.customerId )")
        let otpString = "\(otp1.text ?? "")\(otp2.text ?? "")\(otp3.text ?? "")\(otp4.text ?? "")\(otp5.text ?? "")\(otp6.text ?? "")"
        
        let params = ["data": "{\"customerId\":\"\(customerId)\", \"otp\":\"\(otpString)\"}"]


        
        print("Sending OTP request with data: \(params)") // Print the request data
        
        let dataBody = createDataBody(withParameters: params, boundary: boundary)
        request.httpBody = dataBody
        
        request.httpMethod = "POST"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                if let rawResponseString = String(data: data, encoding: .utf8) {
                    print("Raw API Response: \(rawResponseString)")
                }
                let decoder = JSONDecoder()
                do {
                    let apiResponse = try decoder.decode(OTPResponse.self, from: data)
                    print("Received API Response: \(apiResponse)")  // Print the API response
                    
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        if apiResponse.code == 200 {
                            if let customer = apiResponse.customer {
                                   
                                   // Create a new user instance with the data from the login response
                                let user = User(email: customer.email, lastName: customer.lastName, firstName: customer.firstName, customerId: customer.customerId, mobileNumber: customer.mobileNumber)
                                   
                                   // Save this user to UserManager
                                   UserManager.shared.currentUser = user

                                   // Printing the extracted values
                                   print("First Name: \(customer.firstName)")
                                   print("Last Name: \(customer.lastName)")
                                   print("Email: \(customer.email)")
                                   print("Customer ID: \(customer.customerId)")
                                   print("Customer ID: \(customer.mobileNumber)")
                               }

//                            // Handle successful OTP verification, navigate to the next screen or show success message
//                            
//                            self.loginsuccessfulview.isHidden = false
//                            
//                            // Hide the pop-up after 3 seconds
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                                self.loginsuccessfulview.isHidden = true
//                            }
//                            self.view.makeToast("OTP Verification Successful", duration: 3.0, position: .bottom)
//                            
//                            // Check the userProfileStatus to determine next action
//                            switch apiResponse.userProfileStatus {
//                            case .int(let intValue):
//                                if intValue == 201 {
//                                    // Navigate to Signup View
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
//                                        vc.customerId = self.customerId
//                                        print(self.customerId)
//                                        vc.mobileNumber = self.mobileNumber  // Pass the mobile number to SignupViewController
//
//                                        self.navigationController?.pushViewController(vc, animated: true)
//                                    }
//                                } else {
//                                    // Handle other userProfileStatus cases here...
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                                        vc.customerId = self.customerId
//                                        print(self.customerId)
//                                        self.navigationController?.pushViewController(vc, animated: true)
//                                    }
//                                }
//                            case .string(let stringValue):
//                                if stringValue == "201" {
//                                    // Navigate to Signup View
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
//                                        vc.customerId = self.customerId
//                                        print(self.customerId)
//                                        vc.mobileNumber = self.mobileNumber  // Pass the mobile number to SignupViewController
//
//                                        self.navigationController?.pushViewController(vc, animated: true)
//                                    }
//                                } else {
//                                    // Handle other userProfileStatus cases here...
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
//                                        vc.customerId = self.customerId
//                                        print(self.customerId)
//                                        self.navigationController?.pushViewController(vc, animated: true)
//                                    }
//                                }
//                            }
                            
                            // Check the userProfileStatus to determine next action
                                switch apiResponse.userProfileStatus {
                                case .int(let intValue):
                                    self.handleUserProfileStatus(value: "\(intValue)")
                                case .string(let stringValue):
                                    self.handleUserProfileStatus(value: stringValue)
                                }
                            
                        } else {
                            // Handle failed OTP verification
                            self.SimpleAlert(withTitle: "Error", message: apiResponse.message)
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.SimpleAlert(withTitle: "", message: "Incorrect OTP Entered")
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.SimpleAlert(withTitle: "", message: "Something went wrong")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("Error \(String(describing: error))")
                }
            }
        }
        dataTask.resume()
    }
    
    func handleUserProfileStatus(value: String) {
        if value == "201" {
            // Navigate to Signup View
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
                vc.customerId = self.customerId
                print(self.customerId)
                vc.mobileNumber = self.mobileNumber  // Pass the mobile number to SignupViewController
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.loginsuccessfulview.isHidden = false
            self.view.makeToast("OTP Verification Successful", duration: 3.0, position: .bottom)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.loginsuccessfulview.isHidden = true
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                vc.customerId = self.customerId
                print(self.customerId)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

}
