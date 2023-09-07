//
//  AboutUsViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 03/07/23.
//

import UIKit
import AVFoundation
import BackgroundTasks
import AppTrackingTransparency
import AVKit

class AboutUsViewController: MenuViewController {
    
    @IBOutlet var btnSOS: UIButton!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var partnersImages: [String] = ["AICTE", "Fortis", "Max", "Tata", "PathKind", "SAR"]

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
        


    }
    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }



}


extension AboutUsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return partnersImages.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutUsCVC", for: indexPath) as! AboutUsCVC
        cell.imgPartnersImg.image =  UIImage(named: partnersImages[indexPath.row])
        cell.viewPartnersImage.layer.cornerRadius = 8
        cell.viewPartnersImage.layer.shadowColor = UIColor.gray.cgColor
        cell.viewPartnersImage.layer.shadowOffset = CGSize(width: 0, height: 1)
        cell.viewPartnersImage.layer.shadowOpacity = 1
        cell.viewPartnersImage.layer.shadowRadius = 3
        

            return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 77, height: 77)
        
    }
}
