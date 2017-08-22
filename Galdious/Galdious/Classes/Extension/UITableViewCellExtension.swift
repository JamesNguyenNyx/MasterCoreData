//
//  UITableViewCellExtension.swift
//  Galdious
//
//  Created by James Nguyen on 2017/08/15.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
