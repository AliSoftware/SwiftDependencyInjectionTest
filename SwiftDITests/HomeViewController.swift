//
//  HomeViewController.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Home"
    }

    // MARK: - Actions
    
    @IBAction func usersButtonTapped(sender: UIButton) {
        let usersVM = UsersListViewModel.registeredUsers()
        let usersVC = UsersListViewController.instance(viewModel: usersVM)
        usersVC.title = "Registered Users"
        self.navigationController?.pushViewController(usersVC, animated: true)
    }
    
    @IBAction func myProfileButtonTapped(sender: UIButton) {
        let meVM = UserViewModel.me()
        let profileVC = UserViewController.instance(viewModel: meVM)
        profileVC.title = "Me"
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
}
