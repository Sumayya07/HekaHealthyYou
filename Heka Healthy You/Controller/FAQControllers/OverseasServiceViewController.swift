//
//  OverseasServiceViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class OverseasServiceViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var overseasServiceTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
        var lblQuestions = ["","","","","",""]
    
        var lblAnswers = ["","","","","",""]
    
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
        
        overseasServiceTableView.delegate = self
        overseasServiceTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension OverseasServiceViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == overseasServiceTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == overseasServiceTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OverseasServiceTableViewCell") as? OverseasServiceTableViewCell else { return UITableViewCell() }
            
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
        if tableView == overseasServiceTableView {
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
        if tableView == overseasServiceTableView {
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


