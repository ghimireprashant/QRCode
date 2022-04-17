//
//  UserViewModel.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
protocol UserViewModelDelegate: NSObjectProtocol {
  func refreshDisplay(_ viewModel: UserViewModel)
}
final class UserViewModel {
  var usersDataSource: [UserModel] = [] {
    didSet {
      self.delegate?.refreshDisplay(self)
    }
  }
  weak var delegate: UserViewModelDelegate?
  
  /// This function will fetch data from server/json file
  func viewDidLoad() {
    if let data = readLocalFile(forName: "User") {
      let decoder = JSONDecoder()
      guard let users = try? decoder.decode(Users.self, from: data) else {
        return
      }
      self.usersDataSource = users
    }
  }
  var noOfRows: Int {
    return self.usersDataSource.count
  }
  
  func itemAtRow(_ row: Int) -> UserModel {
    return usersDataSource[row]
  }
  
  /// This function will fetch data from json file
  /// - Parameter name: file name
  /// - Returns: Data
  private func readLocalFile(forName name: String) -> Data? {
    if FileManager.fileExistsInDocumentDirectory(fileName: Constant.FileName.users) {
      let inputFileURL = FileManager.documentDirectory().appendingPathComponent(Constant.FileName.users)
      let inputData = try? Data(contentsOf: inputFileURL)
      return inputData
    } else {
      do {
        if let bundlePath = Bundle.main.url(forResource: name, withExtension: "json"),
           let jsonData = try? Data(contentsOf: bundlePath) {
          return jsonData
        }
      }
    }
    return nil
  }
}

