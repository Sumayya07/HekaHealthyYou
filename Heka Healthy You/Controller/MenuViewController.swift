//
//  MenuViewController.swift
//  Heka Healthy You
//
//  Created by saeem  on 05/07/23.
//

import UIKit
import PassKit
import AVFoundation
import BackgroundTasks
import AppTrackingTransparency
import AVKit
import MBProgressHUD


class MenuViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewMenu: UIView!
    
    
    @IBOutlet var lblUserFullName: UILabel!
    
    @IBOutlet var btnLogin: UIButton!
    @IBOutlet var btnSignup: UIButton!
    
    
    
    let lblMenu = ["About Us","Our Services","Download Certificate","My Coupons","Payments","My Medical Records","Change Language","Settings","Help & Support","Order History","Like Us ? Rate Us ","Legal","Log Out","FAQ","","",""]
    
    let imgMenu = ["About","Services","Certificate","Coupons","Payments","Records","Language","Settings","Help","History","Rate","Legal","Logout","FAQ","","",""]
    
    var currentMenuOptions: [String] {
        if UserManager.shared.currentUser == nil {
            // User is not logged in, so filter out the specified options
            return lblMenu.filter {
                $0 != "Log Out" &&
                $0 != "Download Certificate" &&
                $0 != "My Coupons" &&
                $0 != "Payments" &&
                $0 != "My Medical Records"
            }
        }
        return lblMenu
    }

    var currentImageOptions: [String] {
        if UserManager.shared.currentUser == nil {
            // User is not logged in, so filter out the specified image options
            return imgMenu.filter {
                $0 != "Logout" &&
                $0 != "Certificate" &&
                $0 != "Coupons" &&
                $0 != "Payments" &&
                $0 != "Records"
            }
        }
        return imgMenu
    }

    var isMenuViewOpen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        isMenuViewOpen = false
        
        // Add observer to get notified when user logs out
          NotificationCenter.default.addObserver(self, selector: #selector(handleUserLoggedOut), name: NSNotification.Name("userLoggedOut"), object: nil)

       
    }
    
    @objc func handleUserLoggedOut() {
        // Call viewWillAppear to refresh the UI (this assumes viewWillAppear handles UI refresh based on login status)
        viewWillAppear(true)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear triggered")

        super.viewWillAppear(animated)
        
        if let currentUser = UserManager.shared.currentUser {
            let firstName = currentUser.firstName
            lblUserFullName?.text = "Hello \(firstName)"
            print("Current User Information: \(currentUser)")
            
            btnLogin?.isHidden = true
            btnSignup?.isHidden = true
        } else {
            lblUserFullName?.text = ""
            print("No current user found.")
            
            btnLogin?.isHidden = false
            btnSignup?.isHidden = false
        }
        
        // Reload the tableView to adjust for menu options based on user's login status
        tableView.reloadData()

        closeMenuIfNeeded()
    }



    
    
    @IBAction func btnLoginSignup(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func btnSignupTapped(_ sender: Any) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    @IBAction func btnMenuTapped(_ sender: Any) {
        isMenuViewOpen.toggle()
        if let menuView = viewMenu, let tableView = tableView {
            if isMenuViewOpen {
                menuView.isHidden = false
                tableView.isHidden = false
                self.view.bringSubviewToFront(menuView)
            } else {
                menuView.isHidden = true
                tableView.isHidden = true
            }
        }
    }
    
    private func closeMenuIfNeeded() {
        if isMenuViewOpen {
            if let menuView = viewMenu, let tableView = tableView {
                menuView.isHidden = true
                tableView.isHidden = true
                isMenuViewOpen = false
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("userLoggedOut"), object: nil)
    }

    
}

extension MenuViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMenuOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        let imageMenu = currentImageOptions[indexPath.row]
        cell.imgMenus.image = UIImage(named: imageMenu)
        cell.lblMenus.text = currentMenuOptions[indexPath.row]
        
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = .clear
        cell.selectedBackgroundView = selectedBackgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Check if the index is within the range of the currentMenuOptions array
        if indexPath.row < currentMenuOptions.count {
            let selectedLabel = currentMenuOptions[indexPath.row]
            
            if selectedLabel == "About Us" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AboutUsViewController") as? AboutUsViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "FAQ" {
                if let vc = self.storyboard?.instantiateViewController(withIdentifier: "FAQViewController") as? FAQViewController {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            } else if selectedLabel == "Log Out" {
                let logoutVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogoutViewController") as! LogoutViewController
                logoutVC.modalPresentationStyle = .overFullScreen
                self.present(logoutVC, animated: true) {
                    // After presentation, set a timer to dismiss it after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        logoutVC.dismiss(animated: true)
                        self.closeMenuIfNeeded()
                    }
                }
            }
        }
    }
}
