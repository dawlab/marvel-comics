//
//  ResultsViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 26/01/2023.
//

import UIKit

protocol ResultsDelegate {
    func passInformation(basedOn selectedItem: ComicModel)
}

class ResultsViewController: UIViewController {
    @IBOutlet weak var searchTableView: UITableView!
    var comicsManager = comicManagerInstance
    var comicsData: [ComicModel] = []
    var filteredData: [ComicModel] = []
    var delegate: ResultsDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsManager.registerDelegate(delegate: self)
        comicsManager.loadData()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(CustomCell.self)
    }
}
//MARK: - UITableViewDataSource
extension ResultsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        filteredData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: CustomCell = tableView.dequeue(cellForRowAt: indexPath)
        else {
            return UITableViewCell()
        }
//        cell.cellImageView.sd_setImage(with: filteredData[indexPath.section].imageUrl, completed: nil)
        cell.cellImageView.layer.cornerRadius = 9
        cell.cellImageView.clipsToBounds = true
//        cell.cellImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

        cell.cellTitle.text = filteredData[indexPath.section].title
        cell.cellAuthors.text = filteredData[indexPath.section].authors
        cell.cellDesc.text = filteredData[indexPath.section].description
        return cell
    }
}
//MARK: - UITableViewDelegate
extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = filteredData[indexPath.section]
        delegate?.passInformation(basedOn: selectedItem)
    }
}
//MARK: - UISearchResultsUpdating
extension ResultsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else {
            return
        }
        
        filteredData = comicsData.compactMap {
            $0.title.uppercased().contains(searchText.uppercased())
            ? $0
            : nil
        }
        searchTableView.reloadData()
    }
}
//MARK: - ComicsManagerDelegate
extension ResultsViewController: ComicsManagerDelegate {
    func didUpdateList(_ comicsArray: [ComicModel]) {
        self.comicsData = comicsArray
    }
}
