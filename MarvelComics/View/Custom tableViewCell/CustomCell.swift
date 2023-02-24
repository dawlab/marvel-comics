//
//  ComicsTableViewCell.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 26/01/2023.
//

import UIKit

final class CustomCell: UITableViewCell {
    static let identifier = "CustomCell"
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellAuthors: UILabel!
    @IBOutlet weak var cellDesc: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
}
