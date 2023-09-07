//
//  ViewController.swift
//  Heka Healthy You
//
//  Created by saeem on 12/06/23.
//

import UIKit
import AVFoundation
import PassKit
import BackgroundTasks
import AVKit
import Reachability
import MBProgressHUD

class HomeViewController: MenuViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var viewBottomTabBar: UIView!
    @IBOutlet var viewSearch: UIView!
    @IBOutlet var btnSOS: UIButton!
    
    var customerId: String?
    
    let imageNames = ["Training", "ElderlyCare", "PregnancyCare", "OperativeCare", "Consultation", "LabTest", "Pharmacy", "Medical", "Service", "Wellness"]
    let labels = ["SAFETY TRAINING", "ELDERLY CARE", "PREGNANCY CARE", "OPERATIVE CARE", " DOCTOR CONSULTATION", "LAB TEST", "PHARMACY", "MEDICAL ASTROLOGY", "OVERSEAS SERVICE", "GENERAL WELLNESS"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.customerId as Any)
        fetchCustomerData()
        navigationController?.isNavigationBarHidden = true
        
        viewMenu.isHidden = true
        viewMenu.layer.cornerRadius = 6
        viewMenu.layer.borderWidth = 0.5
        viewMenu.layer.borderColor = UIColor.lightGray.cgColor
        
        viewSearch.layer.cornerRadius = 20
        viewSearch.layer.borderWidth = 1
        viewSearch.layer.borderColor = UIColor.black.cgColor
        
        viewBottomTabBar.layer.borderWidth = 1
        viewBottomTabBar.layer.borderColor = UIColor.black.cgColor

        btnSOS.layer.cornerRadius = 24
        btnSOS.layer.borderWidth = 2
        btnSOS.layer.borderColor = UIColor(named: "Reddish")?.cgColor
        
    }

    
    @IBAction func btnHomeTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
//        navigationController?.popViewController(animated: true)

    }
    
}
    
    extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCVC", for: indexPath) as! HomeCVC
            let imageName = imageNames[indexPath.row]
            cell.myImages.image = UIImage(named: imageName)
            cell.lblNames.text = labels[indexPath.row]
            
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.item == 0 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "TrainingViewController") as! TrainingViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else if indexPath.item == 1 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "ElderlyViewController") as! ElderlyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.item == 2 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "PregnancyCareViewController") as! PregnancyCareViewController
                self.navigationController?.pushViewController(vc, animated: true)
            } else if indexPath.item == 3 {
                let vc = storyboard?.instantiateViewController(withIdentifier: "OperativeViewController") as! OperativeViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
            return CGSize(width: 176, height: 110)
            
        }
        
    }
    
extension HomeViewController {
    
    func fetchCustomerData() {
        
        guard let customerId = self.customerId else {
//            SimpleAlert(withTitle: "Error", message: "Customer ID is missing")
            return
        }
        
        var reachability: Reachability?
        do {
            reachability = try Reachability()
        } catch {
            print("Unable to start notifier")
            return
        }
        
        guard reachability?.connection != .unavailable else {
            SimpleAlert(withTitle: "", message: "Please Check your Internet")
            return
        }
        
        MBProgressHUD.showAdded(to: view, animated: true)
        
        let url = URL(string: APIManager.shared.fetchCustomerDataURL)!  // Assuming you have this URL defined in APIManager
        var request = URLRequest(url: url)
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let params = ["data": "{\"customerId\":\"\(customerId)\"}"]
        print("Sending Customer Data request with data: \(params)")
        
        let dataBody = createDataBody(withParameters: params, boundary: boundary)
        request.httpBody = dataBody
        
        request.httpMethod = "POST"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let apiResponse = try decoder.decode(CustomerResponse.self, from: data)
                    print("Received API Response: \(apiResponse)")  // Print the API response
                    
                    DispatchQueue.main.async {
                        MBProgressHUD.hide(for: self.view, animated: true)
                        
                        if apiResponse.code == 200 {
                            // Handle the fetched customer data. You can update the UI elements or store the data for later use
                            // For example:
                            // self.updateUI(with: apiResponse.customer)
                        } else {
                            // Handle any error returned from the API
                            self.SimpleAlert(withTitle: "Error", message: apiResponse.message ?? "")
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.SimpleAlert(withTitle: "", message: "Error parsing response data")
                        MBProgressHUD.hide(for: self.view, animated: true)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.SimpleAlert(withTitle: "", message: "Something went wrong")
                    MBProgressHUD.hide(for: self.view, animated: true)
                    print("Error \(String(describing: error))")
                }
            }
        }
        dataTask.resume()
    }
}

private func createDataBody(withParameters params: [String: String], boundary: String) -> Data {
    let lineBreak = "\r\n"
    var body = Data()
    
    for (key, value) in params {
        body.append("--\(boundary)\(lineBreak)")
        body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
        body.append("\(value)\(lineBreak)")
    }
    
    body.append("--\(boundary)--\(lineBreak)")
    return body
}
