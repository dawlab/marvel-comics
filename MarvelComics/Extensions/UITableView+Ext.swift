//
//  UITableView+Ext.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 02/03/2023.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(cellForRowAt indexPath: IndexPath) -> T? {
        dequeueReusableCell(withIdentifier: "\(T.self)",
                            for: indexPath) as? T
    }
    
    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }
}
