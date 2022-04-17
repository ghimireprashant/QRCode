//
//  UserTableViewCell.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/15/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {
  class func nib() -> UINib {
    return UINib(nibName: UserTableViewCell.identifier, bundle: nil)
  }
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var lastLoginLabel: UILabel!
  var item: UserModel? {
    didSet {
      self.userNameLabel.text = "User Name: \(item?.fullName ?? "")"
      self.lastLoginLabel.text = "Last Login: \(item?.formatedDate ?? "")"
    }
  }

  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
