//
//  UIViewController+Extension.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/15/22.
//

import Foundation
import UIKit
extension UIViewController {
  /// This function will display alert
  /// - Parameters:
  ///   - title: title for alert
  ///   - description: message
  ///   - completionHandler: completionHandler
  func showNormalAlert(for title: String? = nil, description: String? = nil, completionHandler: (() -> Void)? = nil) {
    let alertController = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
    let alertAction = UIAlertAction(title: "OK", style: .cancel) { (alert) in
      completionHandler?()
    }
    alertController.addAction(alertAction)
    present(alertController, animated: true, completion: nil)
  }
}

extension Optional where Wrapped: CustomStringConvertible {
  var unWrappedValue: String {
    switch self {
    case .none: return "NA"
    case let .some(wrapped): return wrapped.description
    }
  }
//  var unWrappedEmptyValue: String {
//    switch self {
//    case .none: return ""
//    case let .some(wrapped): return wrapped.description
//    }
//  }
}
