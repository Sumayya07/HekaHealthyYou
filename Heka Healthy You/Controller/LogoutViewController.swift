//
//  LogoutViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 23/08/23.
//

import UIKit
import MBProgressHUD

class LogoutViewController: UIViewController {

    @IBOutlet var viewLogoutSuccesful: UIView!
    
    var blurView: UIVisualEffectView?
    var hud: MBProgressHUD?
        
        override func viewDidLoad() {
            super.viewDidLoad()

            self.view.backgroundColor = .clear
            
            viewLogoutSuccesful.layer.cornerRadius = 12
            viewLogoutSuccesful.alpha = 0 // initially hide the logout successful view
            
            applyBackgroundBlur()
            
            // Show progress HUD after the blur
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
//            hud?.label.text = "Logging out..."
            
            // After 2 minutes, hide HUD and show 'Logout Successful' view
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.hud?.hide(animated: true)
                self.showLogoutSuccessfulView()
            }
            
            // Call the logout function
               logoutUser()

        }
        
        func showLogoutSuccessfulView() {
            UIView.animate(withDuration: 0.3) {
                self.viewLogoutSuccesful.alpha = 1
            }
        }
        
        func applyBackgroundBlur() {
            let blurEffect = UIBlurEffect(style: .extraLight)
            blurView = UIVisualEffectView(effect: blurEffect)
            blurView?.frame = self.view.bounds
            blurView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            blurView?.alpha = 0.7 // Adjust the alpha to reduce the intensity. Play with this value to achieve desired effect.

            
            self.view.insertSubview(blurView!, at: 0)
        }
    
    func logoutUser() {
        // Your logout logic here, for instance:
        // - Removing tokens
        // - Clearing session data
        // - Any network call to inform the backend about the logout, if needed

        // Set the user to nil since they've logged out
        UserManager.shared.currentUser = nil
        
        // Notify observers that user has logged out
        NotificationCenter.default.post(name: NSNotification.Name("userLoggedOut"), object: nil)
    }

    }
