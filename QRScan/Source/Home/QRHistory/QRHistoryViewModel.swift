//
//  QRHistoryViewModel.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
protocol QRHistoryViewModelDelegate: NSObjectProtocol {
  func refreshDisplay(_ viewModel: QRHistoryViewModel)
}
final class QRHistoryViewModel {
  var qrScannedDataSource: [QRScannedModel] = [] {
    didSet {
      self.delegate?.refreshDisplay(self)
    }
  }
  weak var delegate: QRHistoryViewModelDelegate?
  
  /// This function will fetch data from server/json file
  func viewDidLoad() {
    if FileManager.fileExistsInDocumentDirectory(fileName: Constant.FileName.scannedData) {
      let inputFileURL = FileManager.documentDirectory().appendingPathComponent(Constant.FileName.scannedData)
      let decoder = JSONDecoder()
      guard let inputData = try? Data(contentsOf: inputFileURL), let scannedData = try? decoder.decode([QRScannedModel].self, from: inputData) else {
        return
      }
      self.qrScannedDataSource = scannedData
    } else {
      self.qrScannedDataSource = []
    }
  }
  var noOfRows: Int {
    return self.qrScannedDataSource.count
  }
  
  func itemAtRow(_ row: Int) -> QRScannedModel {
    return qrScannedDataSource[row]
  }
}
