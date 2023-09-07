//
//  LookingTableViewCell.swift
//  Heka Healthy You
//
//  Created by saeem.
//

import UIKit

class LookingTableViewCell: UITableViewCell {

    @IBOutlet var btnCheckbox: UIButton!
    @IBOutlet var lblLookingNames: UILabel!
    
    weak var delegate: CheckBoxDelegate?
       var indexPath: IndexPath?

       override func awakeFromNib() {
           super.awakeFromNib()
           btnCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
       }

    @IBAction func checkboxbn(_ sender: UIButton) {
        if let indexPath = indexPath {
               delegate?.checkboxTapped(at: indexPath, for: .looking)
            setCheckbox(selected: sender.image(for: .normal) != UIImage(systemName: "checkmark.square.fill"))
           }
    }

       func setCheckbox(selected: Bool) {
           if selected {
               btnCheckbox.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
           } else {
               btnCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
           }
       }
   
}
