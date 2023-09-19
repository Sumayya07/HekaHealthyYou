//
//  EnquireViewController.swift
//  Heka Healthy You
//
//  Created by saeem.
//

import UIKit
import AVFoundation
import BackgroundTasks
import AppTrackingTransparency
import AVKit
import Accelerate

class EnquireViewController: MenuViewController, UITextFieldDelegate {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var btnSubmit: UIButton!
    
    @IBOutlet var preferredtime: UITextField!
    @IBOutlet var preferredate: UITextField!
    @IBOutlet var txtFieldName: UITextField!
    @IBOutlet var txtFieldMobileNumber: UITextField!
    @IBOutlet var txtFieldLooking: UITextField!
    @IBOutlet var txtFieldDate: UITextField!
    @IBOutlet var txtFieldTime: UITextField!
    @IBOutlet var txtFieldReferred: UITextField!
    
    
    @IBOutlet var viewNumber: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var viewBottomTabBar: UIView!
    
    @IBOutlet var viewLooking: UIView!
    @IBOutlet var viewLookingPopup: UIView!
    
    
    @IBOutlet var viewReferred: UIView!
    @IBOutlet var viewReferredPopup: UIView!
    
    @IBOutlet var tableViewLooking: UITableView!
    @IBOutlet var tableViewReferred: UITableView!
    
    
    var lblNames = ["Safety Training", "Elderly Care", "Pregnancy Care", "Operative Care", "Doctor Consultation", "Book Lab Test", "Inhouse Care", "Medical Astrology", "Overseas Service", "General Wellness"]
    
    var lblReferred = ["Doctor", "Friend", "Social Media", "Advertisement", "Others"]
    
    // 1. State ko track karne ke liye 2 arrays
    var selectedLookings: [Int] = [] // Selected index ko yaad rakhne ke liye
    var selectedReferreds: [Int] = []
    let datePicker = UIDatePicker()
    let timePicker = UIDatePicker()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtFieldMobileNumber.delegate = self

        // Date Picker Configuration
             datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
             datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
             txtFieldDate.inputView = datePicker

