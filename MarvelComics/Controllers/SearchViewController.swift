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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = (resultsController as! any UISearchResultsUpdating)
    }
}
