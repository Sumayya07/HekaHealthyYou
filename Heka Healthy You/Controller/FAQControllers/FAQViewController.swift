//
//  FAQViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 06/07/23.
//

import UIKit

class FAQViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewTable: UIView!
    
    @IBOutlet var faqTableView: UITableView!
    
    var lblName = ["Life Support & Safety", "Elderly Care","Pregnancy Care","Operative Care","Doctor Consultation","Lab Test","Pharmacy","Medical Astrology","Overseas Service", "General Wellness"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSOS.layer.cornerRadius = 24
        btnSOS.layer.borderWidth = 2
        btnSOS.layer.borderColor = UIColor(named: "Reddish")?.cgColor
   
        viewMenu.isHidden = true
        viewMenu.layer.cornerRadius = 6
        viewMenu.layer.borderWidth = 0.5
        viewMenu.layer.borderColor = UIColor.lightGray.cgColor
        
        viewSearch.layer.cornerRadius = 20
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.black.cgColor
        
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor
        
        viewTable.layer.cornerRadius = 8
        viewTable.layer.shadowColor = UIColor.gray.cgColor
        viewTable.layer.shadowOffset = CGSize(width: 0, height: 1)
        viewTable.layer.shadowOpacity = 1
        viewTable.layer.shadowRadius = 3
        
        faqTableView.delegate = self
        faqTableView.dataSource = self
        
    }
    
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

}


extension FAQViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Here, differentiate between the faqTableView and the inherited tableView
        if tableView == faqTableView {
            return lblName.count
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Here, differentiate between the faqTableView and the inherited tableView
        if tableView == faqTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FAQTableViewCell") as? FAQTableViewCell else { return UITableViewCell() }
            let item = lblName[indexPath.row]
            cell.lblNames.text = item
            
            let selectedBackgroundView = UIView()
            selectedBackgroundView.backgroundColor = .clear
            cell.selectedBackgroundView = selectedBackgroundView
            
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == faqTableView {
            let selectedLabel = lblName[indexPath.row]
    
            if selectedLabel == "Life Support & Safety" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LifeSupportViewController") as? LifeSupportViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Elderly Care" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ElderlyCareViewController") as? FAQElderlyCareViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Pregnancy Care" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FAQPregnancyCareViewController") as? FAQPregnancyCareViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Operative Care" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OperativeCareViewController") as? OperativeCareViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Doctor Consultation" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "DoctorConsultationViewController") as? DoctorConsultationViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }  else if selectedLabel == "Lab Test" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LabTestViewController") as? LabTestViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Pharmacy" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PharmacyViewController") as? PharmacyViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Medical Astrology" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "MedicalAstrologyViewController") as? MedicalAstrologyViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Overseas Service" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "OverseasServiceViewController") as? OverseasServiceViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "General Wellness" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "GeneralWellnessViewController") as? GeneralWellnessViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else {
            super.tableView(tableView, didSelectRowAt: indexPath)
        }
    }
}
