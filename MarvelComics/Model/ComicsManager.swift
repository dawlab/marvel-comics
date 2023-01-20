//
//  ComicsManager.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 20/01/2023.
//

import Foundation

struct ComicsManager {
    
    func fetchComics() {
        let urlString = "http://gateway.marvel.com/v1/public/comics?ts=1&apikey=a918e5981c403ce82cea3d4209804351&hash=1882d3b7e252f80ccda13a75a0a428ed"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        //Create URL
        if let url = URL(string: urlString) {
            //Create a URLSession
            let session = URLSession(configuration: .default)
            //Give the session a task
            let task = session.dataTask(with: url, completionHandler: {
                data, response, error in
                if error != nil {
                    print("There is an error \(error?.localizedDescription)")
                    return
                } else {
                    if let safeData = data {
                        self.parseJSON(ComicsData: safeData)
                    }
                }
            })
            //Start the task
            task.resume()
        }
    }
    
    func parseJSON(comicsData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(ComicsData.self, from: comicsData)
            
            print(decodedData.status)

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}
