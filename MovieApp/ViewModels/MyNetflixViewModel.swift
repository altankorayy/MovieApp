//
//  MyNetflixViewModel.swift
//  MovieApp
//
//  Created by Altan on 16.09.2023.
//

import Foundation

protocol DidDeleteFromDatabase: AnyObject {
    func didDelete(_ deleted: Bool)
}

class MyNetflixViewModel {
    
    var movieItem = [MovieItem]()
    var deleteMovieItem: MovieItem?
    weak var delegate: DidDeleteFromDatabase?
    
    func fetchDownloads() {
        DataPersistanceManager.shared.fetchMovieFromDatabase { [weak self] result in
            switch result {
            case .success(let item):
                self?.movieItem = item
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteDownloads() {
        guard let model = deleteMovieItem else { return }
        DataPersistanceManager.shared.deleteFromDatabase(model: model) { [weak self] completed in
            if completed {
                self?.delegate?.didDelete(true)
            } else {
                self?.delegate?.didDelete(false)
            }
        }
    }
}
