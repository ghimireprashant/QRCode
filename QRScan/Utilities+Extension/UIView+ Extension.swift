//
//  Extension+UIView.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
import UIKit
protocol RequiredField {
  func setUpRequiredField()
  func removeRequiredField()
}
/// This extension is for required field in view
extension RequiredField where Self: UIView {
  /// This function will add * to view
  func setUpRequiredField() {
    let label = UILabel()
    label.tag = 201
    label.text = "*"
    label.textColor = UIColor.red
    self.addSubview(label)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    label.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: 2).isActive = true
  }
  /// This function will remove * to view
  func removeRequiredField() {
    for item in subviews where item.tag == 201 {
      item.removeFromSuperview()
    }
  }
}
extension UITableView {
  func updateFooterViewHeight() {
    if let footer = self.tableFooterView {
      let newSize = footer.systemLayoutSizeFitting(CGSize(width: self.bounds.width, height: 0))
      footer.frame.size.height = newSize.height
    }
    }
}
