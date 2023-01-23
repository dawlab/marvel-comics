//
//  Comic.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 20/01/2023.
//

struct ComicsData: Decodable {
    var data: Data
}

struct Data: Decodable {
    var count: Int
    var results: [Results]
}

struct Results: Decodable {
    var title: String
    var creators: Creators
    var description: String?
    var thumbnail: Thumbnail
}

struct Creators: Decodable {
    var items: [Items]
    var returned: Int
}

struct Items: Decodable {
    var name: String?
}

struct Thumbnail: Decodable {
    var path: String
    var `extension`: String
}
