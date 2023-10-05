//
//  DoctorConsultViewController.swift
//  Heka Healthy You
//
//  Created by Sumayya Siddiqui on 19/09/23.
//

import UIKit

class DoctorConsultViewController: MenuViewController {
    
    @IBOutlet var btnEnquire: UIButton!
    @IBOutlet var btnIntroduction: UIButton!
    @IBOutlet var btnChoose: UIButton!
    @IBOutlet var btnService: UIButton!
    @IBOutlet var btnSOS: UIButton!
    
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var viewBottomTabBar: UIView!
    
    @IBOutlet var IntroOpeningClosingConstraint: NSLayoutConstraint!
    @IBOutlet var ChooseOpeningClosingConstraint: NSLayoutConstraint!
    @IBOutlet var ServiceOpeningClosingConstraint: NSLayoutConstraint!
    
    
    @IBOutlet var viewIntroOne: NSLayoutConstraint!
    @IBOutlet var viewIntroTwo: NSLayoutConstraint!
    @IBOutlet var viewIntroThree: NSLayoutConstraint!
    @IBOutlet var viewIntroFour: NSLayoutConstraint!
    
    @IBOutlet var imgIntroOne: NSLayoutConstraint!
    @IBOutlet var imgIntroTwo: NSLayoutConstraint!
    @IBOutlet var imgIntroThree: NSLayoutConstraint!
    @IBOutlet var imgIntroFour: NSLayoutConstraint!
    
    
    @IBOutlet var lblIntroOne: NSLayoutConstraint!
    @IBOutlet var lblIntroTwo: NSLayoutConstraint!
    @IBOutlet var lblIntroThree: NSLayoutConstraint!
    @IBOutlet var lblIntroFour: NSLayoutConstraint!
    
    
    @IBOutlet var viewChooseOne: NSLayoutConstraint!
    @IBOutlet var viewChooseTwo: NSLayoutConstraint!
    @IBOutlet var viewChooseThree: NSLayoutConstraint!
//    @IBOutlet var viewChooseFour: NSLayoutConstraint!
    
    
    
