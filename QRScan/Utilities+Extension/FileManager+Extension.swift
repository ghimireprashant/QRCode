//
//  FileManager+Extension.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import Foundation
extension FileManager {
  
  /// - parameter fileName: String - the name and extension of the file to search for
  /// - returns: Bool
  class func fileExistsInDocumentDirectory(fileName: String) -> Bool {
    let filePath = FileManager.documentDirectory().appendingPathComponent(fileName).path
    return FileManager.default.fileExists(atPath: filePath)
  }
  
  
  /// Returns the URL of the iOS application document directory
  /// - returns: URL
  class func documentDirectory() -> URL {
    return URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
  }
}