             // Time Picker Configuration
             timePicker.datePickerMode = .time
        if #available(iOS 13.4, *) {
            timePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
             timePicker.addTarget(self, action: #selector(timeChanged(_:)), for: .valueChanged)
             txtFieldTime.inputView = timePicker

             // Gesture recognizer to dismiss picker
             let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped(gestureRecognizer:)))
             view.addGestureRecognizer(tapGesture)
        
        if let currentUser = UserManager.shared.currentUser {
               self.txtFieldName.text = "\(currentUser.firstName) \(currentUser.lastName)"
               self.txtFieldMobileNumber.text = currentUser.mobileNumber
           } else {
               print("No current user found")
           }
        
        btnSubmit.isEnabled = false
        btnSubmit.backgroundColor = UIColor.gray

        btnSOS.layer.cornerRadius = 24
        btnSOS.layer.borderWidth = 2
        btnSOS.layer.borderColor = UIColor(named: "Reddish")?.cgColor
        
        btnSubmit.layer.cornerRadius = 10
        txtFieldName.layer.cornerRadius = 10
        txtFieldName.layer.borderWidth = 1
        txtFieldName.layer.borderColor = UIColor.black.cgColor
        
        txtFieldLooking.layer.cornerRadius = 10
        txtFieldLooking.layer.borderWidth = 1
        txtFieldLooking.layer.borderColor = UIColor.black.cgColor
        
        txtFieldDate.layer.cornerRadius = 10
        txtFieldDate.layer.borderWidth = 1
        txtFieldDate.layer.borderColor = UIColor.black.cgColor
        
        txtFieldTime.layer.cornerRadius = 10
        txtFieldTime.layer.borderWidth = 1
        txtFieldTime.layer.borderColor = UIColor.black.cgColor
        
        txtFieldReferred.layer.cornerRadius = 10
        txtFieldReferred.layer.borderWidth = 1
        txtFieldReferred.layer.borderColor = UIColor.black.cgColor
        
        viewMenu.isHidden = true
        viewMenu.layer.cornerRadius = 6
        viewMenu.layer.borderWidth = 0.5
        viewMenu.layer.borderColor = UIColor.lightGray.cgColor
        
        viewNumber.layer.cornerRadius = 10
        viewNumber.layer.borderWidth = 1
        viewNumber.layer.borderColor = UIColor.black.cgColor
        
        viewSearch.layer.cornerRadius = 20
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.black.cgColor
        
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor
        
        viewLooking.layer.cornerRadius = 20
        
        [txtFieldName, txtFieldMobileNumber, txtFieldLooking, txtFieldDate, txtFieldTime, txtFieldReferred].forEach {
               $0?.addTarget(self, action: #selector(updateSubmitButtonState), for: .editingChanged)
           }

           updateSubmitButtonState()
        
        txtFieldName.addTarget(self, action: #selector(updateSubmitButtonState), for: .editingChanged)
        // ...do this for all your other text fields as well


    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Check if it's the txtFieldMobileNumber
        if textField == txtFieldMobileNumber {
            // Calculate the new text if this change is allowed
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                
                // Check if the updated text contains only digits and is not longer than 10 characters
                if updatedText.count <= 10 && updatedText.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil {
                    return true
                } else {
                    return false
                }
            }
        }
        
        // For other text fields, allow any changes
        return true
    }
    
    func isNameValid(name: String?) -> Bool {
        guard let name = name, name.count >= 3 else {
            return false
        }
        return true
    }

    @objc func updateSubmitButtonState() {
        let isNameValid = self.isNameValid(name: txtFieldName.text)
        
        let allFieldsFilled = ![txtFieldMobileNumber, txtFieldLooking, txtFieldDate, txtFieldTime, txtFieldReferred].contains { $0?.text?.isEmpty ?? true }
        
        let isFormValid = allFieldsFilled && isNameValid
        
        btnSubmit.isEnabled = isFormValid
        
        if isFormValid {
            btnSubmit.backgroundColor = UIColor(hexString: "#3F6B68")
        } else {
            btnSubmit.backgroundColor = UIColor.gray
        }
    }

    @objc func dateChanged(_ sender: UIDatePicker) {
           let formatter = DateFormatter()
           formatter.dateStyle = .medium
           txtFieldDate.text = formatter.string(from: sender.date)
       }

       @objc func timeChanged(_ sender: UIDatePicker) {
           let formatter = DateFormatter()
           formatter.timeStyle = .short
           txtFieldTime.text = formatter.string(from: sender.date)
       }

       // Action to handle dismissing the picker
       @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
           view.endEditing(true)
       }
    
    
    @IBAction func preferreddateaction(_ sender: Any) {
    }
    
    @IBAction func preferredtimeaction(_ sender: Any) {
    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)

    }
    
    
    @IBAction func btnLookingTapped(_ sender: Any) {
        viewLookingPopup.frame = self.view.bounds
        self.view.addSubview(viewLookingPopup)
        viewLookingPopup.isHidden = false
        tableViewLooking.reloadData() // Ensure ki tableView refresh ho jab bhi dropdown open ho

    }
    
    func adjustFontSizeForTextField(textField: UITextField) {
        let thresholdCount = 3
        let normalFontSize: CGFloat = 14  // Adjust to your default font size
        let reducedFontSize: CGFloat = 8  // Adjust to your desired reduced font size

        let itemCount = textField.text?.components(separatedBy: ",").count ?? 0
        if itemCount > thresholdCount {
            textField.font = UIFont.systemFont(ofSize: reducedFontSize)
        } else {
            textField.font = UIFont.systemFont(ofSize: normalFontSize)
        }
    }

    @IBAction func btnCancelTapped(_ sender: Any) {
        viewLookingPopup.isHidden = true
    }
    
    @IBAction func btnOkTapped(_ sender: Any) {
        viewLookingPopup.isHidden = true

    }
    
    
    @IBAction func btnReferredTapped(_ sender: Any) {
        viewReferredPopup.frame = self.view.bounds
        self.view.addSubview(viewReferredPopup)
        viewReferredPopup.isHidden = false
        tableViewReferred.reloadData() // Ensure ki tableView refresh ho jab bhi dropdown open ho

    }
    
    
    @IBAction func btnCancelReferredTapped(_ sender: Any) {
        viewReferredPopup.isHidden = true

    }
    
    
    @IBAction func btnOkReferredTapped(_ sender: Any) {
        viewReferredPopup.isHidden = true

    }
    @IBAction func btnsubmitaction(_ sender: Any) {
        if validateFields() {
               // Perform your submission logic here
            self.btnSubmit.backgroundColor = UIColor(hexString: "#3F6B68")
           } else {
               let alert = UIAlertController(title: "Error", message: "Please fill in all required fields before submitting.", preferredStyle: .alert)
               alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
               present(alert, animated: true, completion: nil)
           }
    }
    
    func validateFields() -> Bool {
        return !txtFieldName.text!.isEmpty &&
               !txtFieldMobileNumber.text!.isEmpty &&
               !txtFieldLooking.text!.isEmpty &&
               !txtFieldDate.text!.isEmpty &&
               !txtFieldTime.text!.isEmpty &&
               !txtFieldReferred.text!.isEmpty
    }
    
    @objc func textFieldChanged() {
        btnSubmit.isEnabled = validateFields()
    }


    
}

