//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Altan on 7.09.2023.
//

import Foundation

protocol HeaderModelProtocol: AnyObject {
    func headerModel(_ model: [MovieModel])
}

class HomeViewModel {
    
    var trendingMoviesModel = [MovieModel]()
    var trendingTVsModel = [MovieModel]()
    var popularModel = [MovieModel]()
    var upcomingModel = [MovieModel]()
    var topRatedModel = [MovieModel]()
    
    var didUpdateData: (() -> Void)?
    
    weak var delegate: HeaderModelProtocol?
    
    func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.trendingMoviesModel = movies
                self?.delegate?.headerModel(movies)
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendingTV() {
        APICaller.shared.getTrendingTV { [weak self] result in
            switch result {
            case .success(let tvs):
                self?.trendingTVsModel = tvs
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getPopular() {
        APICaller.shared.getPopular { [weak self] result in
            switch result {
            case .success(let popular):
                self?.popularModel = popular
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getUpcoming() {
        APICaller.shared.getUpcoming { [weak self] result in
            switch result {
            case .success(let upcoming):
                self?.upcomingModel = upcoming
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopRated() {
        APICaller.shared.getTopRated { [weak self] result in
            switch result {
            case .success(let topRated):
                self?.topRatedModel = topRated
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
