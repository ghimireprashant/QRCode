//
//  QRHistoryTableViewCell.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import UIKit

class QRHistoryTableViewCell: UITableViewCell {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var mobileNumberLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  var item: QRScannedModel? {
    didSet{
      self.nameLabel.text = "User Name: \(item?.fullName ?? "")"
      self.emailLabel.text = "Email: \(item?.email ?? "")"
      self.mobileNumberLabel.text = "Mobile No: \(item?.mobileNumber ?? "")"
      self.dateLabel.text = "Scanned Date: \(item?.formatedDate ?? "")"
    }
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization codes
      self.selectionStyle = .none
    }

}
