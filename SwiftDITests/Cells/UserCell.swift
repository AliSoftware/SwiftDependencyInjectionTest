//
//  UserCell.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

final class UserCell : UITableViewCell, BaseCell {
    func fillWithViewModel(viewModel: UserViewModel) {
        self.textLabel?.text = viewModel.name
        self.detailTextLabel?.text = viewModel.address.formatted
    }
}
