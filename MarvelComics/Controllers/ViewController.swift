//
//  ViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 17/01/2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    var comicsManager = comicManagerInstance
    
    @IBOutlet weak var tableView: UITableView!
    
    var titleLabel: String?
    var itemsCounter: Int?
    var comics: [ComicModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsManager.registerDelegate(delegate: self)
        comicsManager.loadData()
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: CustomCell.identifier)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        let image = UIImage(named: "arrow.backward")
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.comic = (sender as! ComicModel)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.cellImageView.sd_setImage(with: comics[indexPath.section].imageUrl, completed: nil)
        cell.cellImageView.layer.cornerRadius = 9
        cell.cellImageView.clipsToBounds = true
        cell.cellImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        cell.cellTitle.text = comics[indexPath.section].title
        cell.cellAuthors.text = comics[indexPath.section].authors
        cell.cellDesc.text = comics[indexPath.section].description
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = comics[indexPath.section]
        self.performSegue(withIdentifier: "showDetails", sender: selectedItem)
    }
}

//MARK: - ComicsManagerDelegate

extension ViewController: ComicsManagerDelegate {
    func didUpdateList(_ comicsArray: [ComicModel]) {
        self.comics = comicsArray
        self.tableView.reloadData()
    }
}

