//
//  ViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 17/01/2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    var comicsManager = ComicsManager()
    @IBOutlet weak var tableView: UITableView!
    
    var titleLabel: String?
    var itemsCounter: Int?
    var comics: [ComicModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsManager.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        comicsManager.performRequest()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.imgUrl = (sender as! URL)
        }
    }
}

//MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell") as! ComicsTableViewCell
        cell.cellImageView.sd_setImage(with: comics[indexPath.section].imageUrl, completed: nil)
        cell.cellTitle.text = comics[indexPath.section].title
        cell.cellAuthor.text = comics[indexPath.section].authors
        cell.cellDescription.text = comics[indexPath.section].description
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = comics[indexPath.section].imageUrl
        self.performSegue(withIdentifier: "showDetails", sender: selectedItem)
    }
}

//MARK: - ComicsManagerDelegate

extension ViewController: ComicsManagerDelegate {
    func didUpdateList(_ comicsArray: [ComicModel]) {
        DispatchQueue.main.async {
            self.comics = comicsArray
            self.tableView.reloadData()
        }
    }
}

//MARK: - ComicsTableViewCell

class ComicsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellAuthor: UILabel!
    @IBOutlet weak var cellDescription: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImageView.layer.cornerRadius = 9
        cellImageView.clipsToBounds = true
        cellImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
}

