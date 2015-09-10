//
//  UsersListViewController.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

class UsersListViewController : UITableViewController {
    // MARK: Properties
    private var viewModel: UsersListViewModel!
    
    // MARK: Initialization
    
    static func instance(viewModel vm: UsersListViewModel) -> UsersListViewController {
        let vc = UIStoryboard.Scene.Main.usersListViewController()
        vc.viewModel = vm
        return vc
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: UITableView DataSource/Delegate
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userVM = viewModel.users[indexPath.row]
        let cell = UserCell.dequeue(tableView, forIndexPath: indexPath)
        cell.fillWithViewModel(userVM)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let userVM = viewModel.users[indexPath.row]
        let provileVC = UserViewController.instance(viewModel: userVM)
        self.navigationController?.pushViewController(provileVC, animated: true)
    }
}
