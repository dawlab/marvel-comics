//
//  ComicsManager.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 20/01/2023.
//

import Foundation
import UIKit

protocol ComicsManagerDelegate {
    func didUpdateList(_ comicsArray: [ComicModel])
}

struct ComicsManager {
    
    var delegate: ComicsManagerDelegate?
    
    func performRequest() {
        let urlString = "https://gateway.marvel.com/v1/public/comics?format=comic&formatType=comic&noVariants=true&ts=1&apikey=a918e5981c403ce82cea3d4209804351&hash=1882d3b7e252f80ccda13a75a0a428ed"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodedData = try decoder.decode(ComicsData.self, from: safeData)
                        let count = decodedData.data.count
                    
                        var comicsArray: [ComicModel] = []
                        
                        for i in 0..<count {
                            var comicAuthor = ""
                            var comicAuthors = ""
                            var authorsArray = [String]()
                            let comicTitle = decodedData.data.results[i].title
                            var comicDesc = decodedData.data.results[i].description
                            
                            let authorsCount = decodedData.data.results[i].creators.returned
                            
//                            One comic can have many authors thats why I use for loop
                            if authorsCount != 0 {
                                for n in 0..<authorsCount {
                                    comicAuthor = decodedData.data.results[i].creators.items[n].name ?? "No information"
                                    authorsArray.append(comicAuthor)
                                    }
                            } else {
                                comicAuthor = "No information"
                                authorsArray.append(comicAuthor)
                            }
//                            Make one string with authors names from an array
                            comicAuthors = authorsArray.joined(separator: ", ")
                            
                            if comicDesc == "" || comicDesc == nil || comicDesc == "#N/A" {
                                comicDesc = "No information"
                            }
                            
//                            Download comic's image thumbnail urlString
                            let comicThumbnail = decodedData.data.results[i].thumbnail.path
                            let comicThumbnailExt = decodedData.data.results[i].thumbnail.extension
                            let imageUrl = URL(string: "\(comicThumbnail).\(comicThumbnailExt)")
                            
                            let comic = ComicModel(title: comicTitle, description: comicDesc, authors: comicAuthors, imageUrl: (imageUrl ?? URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!))
                            
                            comicsArray.append(comic)
                        }
                        self.delegate?.didUpdateList(comicsArray)
                        print("delegate, let's do this")
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
