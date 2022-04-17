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
  func setEmptyMessage(_ message: String) {
    let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
    messageLabel.text = message
    messageLabel.textColor = .black
    messageLabel.numberOfLines = 0
    messageLabel.textAlignment = .center
    messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
    messageLabel.sizeToFit()
    
    self.backgroundView = messageLabel
    self.separatorStyle = .none
  }
  
  func restore() {
    self.backgroundView = nil
    self.separatorStyle = .singleLine
  }
}
extension UIView {
  @IBInspectable var cornerRadius: CGFloat {
    
    get{
      return layer.cornerRadius
    }
    set {
      layer.cornerRadius = newValue
      layer.masksToBounds = newValue > 0
    }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get {
      return layer.borderWidth
    }
    set {
      layer.borderWidth = newValue
    }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get {
      return UIColor(cgColor: layer.borderColor!)
    }
    set {
      layer.borderColor = borderColor?.cgColor
    }
  }
}
