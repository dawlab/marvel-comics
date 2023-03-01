//
//  ComicsManager.swift
//  MarvelComics
//
//  Created by Dawid Łabno on 20/01/2023.
//

import Foundation
import Alamofire

protocol ComicsManagerDelegate: AnyObject {
    func didUpdateList(_ comicsArray: [ComicModel])
}

class WeakComicsManagerDelegate {
    weak var delegate: ComicsManagerDelegate?
    
    init(delegate: ComicsManagerDelegate?) {
        self.delegate = delegate
    }
}

class ComicsManager {
    private var delegates: [WeakComicsManagerDelegate] = []
    
    private var comicsModels: [ComicModel] = [] {
        didSet {
            emitLoad()
        }
    }
    
    private let networkService: NetworkService
    private let comicsMapper: ComicsMapper
    
    init(
        networkService: NetworkService,
        comicsMapper: ComicsMapper
    ) {
        self.networkService = networkService
        self.comicsMapper = comicsMapper
    }
    
    func registerDelegate(delegate: ComicsManagerDelegate) {
        delegates.append(WeakComicsManagerDelegate(delegate: delegate))
    }
    
    func loadData() {
        guard comicsModels.isEmpty else {
            emitLoad()
            return
        }
        
        guard let url = URL(string: "https://gateway.marvel.com/v1/public/comics?format=comic&formatType=comic&noVariants=true&ts=1&apikey=a918e5981c403ce82cea3d4209804351&hash=1882d3b7e252f80ccda13a75a0a428ed") else { return }
        
        networkService.loadData(from: url) { [weak self] (result: Result<ComicsData, Error>) in
            switch result {
            case .success(let decodedData):
                self?.comicsModels = self?.comicsMapper.map(decodedData) ?? []
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func emitLoad() {
        DispatchQueue.main.async {
            self.delegates.forEach { $0.delegate?.didUpdateList(self.comicsModels) }
        }
    }
}

struct NetworkService {
    func loadData<T: Decodable>(
        from url: URL,
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        AF.request(url).validate().responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let decodedData):
                completion(.success(decodedData))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct ComicsMapper {
    func map(_ comicsData: ComicsData) -> [ComicModel] {
        let count = comicsData.data.count
        
        return Array(0..<count).map { index in
            buildComicModel(basedOn: comicsData.data.results[index])
        }
    }
    
    private func buildComicModel(basedOn dataResult: DataResult) -> ComicModel {
        ComicModel(title: dataResult.title,
                   description: buildDescription(basedOn: dataResult),
                   authors: buildAuthors(basedOn: dataResult),
                   imageUrl: buildImageUrl(basedOn: dataResult),
                   url: buildComicUrl(basedOn: dataResult)
        )
    }
    
    private func buildDescription(basedOn dataResult: DataResult) -> String? {
        let comicDesc = dataResult.description
        
        if comicDesc == "" || comicDesc == nil || comicDesc == "#N/A" {
            return "No information"
        } else {
            return comicDesc
        }
    }
    
    private func buildAuthors(basedOn dataResult: DataResult) -> String {
        var comicAuthor = ""
        var authorsArray = [String]()
        
        let authorsCount = dataResult.creators.returned
        // One comic can have many authors thats why I use for loop
        if authorsCount != 0 {
            for n in 0..<authorsCount {
                comicAuthor = dataResult.creators.items[n].name ?? "No information"
                authorsArray.append(comicAuthor)
            }
        } else {
            authorsArray.append("No information")
        }
        
        // Make one string with authors names from an array
        return authorsArray.joined(separator: ", ")
    }
    
    private func buildImageUrl(basedOn dataResult: DataResult) -> URL {
        let comicThumbnail = dataResult.thumbnail.path
        let comicThumbnailExt = dataResult.thumbnail.extension
        return  URL(string: "\(comicThumbnail).\(comicThumbnailExt)") ?? URL(string: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")!
    }
    
    private func buildComicUrl(basedOn dataResult: DataResult) -> URL {
        let comicUrl = dataResult.urls[0].url
        return  URL(string: comicUrl) ?? URL(string: "https://marvel.com")!
    }
}
