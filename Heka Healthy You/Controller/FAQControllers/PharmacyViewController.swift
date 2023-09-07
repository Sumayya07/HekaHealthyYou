//
//  PharmacyViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class PharmacyViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var pharmacyTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
        var lblQuestions = ["Is it safe to buy medicines online?","Why Choose Us?","How do I order medicine on Heka Healthy You?","How long does it take for the medicines to deliver?","Do I get discounts/cashback while ordering medicines on Heka Healthy You?","What is the shelf life of the medicine being provided?"]
    
        var lblAnswers = ["Absolutely! To ensure high quality, all of our medicines go through a three-step quality check process. We only purchase our products from licenced retail pharmacies.","• 5 million+ customers use it \n • Delivery within 24-48 hours* \n • You can choose from over 1L of medications and healthcare products that have been triple-checked for quality \n • We serve 22k+ zip codes in 1.2k+ cities. \n • A highly capable group of pharmacists and healthcare professionals \n • Cash-on-delivery is an option.","\n • Visit our website or use your phone to access our online app. \n • Upload a valid doctor's prescription. \n • Enter the address to which you want your package delivered. \n • Our partner retailer will contact you to confirm the order. \n • The pharmacist packages the medication. \n • Our delivery person will bring the package to your door.","When you order medicines from us online, you will receive them within 24-48* hours. *T&C: Depending on the delivery location, the delivery time may vary.","Yes, you can get substantial discounts and e-wallet cashback when purchasing medications.","We ensure that the medicines supplied by our partner retailers have a minimum shelf life of three months from the date of delivery."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
              viewMenu.isHidden = true
              viewMenu.layer.cornerRadius = 6
              viewMenu.layer.borderWidth = 0.5
              viewMenu.layer.borderColor = UIColor.lightGray.cgColor
              
              viewSearch.layer.cornerRadius = 20
              viewSearch.layer.borderWidth = 1
              viewSearch.layer.borderColor = UIColor.black.cgColor
              
              viewBottomTabBar.layer.borderWidth = 1
              viewBottomTabBar.layer.borderColor = UIColor.black.cgColor

              btnSOS.layer.cornerRadius = 24
              btnSOS.layer.borderWidth = 2
              btnSOS.layer.borderColor = UIColor(named: "Reddish")?.cgColor
        
        pharmacyTableView.delegate = self
        pharmacyTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension PharmacyViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pharmacyTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == pharmacyTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyTableViewCell") as? PharmacyTableViewCell else { return UITableViewCell() }
            
            cell.lblQuestion.text = lblQuestions[indexPath.row]
            cell.lblAnswer.text = lblAnswers[indexPath.row]
            
            let isSelected = selectedRows.contains(indexPath.row)
            cell.lblAnswer.isHidden = !isSelected
            cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
            
            if isSelected && (indexPath.row == lblQuestions.count - 1 || indexPath.row == lblQuestions.count - 2 || indexPath.row == lblQuestions.count - 3 || indexPath.row == lblQuestions.count - 6) {
                cell.lblAnswerHeightConstraint.constant = 80 // Adjust this value as per your requirements
                tableView.rowHeight = 150
            } else if isSelected && (indexPath.row == 1 || indexPath.row == 2) {
                cell.lblAnswerHeightConstraint.constant = 220 // Adjust this value as per your requirements
                tableView.rowHeight = 250
            } else {
                cell.lblAnswerHeightConstraint.constant = isSelected ? 66 : 0
                tableView.rowHeight = isSelected ? 140 : 70
            }
            
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = selectedBackgroundView
            
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == pharmacyTableView {
            if let index = selectedRows.firstIndex(of: indexPath.row) {
                // If the row is already selected and tapped again, remove it from the selected rows
                selectedRows.remove(at: index)
            } else {
                // If the row is not selected, add it to the selected rows
                selectedRows.append(indexPath.row)
            }
            
            tableView.beginUpdates()
            tableView.reloadRows(at: [indexPath], with: .automatic)
            tableView.endUpdates()
        } else {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == pharmacyTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row == lblQuestions.count - 1 || indexPath.row == lblQuestions.count - 2 || indexPath.row == lblQuestions.count - 3 || indexPath.row == lblQuestions.count - 6 {
                    return 150 // Expanded row height for last and second last row
                } else if indexPath.row == 1 || indexPath.row == 2 {
                    return 280 // Expanded row height for first and second row
                }
                return 140 // Expanded row height for other rows
            } else {
                return 75 // Collapsed row height
            }
        } else {
            return 29
        }
    }
}
