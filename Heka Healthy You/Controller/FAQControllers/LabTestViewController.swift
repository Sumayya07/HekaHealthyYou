//
//  LabTestViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class LabTestViewController: MenuViewController {

    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var labTestTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
        var lblQuestions = ["What covid precautions does Heka Healthy You take for testing?","Are the phlebotomists adequately trained?","Why are lab tests necessary?","How should a person prepare for a lab test?","How long does it take to receive the report?","How effective is the sampling and analysis procedure?", "How are lab test results interpreted?", "Is it correct to assume that if lab test results are within the normal range, no illness has been detected?"]
    
        var lblAnswers = ["Heka Healthy You is concerned about the safety of our patients and employees. As a result, since the inception of COVID-19, we have developed a 5-step safety program to provide complete protection to all stakeholders. NABL guidelines are also followed to ensure that samples do not become contaminated during collection, transportation, or storage. Here are the safety precautions to which we adhere: Be cautious when using face masks. Hand hygiene, including hand sanitization and glove use.","Heka Healthy You have a dedicated training team for technicians, and they are constantly monitored for parameters such as on-time arrival, painless collection, adherence to NABL guidelines for sample storage and transport, and customer support. We have a very strict hiring process in place to ensure that every sample collection experience is top-of-the-line.","Doctors recommend lab tests or diagnostic tests when they suspect something is wrong with your health. When blood, stool, urine, or mucus samples are analyzed, they can reveal a lot about your health. Once the problem has been identified, your doctor can make a diagnosis and either prescribe medication or suggest a course of treatment.","The requirements for various tests vary. Some tests may require you to be on an empty stomach, whereas others may require you to consume food before the sample is collected. Consult your doctor about what you should do to prepare for a lab test. Inform your doctor if you are currently taking any medications.","It takes the lab 24-48 hours to prepare your report and deliver it to you.","Samples are collected with extreme caution while maintaining complete hygiene. Only completely fresh needles and collection kits are used. The sample is immediately placed in an icebox after collection to prevent degradation and bacterial buildup, which could lead to an incorrect diagnosis. The samples are barcode tagged to prevent cross-contamination, and technicians in the laboratories analyze the samples using high-end, cutting-edge technology.", "Our labs will provide you with detailed reports. There will be charts of reference ranges and a statement from a qualified doctor to help you understand the report. However, once you receive your report, you should consult with your doctor and ask him or her to explain it to you.", "It is certainly good news if your reports are within the normal range. Normal results, however, do not always provide a clean bill of health. If your symptoms persist, your doctor will recommend additional tests to determine what is causing the unusual symptoms."]
    
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
        
        labTestTableView.delegate = self
        labTestTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension LabTestViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == labTestTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == labTestTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LabTestTableViewCell") as? LabTestTableViewCell else { return UITableViewCell() }
            
            cell.lblQuestion.text = lblQuestions[indexPath.row]
            cell.lblAnswer.text = lblAnswers[indexPath.row]

            let isSelected = selectedRows.contains(indexPath.row)
            cell.lblAnswer.isHidden = !isSelected
            cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
            
            if indexPath.row == lblQuestions.count - 1 {
                        cell.lblQuestionHeightConstraint.constant = 80 // Updated lblQuestion height for the last row
                tableView.rowHeight = 90

            } else {
                        cell.lblQuestionHeightConstraint.constant = 44 // Default lblQuestion height for other rows
                    }
            
            if isSelected && (indexPath.row == lblQuestions.count - 1 || indexPath.row == lblQuestions.count - 2) {
                  cell.lblAnswerHeightConstraint.constant = 130
                  tableView.rowHeight = 210
            } else if isSelected && (indexPath.row == 0 || indexPath.row == 5) {
                  cell.lblAnswerHeightConstraint.constant = 230
                  tableView.rowHeight = 300
            } else if isSelected && indexPath.row == 4 {
                  cell.lblAnswerHeightConstraint.constant = 80
                  tableView.rowHeight = 140
            } else {
                  cell.lblAnswerHeightConstraint.constant = isSelected ? 160 : 0
                  tableView.rowHeight = isSelected ? 220 : 70
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
        if tableView == labTestTableView {
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
        if tableView == labTestTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row == lblQuestions.count - 1 || indexPath.row == lblQuestions.count - 2 {
                    return 210
                } else if indexPath.row == 0 || indexPath.row == 5 {
                    return 300
                } else if indexPath.row == 4 {
                    return 140
                } else {
                    return 230
                }
            } else {
                return 70
            }
        } else {
            return 29
        }
    }
}

