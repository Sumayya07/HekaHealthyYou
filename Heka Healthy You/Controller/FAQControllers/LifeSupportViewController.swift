//
//  LifeSupportViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 07/07/23.
//

import UIKit

class LifeSupportViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var lifeSupportTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
    

    
    var lblQuestions = ["Why this training is important for me ?","I am not a medical person why I will take training?","This certificate is for life time ?","How long does it take to learn Safety Training ( Basic Life Support)?","What do you expect in a training session?","What is an AED?"]
    
    var lblAnswers = ["This training helps participants with knowledge and skill to tackle basic life support techniques to save lives.","This training can be taken by anyone, irrespective of  being a doctor or paramedic.","The certificate is valid for a period of 2 years from the date of training.","This training can be completed in approximately 3 hours, including hands - on skills .","This course includes - single and team based CPR training, AED  operatives for adults, children and infants.Relief in choking and drowning Victims along with First - Aid for Burn, Fracture, Poisoning etc.","Automated External Defibrillator (AED) is used on those experiencing sudden cardiac arrest, as it analyses heart's rhythm and delivers shock to re- establish normal heart rhythm."]
    
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
        
        lifeSupportTableView.delegate = self
        lifeSupportTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension LifeSupportViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Here, differentiate between the lifeSupportTableView and the inherited tableView
        if tableView == lifeSupportTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Here, differentiate between the lifeSupportTableView and the inherited tableView
        if tableView == lifeSupportTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LifeSupportTableViewCell") as? LifeSupportTableViewCell else { return UITableViewCell() }
            
            cell.lblQuestion.text = lblQuestions[indexPath.row]
            cell.lblAnswer.text = lblAnswers[indexPath.row]

            let isSelected = selectedRows.contains(indexPath.row)
            cell.lblAnswer.isHidden = !isSelected
            cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
            
            if isSelected && (indexPath.row == lblQuestions.count - 1 || indexPath.row == lblQuestions.count - 2) {
                  cell.lblAnswerHeightConstraint.constant = 95 // Adjust this value as per your requirements
                  tableView.rowHeight = 120
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
        if tableView == lifeSupportTableView {
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
        if tableView == lifeSupportTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row == lblQuestions.count - 1 || indexPath.row == lblQuestions.count - 2 {
                    // if it's the last or second last row, return a larger height
                    return 160 // Expanded row height for last and second last row
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




// THIS CODE IS VALID JAB AAPKO AUTOMATICALLY EK ROW KO BAND KRNA H AGR DOOSRI OEN KRO.
//extension LifeSupportViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return lblQuestions.count
//
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LifeSupportTableViewCell") as? LifeSupportTableViewCell else { return UITableViewCell() }
//
//        cell.lblQuestion.text = lblQuestions[indexPath.row]
//        cell.lblAnswer.text = lblAnswers[indexPath.row]
//
//        let isSelected = (selectedRowIndex == indexPath.row)
//        cell.lblAnswer.isHidden = !isSelected
//        cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
//
//        if isSelected {
//            cell.lblAnswerHeightConstraint.constant = 66
//            tableView.rowHeight = 140
//        } else {
//            cell.lblAnswerHeightConstraint.constant = 0
//            tableView.rowHeight = 70
//        }
//
//        let selectedBackgroundView = UIView()
//        selectedBackgroundView.backgroundColor = .clear
//        cell.selectedBackgroundView = selectedBackgroundView
//
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if selectedRowIndex == indexPath.row {
//            // Collapse the selected row
//            selectedRowIndex = nil
//        } else {
//            // Expand the selected row
//            selectedRowIndex = indexPath.row
//        }
//
//        tableView.beginUpdates()
//        if let previousIndex = previouslySelectedRowIndex {
//            tableView.reloadRows(at: [IndexPath(row: previousIndex, section: 0)], with: .automatic)
//        }
//        tableView.reloadRows(at: [indexPath], with: .automatic)
//        tableView.endUpdates()
//
//        previouslySelectedRowIndex = selectedRowIndex
//
//        if let selectedRowIndex = selectedRowIndex {
//            tableView.scrollToRow(at: IndexPath(row: selectedRowIndex, section: 0), at: .none, animated: true)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if selectedRowIndex == indexPath.row {
//            return 140 // Expanded row height
//        } else {
//            return 70 // Collapsed row height
//
//        }
//    }
//}
