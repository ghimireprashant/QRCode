//
//  UsersViewController.swift
//  QRScan
//
//  Created by Prashant Ghimire on 4/15/22.
//

import UIKit

class UsersViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  var viewModel: UserViewModel!

  // MARK: - View Cycle
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    self.navigationItem.title = "Users"
    tableViewSetUp()
    viewModel = UserViewModel()
    viewModel.delegate = self
    viewModel.viewDidLoad()
    }
  /// This function will register tableview cell
  private func tableViewSetUp() {
    self.tableView.register(UserTableViewCell.nib(), forCellReuseIdentifier: UserTableViewCell.identifier)
  }
}
// MARK: - User ViewModel Delegate
extension UsersViewController: UserViewModelDelegate {
  func refreshDisplay(_ viewModel: UserViewModel) {
    self.tableView.reloadData()
  }
}
// MARK: - TableView DataSource
extension UsersViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.noOfRows
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell =
    tableView.dequeueReusableCell(
      withIdentifier: UserTableViewCell.identifier,
      for: indexPath
    ) as! UserTableViewCell
    cell.item = viewModel.itemAtRow(indexPath.row)
    cell.tag = indexPath.row
//    cell.delegate = self
    return cell
    
  }
}
// MARK: - TableView Delegate
extension UsersViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let viewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
    viewController.viewModel = LoginViewModel(users: self.viewModel.usersDataSource, selectedUser: self.viewModel.usersDataSource[indexPath.row])
    self.navigationController?.pushViewController(viewController, animated: true)
  }
}
