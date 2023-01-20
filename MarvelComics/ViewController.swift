//
//  ViewController.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 17/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var comicsManager = ComicsManager()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        comicsManager.fetchComics()
    }
    
//    func getPosts() {
//        let urlString = "http://gateway.marvel.com/v1/public/comics?ts=1&apikey=a918e5981c403ce82cea3d4209804351&hash=1882d3b7e252f80ccda13a75a0a428ed"
//        guard let url = URL(string: urlString) else {
//            print("This is an invalid URL")
//            return
//        }
//        let session = URLSession.shared.dataTask(with: url) {
//            data, response, error in
//            if let error = error {
//                print("There was an error \(error.localizedDescription)")
//            } else {
////                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
////                print("The response: \(jsonRes)")
//                let comic = try? JSONDecoder().decode(ComicsData.self, from: data!)
//                print("Output: \(comic?.status)")
//            }
//        }.resume()
//    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicsTableViewCell") as! ComicsTableViewCell
        cell.cellImageView.image = #imageLiteral(resourceName: "bd22b7c5b6d96d2fd75f65122139df07--marvel-comic-books-marvel-comics.jpg")
        cell.cellTitle.text = "Avengers #39"
        cell.cellAuthor.text = "Written by Jason Aaron"
        cell.cellDescription.text = "ENTER THE PHOENIX PROLOGUE! In the harsh, primordial world of One Million B.C.E, early humans who are different are left in the Burnt Place to die."
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected cell")
    }
}

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

