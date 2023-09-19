//
//  DoctorConsultationViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 11/07/23.
//

import UIKit

class DoctorConsultationViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var doctorConsultationTableView: UITableView!
    
    var previouslySelectedRowIndex: Int? = nil
    var selectedRowIndex: Int? = nil
    var selectedRows = [Int]() // Array to store all selected row indices
    
        var lblQuestions = ["What is online doctor consultation?","Who are the consulting doctors?","Will the doctor be able to help me with my problem?","Is my consultation private with my doctor?","For how long is the consultation valid?","What happens if I don’t get a response from a doctor?"]
    
        var lblAnswers = ["Online doctor consultation, also known as online medical consultation, is a method of virtually connecting patients and doctors. It is a simple and convenient way to obtain online doctor advice using doctor apps, telemedicine apps, or platforms, and the internet.","All of the doctors are licensed medical practitioners. Along with qualifying degrees, experience, research, and a track record of practise are all considered before a doctor is credentialed with Heka Healthy you and given access to answer patient questions.","Our doctors will provide expert advice on your problem and assist you in determining the next steps, which may include additional tests, medication recommendations, or lifestyle changes. Few cases necessitate a face-to-face examination, and we do ask patients to share pictures or reports if possible in order to make an accurate diagnosis.","Data privacy is a fundamental human right, and we at Heka Healthy You recognise it. Your medical history, as well as your online consultation with us, are completely private and confidential. We adhere to industry standards to ensure the security of your consultations.","In the case of a paid consultation, you may consult with your doctor for up to three days. If you choose a free consultation, follow-up questions are only valid for one day.","If an online doctor does not respond, you will be entitled to a full refund."]

    
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
        
        doctorConsultationTableView.delegate = self
        doctorConsultationTableView.dataSource = self

        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}

extension DoctorConsultationViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == doctorConsultationTableView {
            return lblQuestions.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == doctorConsultationTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorConsultationTableViewCell") as? DoctorConsultationTableViewCell else { return UITableViewCell() }
            
            cell.lblQuestion.text = lblQuestions[indexPath.row]
            cell.lblAnswer.text = lblAnswers[indexPath.row]

            let isSelected = selectedRows.contains(indexPath.row)
            cell.lblAnswer.isHidden = !isSelected
            cell.lblAnswer.alpha = isSelected ? 1.0 : 0.0
            
            if isSelected && (indexPath.row >= 0 && indexPath.row <= 3) {
                cell.lblAnswerHeightConstraint.constant = 160
                tableView.rowHeight = 230
            } else if isSelected {
                cell.lblAnswerHeightConstraint.constant = 80
                tableView.rowHeight = 190
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
        if tableView == doctorConsultationTableView {
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
        if tableView == doctorConsultationTableView {
            if selectedRows.contains(indexPath.row) {
                if indexPath.row >= 0 && indexPath.row <= 3 {
                    return 230
                } else {
                    return 150
                }
            } else {
                return 70
            }
        } else {
            return 29
        }
    }
}


