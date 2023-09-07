//
//  UIButton + Ext.swift
//  Heka Healthy You
//
//  Created by saeem.
//

import Foundation
import UIKit

// MARK: UIButton Extension
extension UIButton {
    public func blackBorder(){
        self.layer.cornerRadius = 9
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
}
