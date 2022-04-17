//
//  UserModel.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
struct UserModel: Codable {
  let id: Int
  let fullName: String
  let userName: String
  let password: String
  var lastLoginDate: Double?
  var formatedDate: String = ""
  
  enum CodingKeys : String, CodingKey {
    case id
    case fullName = "fullname"
    case userName = "username"
    case password
    case lastLoginDate = "lastLoginDt"
  }
  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    id = try values.decode(Int.self, forKey: .id)
    fullName = try values.decode(String.self, forKey: .fullName)
    userName = try values.decode(String.self, forKey: .userName)
    password = try values.decode(String.self, forKey: .password)
    lastLoginDate = try values.decodeIfPresent(Double.self, forKey: .lastLoginDate)
    if let lastLogin = lastLoginDate {
      let date = Date(timeIntervalSince1970: lastLogin)
      self.formatedDate = date.dateString()
    }
  }
}
typealias Users = [UserModel]
