//
//  SignUpViewController.swift
//  Heka Healthy You
//
//  Created by saeem  on 20/06/23.
//

import UIKit
import Reachability
import MBProgressHUD

// CHECK THIS SIGNUP VIEW CONTROLLER API

class SignupViewController: UIViewController {
    
    @IBOutlet var txtFieldFirstName: UITextField!
    @IBOutlet var txtFieldLastName: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!
    @IBOutlet var txtFieldPassword: UITextField!
    
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewMobileNumber: UIView!
    @IBOutlet var viewOne: UIView!
    @IBOutlet var viewTwo: UIView!
    @IBOutlet var viewThree: UIView!
    @IBOutlet var viewFour: UIView!
    @IBOutlet var viewFive: UIView!
    @IBOutlet var viewSix: UIView!
    
    @IBOutlet var viewSigninSuccessful: UIView!
    
    
    @IBOutlet var btnSendOtp: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    
    var userId: String?
    var customerId: String?
    var mobileNumber: String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(customerId)
        navigationController?.isNavigationBarHidden = true
        
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor
        
        btnSubmit.layer.cornerRadius = 8
        btnSubmit.backgroundColor = UIColor.lightGray
        
        txtFieldFirstName.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txtFieldLastName.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        txtFieldEmail.addTarget(self, action: #selector(emailTextFieldDidChange), for: .editingChanged)
        
        viewSigninSuccessful.isHidden = true
        viewSigninSuccessful.layer.cornerRadius = 12

        
    

    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }

    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnExistingUserTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        print("Submit button pressed") // This should print as soon as the button is tapped

            guard let firstName = txtFieldFirstName.text, !firstName.isEmpty else {
                showAlert(title: "Input Error", message: "Please enter a first name")
                return
            }
            
            guard let lastName = txtFieldLastName.text, !lastName.isEmpty else {
                showAlert(title: "Input Error", message: "Please enter a last name")
                return
            }
            
            guard let email = txtFieldEmail.text, !email.isEmpty else {
                showAlert(title: "Input Error", message: "Please enter an email")
                return
            }
            
            if !isValidEmail(email) {
                showAlert(title: "Invalid Email", message: "Please enter a valid email")
                return
            }

            userRegistrationAPI()
        
        }

        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
          guard let email = txtFieldEmail.text, isValidEmail(email) else {
              btnSubmit.backgroundColor = UIColor.lightGray
              return
          }
          
        btnSubmit.backgroundColor = UIColor(named: "Turquoise")
      }

    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let firstName = txtFieldFirstName.text, !firstName.isEmpty,
              let lastName = txtFieldLastName.text, !lastName.isEmpty,
              let email = txtFieldEmail.text, email.count >= 3, isValidEmail(email) else {
            btnSubmit.backgroundColor = UIColor.lightGray
            return
        }
        
        btnSubmit.backgroundColor = UIColor(named: "Turquoise")
    }
}


extension SignupViewController {
    
    func userRegistrationAPI() {
        
        guard let firstName = txtFieldFirstName.text,
              let lastName = txtFieldLastName.text,
              let email = txtFieldEmail.text else {
            SimpleAlert(withTitle: "Error", message: "Missing data")
            return
        }
        
        guard let reachability = try? Reachability(), reachability.connection != .unavailable else {
            SimpleAlert(withTitle: "", message: "Please Check your Internet")
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let url = URL(string: APIManager.shared.registrationURL)!
        var request = URLRequest(url: url)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var registrationData: [String: String] = [
            
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        
        if let customerId = self.customerId {
            registrationData["customerId"] = customerId
        }
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: registrationData, options: []) {
            let jsonString = String(data: jsonData, encoding: .utf8) ?? ""
            let params = ["data": jsonString]
            print("Sending User Registration request with data: \(params)")
            
            // Save user data to the singleton once registration is confirmed successful
            let user = User(email: email, lastName: lastName, firstName: firstName, customerId: self.customerId ?? "", mobileNumber: self.mobileNumber ?? "")
            UserManager.shared.currentUser = user
            
            let dataBody = createDataBody(withParameters: params, boundary: boundary)
            request.httpBody = dataBody
            
            request.httpMethod = "POST"
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if let data = data {
                    print("Raw API Response: \(String(data: data, encoding: .utf8) ?? "N/A")")
                    
                    let decoder = JSONDecoder()
                    do {
                        let apiResponse = try decoder.decode(UserRegistrationResponse.self, from: data)
                        
                        print("Received API Response: \(apiResponse)")
                        DispatchQueue.main.async {
                            MBProgressHUD.hide(for: self.view, animated: true)
                            
                            if apiResponse.code == 200 {
                                MBProgressHUD.hide(for: self.view, animated: true)

                                // Assuming viewSigninSuccessful is a UIView in your SignupViewController
                                self.viewSigninSuccessful.isHidden = false
                                self.view.makeToast("User Registered Successfully", duration: 3.0, position: .bottom)

                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    self.viewSigninSuccessful.isHidden = true

                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                                    vc.customerId = self.customerId
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                    } catch {
                        // If that fails, handle it as an unknown error or a non-JSON response
                               DispatchQueue.main.async {
                                   MBProgressHUD.hide(for: self.view, animated: true)
                                   self.SimpleAlert(withTitle: "Error", message: "Something went wrong")
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
        } else {
            SimpleAlert(withTitle: "Error", message: "Couldn't create the request payload")
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    // Rest of your code including `createDataBody` function remains the same
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



