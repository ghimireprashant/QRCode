//
//  AppDelegate.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/15/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    self.window = UIWindow(frame: UIScreen.main.bounds)

    // MARK: Navigation Bar Customisation
    if #available(iOS 15, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = UIColor(red: 0.098, green: 0.216, blue: 0.169, alpha: 1.00)
      appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
      UINavigationBar.appearance().standardAppearance = appearance
      UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    UIBarButtonItem.appearance().tintColor = .white
    if #available(iOS 13, *) { } else {
      loadInitalViewController()
    }
    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last)
    return true
  }
  
  // MARK: UISceneSession Lifecycle
  
  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }
  
  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  // MARK: - appdelegate insatance
  class func shared() -> AppDelegate? {
    return UIApplication.shared.delegate as? AppDelegate
  }

  // MARK: - change root animation
  func changeRootViewController(with desiredViewController: UIViewController) {
    var mainWindow: UIWindow?
    if #available(iOS 13.0, *) {
      let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
      mainWindow = (windowScene?.delegate as? SceneDelegate)?.window
    } else {
      mainWindow = AppDelegate.shared()?.window
    }
    let snapshot: UIView = (mainWindow?.snapshotView(afterScreenUpdates: true))!
    desiredViewController.view.addSubview(snapshot)
    mainWindow?.rootViewController = desiredViewController
    mainWindow?.makeKeyAndVisible()
    UIView.animate(withDuration: 0.3, animations: {() in
      snapshot.layer.opacity = 0
      snapshot.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
    }, completion: { (_: Bool) in
      snapshot.removeFromSuperview()
    })
  }
}

func loadInitalViewController() {
  var mainWindow: UIWindow?
  if #available(iOS 13.0, *) {
    let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
    mainWindow = (windowScene?.delegate as? SceneDelegate)?.window
  } else {
    mainWindow = AppDelegate.shared()?.window
  }
  let viewController = UsersViewController(nibName: "UsersViewController", bundle: nil)
  
  let navigationController = UINavigationController(rootViewController: viewController)
  mainWindow?.rootViewController = navigationController
  mainWindow?.makeKeyAndVisible()
}
