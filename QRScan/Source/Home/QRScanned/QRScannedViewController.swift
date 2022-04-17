//
//  QRScannedViewController.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import UIKit

class QRScannedViewController: UIViewController {
  @IBOutlet var fotterView: UIView!
  @IBOutlet weak var tableView: UITableView!
  var viewModel: QRScannedViewModel!
  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    self.navigationItem.title = "QR Detail"
    self.viewModel.delegate = self
    setUpTable()
    self.viewModel.viewDidLoad()
    }
  /// This function will setUp tableview
  private func setUpTable() {
    self.tableView.tableFooterView = fotterView
    self.tableView.updateFooterViewHeight()
  }
  /// This function will validate textfield
  /// - Returns: Bool
  private func validateTextField() -> Bool {
    self.view.endEditing(true)
    let requiredField: [QRDataEnum] = [.fullName, .email, .mobileNumber]
    
    for item in self.viewModel.dataSource where requiredField.contains(item.textFieldType) {
      switch item.textFieldType {
        
      case .mobileNumber:
        do {
          _ = try item.value.validatedText(validationType: .mobileNumber)
        } catch let error as ValidationError {
          showNormalAlert(for: error.message)
          return false
        } catch {
        }
      case .email:
        do {
          _ = try item.value.validatedText(validationType: .email)
        } catch let error as ValidationError {
          showNormalAlert(for: error.message)
          return false
        } catch {
        }
      default:
        do {
          _ = try item.value.validatedText(validationType: .requiredField(field: item.textFieldType.rawValue))
        } catch let error as ValidationError {
          showNormalAlert(for: error.message)
          return false
        } catch {
        }
        
      }
    }
    return true
  }
  @IBAction func saveAction(_ sender: Any) {
    guard validateTextField() else {return}
    self.viewModel.saveQRDetail()
  }
}
// MARK: - TableView DataSource
extension QRScannedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.dataSource?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
    tableView.dequeueReusableCell(
      withIdentifier: TextFieldTableViewCell.identifier,
      for: indexPath
    ) as! TextFieldTableViewCell
    cell.delegate = self
    cell.indexPath = indexPath
    cell.textField.text = self.viewModel.itemAtRow(indexPath.row).value
    cell.textfieldType = self.viewModel.itemAtRow(indexPath.row).textFieldType
    return cell
    
  }
}
// MARK: - Textfield TableView Delegate
extension QRScannedViewController: TextFieldTVDelegate {
  func didBeginEditing(cell: TextFieldTableViewCell, indexPath: IndexPath, cellType: QRDataEnum) {
    self.viewModel.dataSource?[indexPath.row].value = cell.textField.text ?? ""
  }
}

extension QRScannedViewController: QRScannedViewModelDelegate {
  func didSavedData() {
    self.showNormalAlert(for: "Success", description: "Scanned Data Save To Local") {
      self.navigationController?.popToRootViewController(animated: true)
    }
  }
}