protocol CheckBoxDelegate: AnyObject {
    func checkboxTapped(at indexPath: IndexPath, for tableViewType: TableViewType)
}

enum TableViewType {
    case looking
    case referred
}



extension EnquireViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == tableViewLooking) {
            return lblNames.count

        } else {
            return lblReferred.count

        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tableViewLooking {
            if selectedLookings.contains(indexPath.row) {
                selectedLookings.removeAll { $0 == indexPath.row }
            } else {
                selectedLookings.append(indexPath.row)
            }
            
            // TextField update karna
            txtFieldLooking.text = selectedLookings.map { lblNames[$0] }.joined(separator: ", ")

            
        } else {
            if selectedReferreds.contains(indexPath.row) {
                selectedReferreds.removeAll { $0 == indexPath.row }
            } else {
                selectedReferreds.append(indexPath.row)
            }
            
            // Update the Referred TextField (assuming you have one)
            txtFieldReferred.text = selectedReferreds.map { lblReferred[$0] }.joined(separator: ", ")
        }
        
        tableView.reloadData() // TableView refresh
        textFieldChanged()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tableViewLooking {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "LookingTableViewCell") as? LookingTableViewCell {
               cell.lblLookingNames.text = lblNames[indexPath.row]
               cell.setCheckbox(selected: selectedLookings.contains(indexPath.row))
               cell.delegate = self
               cell.indexPath = indexPath
               
               cell.selectionStyle = .none  // Add this line here
               
               return cell
            } else {
                
                return UITableViewCell()
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReferredTableViewCell") as? ReferredTableViewCell {
                cell.lblReferredNames.text = lblReferred[indexPath.row]
                cell.setCheckbox(selected: selectedReferreds.contains(indexPath.row))
                cell.delegate = self
                cell.indexPath = indexPath
                
                cell.selectionStyle = .none  // And here
                
                return cell
            } else {
                
                return UITableViewCell()
            }
        }
        
    }
}
extension EnquireViewController: CheckBoxDelegate {
    func checkboxTapped(at indexPath: IndexPath, for tableViewType: TableViewType) {
        switch tableViewType {
        case .looking:
            if selectedLookings.contains(indexPath.row) {
                selectedLookings.removeAll { $0 == indexPath.row }
            } else {
                selectedLookings.append(indexPath.row)
            }
            txtFieldLooking.text = selectedLookings.map { lblNames[$0] }.joined(separator: ", ")
            adjustFontSizeForTextField(textField: txtFieldLooking)  // Add this line here


        case .referred:
            if selectedReferreds.contains(indexPath.row) {
                selectedReferreds.removeAll { $0 == indexPath.row }
            } else {
                selectedReferreds.append(indexPath.row)
            }
            txtFieldReferred.text = selectedReferreds.map { lblReferred[$0] }.joined(separator: ", ")
            adjustFontSizeForTextField(textField: txtFieldReferred)  // And here
        }

        tableView.reloadData()
        textFieldChanged()  // If you have this function
        updateSubmitButtonState()

    }

}
