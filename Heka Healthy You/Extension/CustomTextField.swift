//
//  CustomTextField.swift
//  Heka Healthy You
//
//  Created by Sumayya Siddiqui on 16/09/23.
//

import UIKit

protocol CustomTextFieldDelegate: AnyObject {
    func textFieldDidDeleteBackward(_ textField: CustomTextField)
}

class CustomTextField: UITextField {

    weak var deletionDelegate: CustomTextFieldDelegate?

    override func deleteBackward() {
        super.deleteBackward()
        deletionDelegate?.textFieldDidDeleteBackward(self)
    }
}
