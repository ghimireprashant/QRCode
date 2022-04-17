//
//  QRHistoryViewController.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/16/22.
//

import UIKit

class QRHistoryViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var viewModel: QRHistoryViewModel!
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    self.navigationItem.title = "QR History"
    viewModel.delegate = self
    viewModel.viewDidLoad()
  }
  
}
//// MARK: - User ViewModel Delegate
extension QRHistoryViewController: QRHistoryViewModelDelegate {
  func refreshDisplay(_ viewModel: QRHistoryViewModel) {
    if viewModel.qrScannedDataSource.count == 0 {
      self.tableView.setEmptyMessage("No QR History")
    }
    self.tableView.reloadData()
  }
}
// MARK: - TableView DataSource
extension QRHistoryViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.noOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
    tableView.dequeueReusableCell(
      withIdentifier: QRHistoryTableViewCell.identifier,
      for: indexPath
    ) as! QRHistoryTableViewCell
    cell.item = viewModel.itemAtRow(indexPath.row)
    return cell
    
  }
}
