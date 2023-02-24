//
//  CustomView.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 24/01/2023.
//

import UIKit

class CustomView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var grabber: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var authors: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aCoder: NSCoder) {
        super.init(coder: aCoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CustomView", owner: self)
        addSubview(contentView)
        
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 25
        grabber.layer.cornerRadius = 5
    }
    
    func sendToCustomView(comic: ComicModel?) {
        if let comicDetails = comic {
            title.text = comicDetails.title
            authors.text = comicDetails.authors
            desc.text = comicDetails.description
        }
    }
}
