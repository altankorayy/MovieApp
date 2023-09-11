//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Altan on 11.09.2023.
//

import Foundation

protocol TrendingTvModelDelegate: AnyObject {
    func getTrendingTV(_ model: [MovieModel])
}

class SearchViewModel {
    
    weak var delegate: TrendingTvModelDelegate?
    
    func getTrendingTV() {
        APICaller.shared.getTrendingTV { [weak self] result in
            switch result {
            case .success(let trendingModel):
                self?.delegate?.getTrendingTV(trendingModel)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
