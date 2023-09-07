//
//  ReferredTableViewCell.swift
//  Heka Healthy You
//
//  Created by saeem.
//

import UIKit

class ReferredTableViewCell: UITableViewCell {
    
    @IBOutlet var btnCheckbox: UIButton!
    
    @IBOutlet var lblReferredNames: UILabel! {
        didSet {
            adjustFontSizeForLabel()
        }
    }
    
    weak var delegate: CheckBoxDelegate?
    var indexPath: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        btnCheckbox.setImage(UIImage(systemName: "square"), for: .normal)
    }
    
    @IBAction func checkboxbtn(_ sender: UIButton) {
        if let indexPath = indexPath {
            delegate?.checkboxTapped(at: indexPath, for: .referred)
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
    
    func adjustFontSizeForLabel() {
        let thresholdLength = 3  // Adjust based on when you'd like to reduce font size
        let normalFontSize: CGFloat = 17  // The default font size
        let reducedFontSize: CGFloat = 12  // The reduced font size for long text

        if let textLength = lblReferredNames.text?.count, textLength > thresholdLength {
            lblReferredNames.font = UIFont.systemFont(ofSize: reducedFontSize)
        } else {
            lblReferredNames.font = UIFont.systemFont(ofSize: normalFontSize)
        }
    }
}
