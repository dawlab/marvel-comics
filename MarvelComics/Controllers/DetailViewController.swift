//
//  DetailViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 24/01/2023.
//

import UIKit
import SDWebImage
import FloatingPanel

class DetailViewController: UIViewController {

    @IBOutlet weak var comicImageView: UIImageView!
    
    @IBOutlet weak var smallDescView: UIView!
    
    @IBOutlet weak var grabber: UIView!
    
    var imgUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicImageView.sd_setImage(with: imgUrl)
        
        navigationItem.backBarButtonItem?.image = UIImage(systemName: "arrow.backward")
        navigationItem.backButtonDisplayMode = .minimal
        
        smallDescView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        smallDescView.layer.cornerRadius = 25
        grabber.layer.cornerRadius = 5
    }
}
