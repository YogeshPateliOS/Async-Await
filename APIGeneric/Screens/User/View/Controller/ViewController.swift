//
//  ViewController.swift
//  APIGeneric
//
//  Created by Yogesh Patel on 21/04/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userTableView: UITableView!
    private let viewModel = UserViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
    }

    func initViewModel() {
        viewModel.userDelegate = self
        viewModel.fetchUsers()
    }

}

extension ViewController: UserServices {

    func reloadData() {
       // DispatchQueue.main.async {
            self.userTableView.reloadData()
       // }
    }
    
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        else { return UITableViewCell() }
        var content = cell.defaultContentConfiguration()
        content.text = viewModel.users[indexPath.row].name
        cell.contentConfiguration = content
        return cell
    }

}
