//
//  UserViewController.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

class UserViewController : UIViewController {
    // MARK: Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!

    // MARK: - Properties
    
    var viewModel: UserViewModel! {
        didSet {
            update()
        }
    }
    
    // MARK: - Initialization
    
    static func instance(viewModel vm: UserViewModel) -> UserViewController {
        let vc = UIStoryboard.Scene.Main.profileViewController()
        vc.viewModel = vm
        return vc
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }
    
    func update() {
        guard isViewLoaded() else { return }
        nameLabel.text = viewModel.name
        addressLabel.text = viewModel.address.formatted
    }

    // MARK: - Actions
    
    @IBAction func showMap(sender: UIButton) {
        let vc = AddressViewController.instance(viewModel: viewModel.address)
        vc.title = viewModel.name
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
