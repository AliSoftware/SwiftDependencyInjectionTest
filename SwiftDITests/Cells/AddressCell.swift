//
//  AddressCell.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

final class AddressCell : UITableViewCell, BaseCell {
    func fillWithViewModel(viewModel: AddressViewModel) {
        self.textLabel?.text = viewModel.city
        self.detailTextLabel?.text = viewModel.country
    }
}
