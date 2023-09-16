//
//  NewAndPopularViewModel.swift
//  MovieApp
//
//  Created by Altan on 7.09.2023.
//

import Foundation

protocol LatestTVModelDelegate: AnyObject {
    func latestTVModel(_ model: [MovieModel])
}

class NewAndPopularViewModel {
    
    weak var delegate: LatestTVModelDelegate?
    
    func getLatestTV() {
        APICaller.shared.getLatestTV { [weak self] result in
            switch result {
            case .success(let latest):
                self?.delegate?.latestTVModel(latest)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
