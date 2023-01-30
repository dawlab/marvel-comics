//
//  SearchViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 23/01/2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    private lazy var mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    lazy var resultsController = mainStoryboard.instantiateViewController(withIdentifier: "ResultsViewController")
    lazy var searchController = UISearchController(searchResultsController: resultsController)
    
    var comic: ComicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let resultsVC = ResultsViewController()
        resultsVC.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = (resultsController as! any UISearchResultsUpdating)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchDetails" {
            if let destinationVC = segue.destination as? DetailViewController {
                destinationVC.hidesBottomBarWhenPushed = true
                destinationVC.comic = (sender as! ComicModel)
            }
        }
    }
}

extension SearchViewController: ResultsDelegate {
    func passInformation(basedOn selectedItem: ComicModel) {
        self.comic = selectedItem
        self.performSegue(withIdentifier: "searchDetails", sender: selectedItem)

    }
}
