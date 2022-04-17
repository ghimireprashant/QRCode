//
//  QRScannedModel.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//
//case fullName = "Full Name"
//case email = "Email"
//case mobileNumber = "Mobile"
import Foundation
struct QRScannedModel: Codable {

  var fullName: String?
  var email: String?
  var mobileNumber: String?
  var scannedDate: Double?
  var formatedDate: String = ""
  init() {
  }
  
  enum CodingKeys : String, CodingKey {
    case fullName
    case email
    case mobileNumber
    case scannedDate
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    fullName = try values.decode(String.self, forKey: .fullName)
    email = try values.decode(String.self, forKey: .email)
    mobileNumber = try values.decode(String.self, forKey: .mobileNumber)
    scannedDate = try values.decodeIfPresent(Double.self, forKey: .scannedDate)
    if let lastLogin = scannedDate {
      let date = Date(timeIntervalSince1970: lastLogin)
      self.formatedDate = date.dateString()
    }
  }
}
