//
//  UIVC + Extension.swift
//  Heka Healthy You
//
//  Created by saeem  on 13/08/23.
//

import UIKit

extension UIViewController {
    
    func SimpleAlert(withTitle title: String, message : String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        { action in
            print("You've pressed OK Button")
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func Alert(withTitle title: String, message : String , completion : @escaping ()  -> Void )
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        { action in
          completion()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default){ a in
            self.dismiss(animated: true)
        }
        
        alertController.addAction(OKAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func Alert1(withTitle title: String, message : String , completion : @escaping ()  -> Void )
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        { action in
          completion()
        }
        
        alertController.addAction(OKAction)

        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

extension UITextField {
    func addPaddingToTextField(padding : Double,imageName : String) {
        let leftView = UIView()
        leftView.frame = CGRect.init(x: 10.0, y: 0.0, width: padding, height: self.frame.size.height)
        self.leftView = leftView
        self.leftViewMode = .always
        let imageView = UIImageView()
        imageView.frame = CGRect.init(x: 10, y: 15, width: 20, height: 20)
        imageView.image = UIImage.init(named: imageName)
        leftView.addSubview(imageView)
       }
}

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier { UserDefaults.standard.removePersistentDomain(forName: bundleID) } }
}


extension UIColor {

    static var gradientDarkGrey: UIColor {
        return UIColor(red: 210 / 255.0, green: 210 / 255.0, blue: 220 / 255.0, alpha: 1)

    }

    static var gradientLightGrey: UIColor {
        return UIColor(red: 240 / 255.0, green: 240 / 255.0, blue: 240 / 255.0, alpha: 1)

    }
    

}


extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
