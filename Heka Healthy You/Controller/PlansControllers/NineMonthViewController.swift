//
//  NineMonthViewController.swift
//  Heka Healthy You
//
//  Created by saeem.
//

import UIKit

class NineMonthViewController: MenuViewController, UITextFieldDelegate {
    
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
    
    
    @IBOutlet var viewScheduleCall: UIView!
    @IBOutlet var viewScheduleCallPopup: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func btnScheduleTapped(_ sender: Any) {
        viewScheduleCallPopup.frame = self.view.bounds
        self.view.addSubview(viewScheduleCallPopup)
        viewScheduleCallPopup.isHidden = false
    }
    
    
    @IBAction func btnCrossTapped(_ sender: Any) {
        viewScheduleCallPopup.isHidden = true

    }
}
