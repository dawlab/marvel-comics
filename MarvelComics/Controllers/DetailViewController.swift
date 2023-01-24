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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