    @IBOutlet var imgChooseOne: NSLayoutConstraint!
    @IBOutlet var imgChooseTwo: NSLayoutConstraint!
    @IBOutlet var imgChooseThree: NSLayoutConstraint!
//    @IBOutlet var imgChooseFour: NSLayoutConstraint!
    
    
    @IBOutlet var lblChooseOne: NSLayoutConstraint!
    @IBOutlet var lblChooseTwo: NSLayoutConstraint!
    @IBOutlet var lblChooseThree: NSLayoutConstraint!
//    @IBOutlet var lblChooseFour: NSLayoutConstraint!
    
    
    @IBOutlet var safetyCollectionView: UICollectionView!
    @IBOutlet var serviceCollectionView: UICollectionView!
    
 
    @IBOutlet var scrollView: UIScrollView!
    
    
    var safetyImages: [String] = ["HowItWorks"]
    var serviceImages: [String] = ["OnlineConsultation", "Covid-19Care", "EmployeeManagement", "AnnualHealthCheckup"]
    var serviceNames: [String] = ["Online Consultation", "Covid-19 Care", "Employee Management", "Annual Health Checkup"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        adjustScrollViewHeight()
        
        IntroOpeningClosingConstraint.constant = 0
        ChooseOpeningClosingConstraint.constant = 0
        ServiceOpeningClosingConstraint.constant = 0
        
        viewIntroOne.constant = 0
        viewIntroTwo.constant = 0
        viewIntroThree.constant = 0
        viewIntroFour.constant = 0
        
        imgIntroOne.constant = 0
        imgIntroTwo.constant = 0
        imgIntroThree.constant = 0
        imgIntroFour.constant = 0
        
        lblIntroOne.constant = 0
        lblIntroTwo.constant = 0
        lblIntroThree.constant = 0
        lblIntroFour.constant = 0
        
        viewChooseOne.constant = 0
        viewChooseTwo.constant = 0
        viewChooseThree.constant = 0
//        viewChooseFour.constant = 0
        
        imgChooseOne.constant = 0
        imgChooseTwo.constant = 0
        imgChooseThree.constant = 0
//        imgChooseFour.constant = 0
        
        lblChooseOne.constant = 0
        lblChooseTwo.constant = 0
        lblChooseThree.constant = 0
//        lblChooseFour.constant = 0
        
        btnEnquire.layer.cornerRadius = 6
        btnEnquire.layer.borderWidth = 0.5
        btnEnquire.layer.borderColor = UIColor.white.cgColor
        
        btnEnquire.layer.shadowColor = UIColor.gray.cgColor
        btnEnquire.layer.shadowOffset = CGSize(width: 0, height: 1)
        btnEnquire.layer.shadowOpacity = 1
        btnEnquire.layer.shadowRadius = 3
        

        
        btnSOS.layer.cornerRadius = 24
        btnSOS.layer.borderWidth = 2
        btnSOS.layer.borderColor = UIColor(named: "Reddish")?.cgColor
        
        btnIntroduction.blackBorder()
        btnChoose.blackBorder()
        btnService.blackBorder()
        
        
        viewMenu.isHidden = true
        viewMenu.layer.cornerRadius = 6
        viewMenu.layer.borderWidth = 0.5
        viewMenu.layer.borderColor = UIColor.lightGray.cgColor
        
        viewSearch.layer.cornerRadius = 20
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.black.cgColor
        
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor
        
        // Add title color for different states of the buttons
        btnIntroduction.setTitleColor(.white, for: .selected)
        btnIntroduction.setTitleColor(.black, for: .normal)
        btnChoose.setTitleColor(.white, for: .selected)
        btnChoose.setTitleColor(.black, for: .normal)
        btnService.setTitleColor(.white, for: .selected)
        btnService.setTitleColor(.black, for: .normal)
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            adjustScrollViewHeight()
        }
    
