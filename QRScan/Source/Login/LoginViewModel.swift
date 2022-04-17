//
//  LoginViewModel.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
final class LoginViewModel {
  var users: [UserModel]!
  var selectedUser: UserModel!
  init(users: [UserModel], selectedUser: UserModel) {
    self.users = users
    self.selectedUser = selectedUser
  }
  /// This func will set date and time for logged in user
  func setDateAndTime() {
    self.selectedUser.lastLoginDate = Date().timeIntervalSince1970
    self.updateUsers()
  }
  /// This function will update user data to main users array
  func updateUsers() {
    if let selectedUserIndex = self.users.firstIndex(where: {$0.id == selectedUser.id}) {
      self.users[selectedUserIndex] = self.selectedUser
      self.saveUsersToLocal()
    }
  }
  /// This function will save data to json file in document directory
  func saveUsersToLocal() {
    let outputFileURL = FileManager.documentDirectory().appendingPathComponent(Constant.FileName.users)
    do {
      // Encoder, to encode our data.
      let jsonEncoder = JSONEncoder()
      
      // Convert our Object into a Data object.
      let jsonData = try jsonEncoder.encode(users)
      
      // Write the data to output.
      try jsonData.write(to: outputFileURL)
    } catch {
      // Error Handling.
      print("Failed to write to file \(error.localizedDescription)")
      return
    }
  }
}
