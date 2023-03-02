//
//  ListViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 17/01/2023.
//

import UIKit
import SDWebImage
import MBProgressHUD

class ListViewController: UIViewController {
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
        tableView.register(CustomCell.self)
        showLoadingHUD()
        
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

//MARK: - MBProgressHUD functions

extension ListViewController {
    private func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }

    private func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return comics.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCell = tableView.dequeue(cellForRowAt: indexPath)
        else {
            return UITableViewCell()
        }
        cell.cellImageView.sd_setImage(with: comics[indexPath.section].imageUrl)
        cell.cellImageView.layer.cornerRadius = 9
        cell.cellImageView.clipsToBounds = true
//        cell.cellImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        cell.cellTitle.text = comics[indexPath.section].title
        cell.cellAuthors.text = comics[indexPath.section].authors
        cell.cellDesc.text = comics[indexPath.section].description
        
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = comics[indexPath.section]
        self.performSegue(withIdentifier: "showDetails", sender: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - ComicsManagerDelegate

extension ListViewController: ComicsManagerDelegate {
    func didUpdateList(_ comicsArray: [ComicModel]) {
        self.comics = comicsArray
        self.tableView.reloadData()
        hideLoadingHUD()
    }
}

