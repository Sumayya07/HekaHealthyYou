//
//  ElderlyCareViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class FAQElderlyCareViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var elderlyCareTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
    
    var lblQuestions = ["Do your caregivers undergo background verification?","How do you maintain the quality of your caregiver services?","Who can use Homecare services?","Can my caregiver be replaced?","Will I get a refund if I stop my caregiver services?","Are your caregivers available for 24 hours care?"]
    
    var lblAnswers = ["All our caregivers undergo diligent background verifications. We ensure the reliability of our caregivers through Aadhar based criminal, police, civil, and employment verifications.","Heka follows well-defined clinical protocols at par with hospital standards. Our experienced and certified caregivers are regularly trained to provide quality care while following standardized infection prevention and control policies","Most people who use our Homecare services are Senior citizens who need help with daily activities. Patients who need constant attention or vitals monitoring. People who need medication reminder or assistance in feeding, using the toilet, etc","Heka values your comfort and wellbeing. So Yes ,we can replace your caregiver and employee a new one with in 24 to 48 hours","In that situation, we will refund the due amount within 2-4 working days","Our caregivers are available for 12 or 24-hour services. You can select the number of days and the time duration for which you need the services."]
    
//    var lblAnswers = ["","","","","",""]
    
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
        
        elderlyCareTableView.delegate = self
        elderlyCareTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension FAQElderlyCareViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == elderlyCareTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == elderlyCareTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ElderlyCareTableViewCell") as? ElderlyCareTableViewCell else { return UITableViewCell() }
            
            cell.lblQuestion.text = lblQuestions[indexPath.row]
            cell.lblAnswer.text = lblAnswers[indexPath.row]

            let isSelected = selectedRows.contains(indexPath.row)
            cell.lblAnswer.isHidden = !isSelected
            cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
            
            if isSelected && (indexPath.row <= 2) {
                  cell.lblAnswerHeightConstraint.constant = 100 // Adjust this value as per your requirements
                  tableView.rowHeight = 130
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
        if tableView == elderlyCareTableView {
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
        if tableView == elderlyCareTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row <= 2 {
                    // if it's the last or second last row, return a larger height
                    return 170 // Expanded row height for last and second last row
                }
                return 140 // Expanded row height for other rows
            } else {
                return 70 // Collapsed row height
            }
        } else {
            return 29
        }
    }
    
    
}
