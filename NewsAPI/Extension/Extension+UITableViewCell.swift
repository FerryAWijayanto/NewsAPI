//
//  Extension+UITableViewCell.swift
//  NewsAPI
//
//  Created by Ferry Adi Wijayanto on 02/02/22.
//

import UIKit.UITableViewCell

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
