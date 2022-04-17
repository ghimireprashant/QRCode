//
//  ReuseIdentifiable.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
import Foundation
import UIKit
protocol ReuseIdentifiable {
  static var identifier: String { get }
}

extension ReuseIdentifiable {
  static var identifier: String {
    return String(describing: Self.self)
  }
}
extension UITableViewCell: ReuseIdentifiable {
}
