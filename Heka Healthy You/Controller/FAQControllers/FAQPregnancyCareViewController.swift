//
//  PregnancyCareViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class FAQPregnancyCareViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var pregnancyCareTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
    
    var lblQuestions = ["What is prenatal diet?","What are the benefits of taking prenatal diet from Heka?","How prenatal yoga is different from regular yoga?","How will my pregnancy plan be customized?","Will I get a refund if I stop my caregiver services?","What will I be experiencing into Garbh Sanskar program?"]
    
    var lblAnswers = ["Prenatal diet addresses nutritional recommendations for the development of a baby and the mother. To maintain a healthy pregnancy,a balanced diet containing all vital nutrients such as proteins, fruits, vegetables, and whole grains, etc are included to address the changed needs of the body.","At Heka, we customize diet plans trimester-wise based on the requirement of the pregnant women. Before designing any plan, we keep in mind any food allergies that a mother might have and ensures that our plans covers all the diet-related issues and management throughout the pregnancy.","Prenatal yoga are specially designed classes with tailored poses depending on the bodily needs and current health status of an expectant mother. The yoga poses are designed, keeping in mind the ease, comfort, and stamina of the expecting mother.","The Program will be customized in conjuction with doctors and nutritionist. ","In that situation, we will refund the due amount within 2-4 working days","Garbh sanskar is a spiritual program, that ensures you and your baby, are healthy.\n • Ragas and shlokas\n• Womb talking (Garbhsamwad)\n• Garbh Uttejan, Garbh Chintan, Garbh Sangeet, Garbh Prarthana & Garbh vidhis\n• Yogopathy and swaatvik Ahar diet plan\n• Aromatherapy and Meditation\n• Yoga kriyas, Asans and pyrayanams"]
    


    
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
        
        pregnancyCareTableView.delegate = self
        pregnancyCareTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension FAQPregnancyCareViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == pregnancyCareTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if tableView == pregnancyCareTableView {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "PregnancyCareTableViewCell") as? PregnancyCareTableViewCell else { return UITableViewCell() }
             
             cell.lblQuestion.text = lblQuestions[indexPath.row]
             cell.lblAnswer.text = lblAnswers[indexPath.row]

             let isSelected = selectedRows.contains(indexPath.row)
             cell.lblAnswer.isHidden = !isSelected
             cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
             
             if isSelected && (indexPath.row <= 2) {
                        cell.lblAnswerHeightConstraint.constant = 140 // Height for first, second, and third row
                        tableView.rowHeight = 210
                    } else if isSelected && indexPath.row == lblQuestions.count - 1 {
                        cell.lblAnswerHeightConstraint.constant = 180 // Height for the last row when selected
                        tableView.rowHeight = 260
             } else {
                 cell.lblAnswerHeightConstraint.constant = isSelected ? 44 : 0 // Height for other rows
                 tableView.rowHeight = isSelected ? 140 : 115
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
        if tableView == pregnancyCareTableView {
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
        if tableView == pregnancyCareTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row <= 2 {
                    return 210 // Expanded row height for first, second, and third row
                } else if indexPath.row == lblQuestions.count - 1 {
                    return 260 // Height for the last row
                } else {
                    return 115 // Expanded row height for other rows
                }
            } else {
                return 70 // Collapsed row height
            }
        } else {
            return 29
        }
    }
    
}

