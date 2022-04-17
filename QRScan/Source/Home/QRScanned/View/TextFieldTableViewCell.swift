//
//  TextFieldTableViewCell.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import UIKit
protocol TextFieldTVDelegate: AnyObject {
  func didBeginEditing(cell: TextFieldTableViewCell, indexPath: IndexPath, cellType: QRDataEnum)
}
class TextFieldTableViewCell: UITableViewCell {
  @IBOutlet weak var textField: RequiredDefaultTextField!
  var textfieldType: QRDataEnum! {
    didSet {
      textField.placeholder = textfieldType.rawValue
      setUpKeyboard()
    }
  }
  var indexPath: IndexPath!
  weak var delegate: TextFieldTVDelegate?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    self.selectionStyle = .none
    self.textField.addTarget(self, action: #selector(didTextBeginEditing), for: .editingChanged)
  }

  private func setUpKeyboard() {
    switch textfieldType {
    case .mobileNumber:
      self.textField.keyboardType = .numberPad
    case .email:
      self.textField.keyboardType = .emailAddress
    default:
      self.textField.isRequired = true
      self.textField.keyboardType = .default
    }
  }
  @objc func didTextBeginEditing() {
    self.delegate?.didBeginEditing(cell: self, indexPath: self.indexPath, cellType: self.textfieldType)
  }

}
enum QRDataEnum: String {
  case fullName = "Full Name"
  case email = "Email"
  case mobileNumber = "Mobile"
}
