//
//  LoginViewController.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/15/22.
//

import UIKit
import LocalAuthentication
class LoginViewController: UIViewController {

  var authContext = LAContext()
  var viewModel: LoginViewModel!

  // MARK: - View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
    }

  /// This function is for Owner Authentication
  /// - Parameter completionHandler: completionHandler
  private func showAuthentication(completionHandler: @escaping(() -> ())) {
    authContext = LAContext()
    authContext.localizedCancelTitle = "Cancel"
    // First check if we have the needed hardware support.
    var error: NSError?
    if authContext.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
      authContext.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Authenticate to activate your service." ) { success, error in
        DispatchQueue.main.async {
          if success {
            completionHandler()
          }
        }
      }
    } else {
      showNormalAlert(for: "Your mobile is not secure enough", description: "You must have security set up on your mobile to activate your service", completionHandler: nil)
    }
  }
  // MARK: - IB Action
  @IBAction func bioLoginAction(_ sender: Any) {
    showAuthentication {
      self.viewModel.setDateAndTime()
      let storyboard = UIStoryboard(name: "Home", bundle: nil)
      let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
      let navigation = UINavigationController(rootViewController: viewController)
      AppDelegate.shared()?.changeRootViewController(with: navigation)
    }
  }
}
