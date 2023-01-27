//
//  SearchViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 23/01/2023.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController, UISearchResultsUpdating {
    
    let searchController = UISearchController(searchResultsController: ResultsViewController())
    let ResultsVC = ResultsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = (ResultsVC as? any UISearchResultsUpdating)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {

        
    }
}
