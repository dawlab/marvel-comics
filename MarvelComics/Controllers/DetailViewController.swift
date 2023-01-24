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
    
    
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicAuthors: UILabel!
    @IBOutlet weak var comicDesc: UILabel!
    
    var comic: ComicModel?
    
    var imgUrl: URL?
    var isActive = false
    var customView: CustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let comicPreview = comic {
            comicImageView.sd_setImage(with: comicPreview.imageUrl)
            comicTitle.text = comicPreview.title
            comicAuthors.text = comicPreview.authors
            comicDesc.text = comicPreview.description
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        smallDescView.addGestureRecognizer(tap)
        
        navigationItem.backBarButtonItem?.image = UIImage(systemName: "arrow.backward")
        navigationItem.backButtonDisplayMode = .minimal
        
        smallDescView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        smallDescView.layer.cornerRadius = 25
        grabber.layer.cornerRadius = 5
    }
    
    @objc func handleTap() {
        isActive = !isActive
        if isActive {
            smallDescView.removeFromSuperview()
            customView = CustomView()
            view.addSubview(customView!)
        } else {
            customView!.removeFromSuperview()
            view.addSubview(smallDescView)
        }
    }
}
