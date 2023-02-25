//
//  DetailViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 24/01/2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var smallDescView: UIView!
    @IBOutlet weak var grabber: UIView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicAuthors: UILabel!
    @IBOutlet weak var comicDesc: UILabel!
    @IBOutlet weak var findOutMoreButton: UIButton!
    
    @IBOutlet weak var customView: CustomView!
    
    var comic: ComicModel?
    
    var imgUrl: URL?
    var isActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.isHidden = true
        
        showData()
        AddGestureRecognizers()
        prepareSmallDescView()
    }
    
    func prepareSmallDescView() {
        smallDescView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        smallDescView.layer.cornerRadius = 25
        grabber.layer.cornerRadius = 5
    }
    
    func showData() {
        if let comicPreview = comic {
            // Small view data
            comicImageView.sd_setImage(with: comicPreview.imageUrl)
            comicTitle.text = comicPreview.title
            comicAuthors.text = comicPreview.authors
            comicDesc.text = comicPreview.description
            //Full view data
            customView.title.text = comicPreview.title
            customView.authors.text = comicPreview.authors
            customView.desc.text = comicPreview.description
        }
    }
    
    func AddGestureRecognizers() {
        // Add tap gesture recognizer
        let smallDescViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        let customViewTap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        smallDescView.addGestureRecognizer(smallDescViewTap)
        smallDescView.isUserInteractionEnabled = true
        customView.addGestureRecognizer(customViewTap)
        customView.isUserInteractionEnabled = true
        
        // Add swipe up gesture recognizer
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeUp))
        swipeUp.direction = .up
        smallDescView.addGestureRecognizer(swipeUp)
        
        // Add swipe down gesture recognizer
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeDown))
        swipeDown.direction = .down
        customView.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleTap() {
        isActive = !isActive
        if isActive {
            smallDescView.isHidden = true
            customView.isHidden = false
        } else {
            customView.isHidden = true
            smallDescView.isHidden = false
        }
    }
    
    @objc func handleSwipeUp(_ sender: UISwipeGestureRecognizer) {
        smallDescView.isHidden = true
        customView.isHidden = false
    }
    
    @objc func handleSwipeDown(_ sender: UISwipeGestureRecognizer) {
        customView.isHidden = true
        smallDescView.isHidden = false
    }
    
    @IBAction func ClickFindOutMoreButton(_ sender: Any) {
        if let url = comic?.url  {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}
