//
//  ResultsViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 26/01/2023.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    var comicManager = ComicsManager()
    var comicsData: [ComicModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        comicManager.delegate = self
        comicManager.performRequest()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: CustomCell.identifier)
    }
}

extension ResultsViewController: ComicsManagerDelegate {
    func didUpdateList(_ comicsArray: [ComicModel]) {
        DispatchQueue.main.async {
            self.comicsData = comicsArray
            self.searchTableView.reloadData()
        }
    }
}

//MARK: - UITableViewDataSource

extension ResultsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier, for: indexPath) as? CustomCell else {
            return UITableViewCell()
        }
        cell.cellImageView.sd_setImage(with: comicsData[indexPath.section].imageUrl, completed: nil)
        cell.cellImageView.layer.cornerRadius = 9
        cell.cellImageView.clipsToBounds = true
        cell.cellImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]

        cell.cellTitle.text = comicsData[indexPath.section].title
        cell.cellAuthors.text = comicsData[indexPath.section].authors
        cell.cellDesc.text = comicsData[indexPath.section].description
        return cell
    }
}

//MARK: - UITableViewDelegate

extension ResultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = comicsData[indexPath.section]
        self.performSegue(withIdentifier: "showDetails", sender: selectedItem)
    }
}
