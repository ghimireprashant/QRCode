//
//  HomeViewController.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import UIKit

class HomeViewController: UIViewController {
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationItem.title = "Home"
    // Do any additional setup after loading the view.
    //
    let logoutBarButtonItem = UIBarButtonItem(image: UIImage(named: "iconLogout"), style: .plain, target: self, action: #selector(onSearchButtonClicked))
    self.navigationItem.rightBarButtonItem  = logoutBarButtonItem
  }
  // MARK: - Button Action

  @objc func onSearchButtonClicked(_ sender: Any){
    let logOutAlert = UIAlertController(title: "Alert", message: "Are you sure you want to logout", preferredStyle: UIAlertController.Style.alert)
    
    logOutAlert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { (action: UIAlertAction!) in
      let viewController = UsersViewController(nibName: "UsersViewController", bundle: nil)
      let navigationController = UINavigationController(rootViewController: viewController)
      AppDelegate.shared()?.changeRootViewController(with: navigationController)
    }))
    
    logOutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    
    present(logOutAlert, animated: true, completion: nil)
  }
  
  @IBAction func userActivityAction(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "QRScannedViewController") as! QRScannedViewController
    viewController.viewModel = QRScannedViewModel()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  @IBAction func scanQRAction(_ sender: Any) {
    let viewController = ScanViewController()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
  @IBAction func qrScanHistoryAction(_ sender: Any) {
    let storyboard = UIStoryboard(name: "Home", bundle: nil)
    let viewController = storyboard.instantiateViewController(withIdentifier: "QRHistoryViewController") as! QRHistoryViewController
    viewController.viewModel = QRHistoryViewModel()
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
