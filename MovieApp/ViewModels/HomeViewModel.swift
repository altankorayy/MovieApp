//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Altan on 7.09.2023.
//

import Foundation

class HomeViewModel {
    
    var trendingMovies = [MovieModel]()
    var trendingTV = [MovieModel]()
    var popular = [MovieModel]()
    var upcoming = [MovieModel]()
    var topRated = [MovieModel]()
    
    func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.trendingMovies = movies
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendingTV() {
        APICaller.shared.getTrendingTV { [weak self] result in
            switch result {
            case .success(let tvs):
                self?.trendingTV = tvs
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getPopular() {
        APICaller.shared.getPopular { [weak self] result in
            switch result {
            case .success(let popular):
                self?.popular = popular
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getUpcoming() {
        APICaller.shared.getUpcoming { [weak self] result in
            switch result {
            case .success(let upcoming):
                self?.upcoming = upcoming
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopRated() {
        APICaller.shared.getTopRated { [weak self] result in
            switch result {
            case .success(let topRated):
                self?.topRated = topRated
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
