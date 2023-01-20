//
//  Comic.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 20/01/2023.
//

struct ComicsData: Decodable {
    let status: String
    let data: Data
}

struct Data: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let id: Int
    let title: String
    let variantDescription: String
    let description: String
    let resourceUrl: String
    let thumbnail: [Thumbnail]
}

struct Thumbnail: Decodable {
    let path: String
    let thumbExt: String
}