    func adjustScrollViewHeight() {
        let desiredHeight: CGFloat = 640 // Aapki desired height yahan set kijiye

            // Scroll view ki height ko set karein
            scrollView.contentSize = CGSize(width: scrollView.frame.width, height: desiredHeight)
        scrollView.isScrollEnabled = true // Enable scrolling

        }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnEnquireTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EnquireViewController") as! EnquireViewController
        self.navigationController?.pushViewController(vc, animated: true)    }
    
    
    
    @IBAction func btnIntroTapped(_ sender: Any) {
        if btnChoose.isSelected {
                    btnChooseTapped(sender)
                }
                if btnService.isSelected {
                    btnServiceTapped(sender)
                }
                toggleButtonState(button: btnIntroduction, constraint: IntroOpeningClosingConstraint)
        
        // Check if Introduction button is selected
           if btnIntroduction.isSelected {
               // Set the heights for all the intro views to 40
               setIntroHeights(to: 40)
           } else {
               // Set the heights for all the intro views to 0
               setIntroHeights(to: 0)
           }

           // Reset the heights for all the choose views to 0 if Introduction button is tapped
           setChooseHeights(to: 0)
            }
    
    
    
    @IBAction func btnChooseTapped(_ sender: Any) {
        if btnIntroduction.isSelected {
                 btnIntroTapped(sender)
             }
             if btnService.isSelected {
                 btnServiceTapped(sender)
             }
             toggleButtonState(button: btnChoose, constraint: ChooseOpeningClosingConstraint)
        
     
        
        // Check if Choose button is selected
            if btnChoose.isSelected {
                // Set the heights for all the Choose views to 40
                setChooseHeights(to: 40)
            } else {
                // Set the heights for all the Choose views to 0
                setChooseHeights(to: 0)
            }
        
        // Reset the heights for all the intro views to 0 if Choose button is tapped
        setIntroHeights(to: 0)
    }
    
    
    
    
    
    @IBAction func btnServiceTapped(_ sender: Any) {
        if btnIntroduction.isSelected {
                    btnIntroTapped(sender)
                }
                if btnChoose.isSelected {
                    btnChooseTapped(sender)
                }
                toggleButtonState(button: btnService, constraint: ServiceOpeningClosingConstraint)
        
        // Reset the heights for all the intro views to 0 if Service button is tapped
        setIntroHeights(to: 0)
        // Reset the heights for all the intro views to 0 if Choose button is tapped
        setChooseHeights(to: 0)
    }
        
    func toggleButtonState(button: UIButton, constraint: NSLayoutConstraint) {
            button.isSelected = !button.isSelected

        if button.isSelected {
                // Button is selected, expand it
                if constraint === ServiceOpeningClosingConstraint {
                    constraint.constant = 100
                    button.backgroundColor = UIColor(named: "Turquoise")
                    button.layer.borderColor = UIColor(named: "Turquoise")?.cgColor
                } else if constraint === ChooseOpeningClosingConstraint {
                    constraint.constant = 149
                    button.backgroundColor = UIColor(named: "Turquoise")
                    button.layer.borderColor = UIColor(named: "Turquoise")?.cgColor
                } else if constraint === IntroOpeningClosingConstraint {
                    constraint.constant = 187
                    button.backgroundColor = UIColor(named: "Turquoise")
                    button.layer.borderColor = UIColor(named: "Turquoise")?.cgColor
                }
            } else {
                // Button is not selected, collapse it
                constraint.constant = 0
                button.backgroundColor = UIColor.white
                btnIntroduction.blackBorder()
                btnChoose.blackBorder()
                btnService.blackBorder()
            }
        }
    
    // Helper function to set heights for all intro views
    func setIntroHeights(to height: CGFloat) {
        viewIntroOne.constant = height
        viewIntroTwo.constant = height
        viewIntroThree.constant = height
        viewIntroFour.constant = height

        imgIntroOne.constant = height
        imgIntroTwo.constant = height
        imgIntroThree.constant = height
        imgIntroFour.constant = height

        lblIntroOne.constant = height
        lblIntroTwo.constant = height
        lblIntroThree.constant = height
        lblIntroFour.constant = height
    }
    
    // Helper function to set heights for all Choose views
    func setChooseHeights(to height: CGFloat) {
        viewChooseOne.constant = height
        viewChooseTwo.constant = height
        viewChooseThree.constant = height
//        viewChooseFour.constant = height
        
        imgChooseOne.constant = height
        imgChooseTwo.constant = height
        imgChooseThree.constant = height
//        imgChooseFour.constant = height
        
        lblChooseOne.constant = height
        lblChooseTwo.constant = height
        lblChooseThree.constant = height
//        lblChooseFour.constant = height
    }

    }




extension DoctorConsultViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == safetyCollectionView {
            return safetyImages.count
        } else {
            return serviceImages.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == safetyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorSafetyCVC", for: indexPath) as! DoctorSafetyCVC
            cell.imgSafetyTraining.image =  UIImage(named: safetyImages[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DoctorServiceCVC", for: indexPath) as! DoctorServiceCVC
            cell.imgServiceInformation.image =  UIImage(named: serviceImages[indexPath.row])
            cell.lblServiceNames.text = serviceNames[indexPath.row]

            return cell
        }
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if collectionView == serviceCollectionView {
//            if indexPath.item == 0 {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "InjuryViewController") as! InjuryViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//
//            } else if indexPath.item == 1 {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "ChronicViewController") as! ChronicViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            } else if indexPath.item == 2 {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "CardiacViewController") as! CardiacViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            }else {
//                let vc = storyboard?.instantiateViewController(withIdentifier: "WoundViewController") as! WoundViewController
//                self.navigationController?.pushViewController(vc, animated: true)
//            }
//        }
//
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == safetyCollectionView {
            return CGSize(width: 393, height: 93)

        } else {
            return CGSize(width: 110, height: 115)

        }
        
    }
}
