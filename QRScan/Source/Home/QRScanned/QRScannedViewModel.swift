//
//  QRScannedViewModel.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
protocol QRScannedViewModelDelegate: NSObjectProtocol {
  func didSavedData()
}
final class QRScannedViewModel {
  var dataSource: [TextFieldData]!
  var parseQRObject: QRScannedModel?
  var allScannedData: [QRScannedModel] = []
  weak var delegate: QRScannedViewModelDelegate?
  func viewDidLoad() {
    if let parseQRObject = parseQRObject {
      dataSource = [TextFieldData(textFieldType: .fullName, value: parseQRObject.fullName ?? ""), TextFieldData(textFieldType: .email, value: parseQRObject.email ?? ""), TextFieldData(textFieldType: .mobileNumber, value: parseQRObject.mobileNumber ?? "")]
    } else {
      dataSource = [TextFieldData(textFieldType: .fullName), TextFieldData(textFieldType: .email), TextFieldData(textFieldType: .mobileNumber)]
    }
  }
  var noOfRows: Int {
    return self.dataSource.count
  }
  
  func itemAtRow(_ row: Int) -> TextFieldData {
    return dataSource[row]
  }
  func saveQRDetail() {
    if FileManager.fileExistsInDocumentDirectory(fileName: Constant.FileName.scannedData) {
      let inputFileURL = FileManager.documentDirectory().appendingPathComponent(Constant.FileName.scannedData)
      let decoder = JSONDecoder()
      guard let inputData = try? Data(contentsOf: inputFileURL), let scannedData = try? decoder.decode([QRScannedModel].self, from: inputData) else {
        return
      }
      self.allScannedData = scannedData
    }
    var newData = QRScannedModel()
    if let email = self.dataSource.first(where: {$0.textFieldType == .email}) {
      newData.email = email.value
    }
    if let fullName = self.dataSource.first(where: {$0.textFieldType == .fullName}) {
      newData.fullName = fullName.value
    }
    if let mobile = self.dataSource.first(where: {$0.textFieldType == .mobileNumber}) {
      newData.mobileNumber = mobile.value
    }
    newData.scannedDate = Date().timeIntervalSince1970
    self.allScannedData.append(newData)
    saveQRDataToLocal()

  }
  func saveQRDataToLocal() {
    let outputFileURL = FileManager.documentDirectory().appendingPathComponent(Constant.FileName.scannedData)
    do {
      // Encoder, to encode our data.
      let jsonEncoder = JSONEncoder()
      
      // Convert our Object into a Data object.
      let jsonData = try jsonEncoder.encode(allScannedData)
      
      // Write the data to output.
      try jsonData.write(to: outputFileURL)
      self.delegate?.didSavedData()
    } catch {
      // Error Handling.
      print("Failed to write to file \(error.localizedDescription)")
      return
    }
  }
}
struct TextFieldData {
  var textFieldType: QRDataEnum
  var value: String = ""
}
//struct AddressDataModel {
//  var textFieldType: AddressEnum
//  var value: String = ""
//  init(textFieldType: AddressEnum) {
//    self.textFieldType = textFieldType
//  }
//  static func getAddress() -> [AddressDataModel] {
//    return [AddressDataModel(textFieldType: .fullName), AddressDataModel(textFieldType: .email), AddressDataModel(textFieldType: .addressOne), AddressDataModel(textFieldType: .addressTwo), AddressDataModel(textFieldType: .mobileNumber), AddressDataModel(textFieldType: .country), AddressDataModel(textFieldType: .state), AddressDataModel(textFieldType: .city), AddressDataModel(textFieldType: .zipCode) ]
//  }
//}
