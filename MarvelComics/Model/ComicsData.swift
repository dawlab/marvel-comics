//
//  Comic.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 20/01/2023.
//

struct ComicsData: Decodable {
    let data: Data
}

struct Data: Decodable {
    let count: Int
    let results: [DataResult]
}

struct DataResult: Decodable {
    let title: String
    let creators: Creators
    let description: String?
    let thumbnail: Thumbnail
    let urls: [ComicUrl]
}

struct Creators: Decodable {
    let items: [Items]
    let returned: Int
}

struct Items: Decodable {
    let name: String?
}

struct Thumbnail: Decodable {
    let path: String
    let `extension`: String
}

struct ComicUrl: Decodable {
    let url: String
}
