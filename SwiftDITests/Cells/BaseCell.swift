//
//  BaseCell.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

protocol BaseCell {
    static var identifier: String { get }
    static var nib: UINib? { get }
    
    static func register(tableView: UITableView)
    static func dequeue(tableView: UITableView, forIndexPath indexPath: NSIndexPath) -> Self
}

extension BaseCell where Self : UITableViewCell {
    static var identifier: String {
        return "\(Self.self)"
    }
    static var nib: UINib? { return nil }
    
    static func register(tableView: UITableView) {
        if let cellNib = self.nib {
            tableView.registerNib(cellNib, forCellReuseIdentifier: identifier)
        } else {
            tableView.registerClass(Self.self as AnyClass, forCellReuseIdentifier: identifier)
        }
    }
    
    static func dequeue(tableView: UITableView, forIndexPath indexPath: NSIndexPath) -> Self {
        return tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! Self
    }
}