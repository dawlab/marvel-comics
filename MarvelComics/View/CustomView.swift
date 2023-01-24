//
//  CustomView.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 24/01/2023.
//

import UIKit

class CustomView: UIView {
    
    
    @IBOutlet var contenView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
