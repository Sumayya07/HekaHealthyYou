//
//  BLSTrainingViewController.swift
//  Heka Healthy You
//
//  Created by saeem.
//

import UIKit

class BLSTrainingViewController: MenuViewController, UITextFieldDelegate {

    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var btnSchedule: UIButton!
    @IBOutlet var viewSearch: UIView!
    
    @IBOutlet var viewBottomTabBar: UIView!
    
    //viewScheduleCallPopup outlets
    @IBOutlet var btnCross: UIButton!
    @IBOutlet var btnRequest: UIButton!

    @IBOutlet var txtFieldName: UITextField!
    @IBOutlet var txtFieldEmail: UITextField!
    @IBOutlet var txtFieldMobileNumber: UITextField!
    @IBOutlet var namepopup: UITextField!
    @IBOutlet var emailpopup: UITextField!
    @IBOutlet var mobilepopup: UITextField!
    @IBOutlet var callbackpopup: UIButton!
    
    @IBOutlet var viewScheduleCall: UIView!
    @IBOutlet var viewScheduleCallPopup: UIView!
    
    @IBOutlet var starone: UIButton!
    
    @IBOutlet var startwo: UIButton!
    
    @IBOutlet var startthree: UIButton!
    
    @IBOutlet var startfour: UIButton!
    
    @IBOutlet var startfive: UIButton!
    var starButtons: [UIButton] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        starButtons = [starone, startwo, startthree, startfour, startfive]
        starone.tintColor = UIColor(hexString: "#3F6B68")
        startwo.tintColor = UIColor(hexString: "#3F6B68")
        startthree.tintColor = UIColor(hexString: "#3F6B68")
        startfour.tintColor = UIColor(hexString: "#3F6B68")
        startfive.tintColor = UIColor(hexString: "#3F6B68")
        
        txtFieldMobileNumber.delegate = self
        btnSOS.layer.cornerRadius = 24
        btnSOS.layer.borderWidth = 2
        btnSOS.layer.borderColor = UIColor(named: "Reddish")?.cgColor
        btnSchedule.layer.cornerRadius = 8

        viewMenu.isHidden = true
        viewMenu.layer.cornerRadius = 6
        viewMenu.layer.borderWidth = 0.5
        viewMenu.layer.borderColor = UIColor.lightGray.cgColor
        
        viewSearch.layer.cornerRadius = 20
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.black.cgColor
        
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor
        
        // viewScheduleCallPopup elements
        viewScheduleCall.layer.cornerRadius = 10

        btnCross.layer.cornerRadius = btnCross.frame.size.height/2
        
        btnRequest.layer.cornerRadius = 10
      
        txtFieldName.layer.cornerRadius = 10
        txtFieldName.layer.borderWidth = 1
        txtFieldName.layer.borderColor = UIColor.black.cgColor
        
        txtFieldEmail.layer.cornerRadius = 10
        txtFieldEmail.layer.borderWidth = 1
        txtFieldEmail.layer.borderColor = UIColor.black.cgColor
        
        txtFieldMobileNumber.layer.cornerRadius = 10
        txtFieldMobileNumber.layer.borderWidth = 1
        txtFieldMobileNumber.layer.borderColor = UIColor.black.cgColor
        namepopup.addTarget(self, action: #selector(validateFields), for: .editingChanged)
           emailpopup.addTarget(self, action: #selector(validateFields), for: .editingChanged)
           mobilepopup.addTarget(self, action: #selector(validateFields), for: .editingChanged)
        
        if let currentUser = UserManager.shared.currentUser {
                self.txtFieldName.text = "\(currentUser.firstName) \(currentUser.lastName)"
                self.txtFieldMobileNumber.text = currentUser.mobileNumber
                self.txtFieldEmail.text = currentUser.email

                // After prefilling the fields, check if the submit button should be enabled
                checkAndEnableSubmitButton()
            } else {
                print("No current user found")
            }
        
    }
    
    func checkAndEnableSubmitButton() {
        if isAllDataPrefilled() {
            callbackpopup.backgroundColor = UIColor(hexString: "#3F6B68")
        } else {
            callbackpopup.backgroundColor = .lightGray  // This could be whatever default color you like
        }
    }

    func isAllDataPrefilled() -> Bool {
        // Check if all data fields are not empty
        guard let name = txtFieldName.text, !name.isEmpty,
              let email = txtFieldEmail.text, isValidEmail(email),
              let mobile = txtFieldMobileNumber.text, mobile.count >= 10 else {
            return false
        }
        
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFieldMobileNumber {
                    // Limit phone number to 10 digits
                    let currentText = textField.text ?? ""
                    let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
                    return newText.count <= 10
                }
        return true
    }
    
    @objc func validateFields() {
        if isAllDataValid() {
            callbackpopup.backgroundColor = UIColor(hexString: "#3F6B68")
        } else {
            callbackpopup.backgroundColor = .lightGray  // This could be whatever default color you like
        }
    }

    func isAllDataValid() -> Bool {
        // Name validation: At least 5 characters
        guard let name = namepopup.text, name.count >= 3 else { return false }

        // Email validation: Basic check for '@' and '.'
        guard let email = emailpopup.text, isValidEmail(email) else { return false }

        // Mobile validation: At least 10 characters
        guard let mobile = mobilepopup.text, mobile.count >= 10 else { return false }
        
        return true
    }

    // Basic email validation function
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: email)
    }
    @IBAction func btnScheduleTapped(_ sender: Any) {
        viewScheduleCallPopup.frame = self.view.bounds
        self.view.addSubview(viewScheduleCallPopup)
        viewScheduleCallPopup.isHidden = false
    }
    
    
    @IBAction func btnCrossTapped(_ sender: Any) {
        viewScheduleCallPopup.isHidden = true

    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    
    
    
    @IBAction func star1(_ sender: Any) {
        updateStars(rating: 1)
    }
    
    
    @IBAction func star2(_ sender: Any) {
        updateStars(rating: 2)
    }
    
    @IBAction func star3(_ sender: Any) {
        updateStars(rating: 3)
    }
    
    @IBAction func star4(_ sender: Any) {
        updateStars(rating: 4)
    }
    
    @IBAction func star5(_ sender: Any) {
        updateStars(rating: 5)
    }
    
    func updateStars(rating: Int) {
          for (index, button) in starButtons.enumerated() {
              let imageName = (index < rating) ? "star.fill" : "star"
              let image = UIImage(systemName: imageName)
              button.setImage(image, for: .normal)
          }
      }
      
    
    
}
