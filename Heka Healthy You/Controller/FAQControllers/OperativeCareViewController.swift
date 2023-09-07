//
//  OperativeCareViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class OperativeCareViewController: MenuViewController {

    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var operativeCareTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
    
        var lblQuestions = ["What is post-operative care?","What does post-operative care include?","Why is Postoperative Care Important?","What Are the Advantages of Post-Surgery Care at Home?",]
    
        var lblAnswers = ["Postoperative care is the care and treatment provided to a patient following surgery. This frequently includes wound care and pain management following surgery. Naturally, the type of care you will receive is determined by the type of surgery you had, your medical history, and any complications that occurred following the surgery.","\n • Wound care and dressing \n • Using pain relievers to prevent infection, alleviate symptoms, and manage pain \n • Keeping feeding tubes, intravenous (IV) lines, and drains in place \n • Taking blood or other fluid samples \n • Managing a Postoperative Complication","Careless mistakes can be costly when your body is still recovering. In a less severe scenario, pushing yourself too soon after surgery can impede your recovery. At worst, it could reverse your surgical progress or result in a medical emergency. Pay attention to your doctor's postoperative care recommendations if you want to be fully healed as soon as possible and avoid additional invasive procedures.","• The Conveniences of Home \n • Assist with Daily Living Activities (ADLs) \n • Individualised Care Plans \n • Provide Physical and Emotional Support",""]
    
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
        
        operativeCareTableView.delegate = self
        operativeCareTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension OperativeCareViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == operativeCareTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == operativeCareTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OperativeCareTableViewCell") as? OperativeCareTableViewCell else { return UITableViewCell() }
            
            cell.lblQuestion.text = lblQuestions[indexPath.row]
            cell.lblAnswer.text = lblAnswers[indexPath.row]
            
            let isSelected = selectedRows.contains(indexPath.row)
            cell.lblAnswer.isHidden = !isSelected
            cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
            
            if isSelected && (indexPath.row == 0) {
                cell.lblAnswerHeightConstraint.constant = 140
                tableView.rowHeight = 210
            } else if isSelected && indexPath.row == 2 {
                cell.lblAnswerHeightConstraint.constant = 195
                tableView.rowHeight = 250
            } else if isSelected && (indexPath.row == 1 || indexPath.row == lblQuestions.count - 1) {
                cell.lblAnswerHeightConstraint.constant = 180
                tableView.rowHeight = 210
            } else {
                cell.lblAnswerHeightConstraint.constant = 0
                tableView.rowHeight = 70
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
        if tableView == operativeCareTableView {
            if let index = selectedRows.firstIndex(of: indexPath.row) {
                selectedRows.remove(at: index)
            } else {
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
        if tableView == operativeCareTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row == 0 {
                    return 210
                } else if indexPath.row == 2 {
                    return 250
                } else if (indexPath.row == 1 || indexPath.row == lblQuestions.count - 1) {
                    return 230
                } else {
                    return 70
                }
            } else {
                return 70
            }
        } else {
            return 29
        }
    }
}

