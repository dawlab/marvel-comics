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
    
    var imgUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicImageView.sd_setImage(with: imgUrl)

    }
}
