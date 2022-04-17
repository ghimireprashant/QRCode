//
//  Date+Extension.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
extension Date {
  /// This function will convert date to string
  /// - Parameters:
  ///   - format: date formate string
  ///   - enableLocal: enable local time
  /// - Returns: date string
  func dateString(_ format: String = "YYYY/MM/dd, hh:mm a") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
    }
}
