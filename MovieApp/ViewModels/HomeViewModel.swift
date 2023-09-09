//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Altan on 7.09.2023.
//

import Foundation

protocol TrendingMoviesDelegate: AnyObject {
    func trendingMoviesModel(_ model: [MovieModel])
}

protocol TrendingTVDelegate: AnyObject {
    func trendingTVModel(_ model: [MovieModel])
}

protocol PopularDelegate: AnyObject {
    func popularModel(_ model: [MovieModel])
}

protocol UpcomingDelegate: AnyObject {
    func upcomingModel(_ model: [MovieModel])
}

protocol TopRatedDelegate: AnyObject {
    func topRatedModel(_ model: [MovieModel])
}

protocol RandomTrendingMovie: AnyObject {
    func randomTrendingMovieDelegate(_ model: [MovieModel])
}

class HomeViewModel {
    
    weak var trendingMoviesDelegate: TrendingMoviesDelegate?
    weak var trendingTVDelegate: TrendingTVDelegate?
    weak var popularDelegate: PopularDelegate?
    weak var upcomingDelegate: UpcomingDelegate?
    weak var topRatedDelegate: TopRatedDelegate?
    weak var randomTrendingMovieDelegate: RandomTrendingMovie?
    
    func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.trendingMoviesDelegate?.trendingMoviesModel(movies)
                self?.randomTrendingMovieDelegate?.randomTrendingMovieDelegate(movies)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTrendingTV() {
        APICaller.shared.getTrendingTV { [weak self] result in
            switch result {
            case .success(let tvs):
                self?.trendingTVDelegate?.trendingTVModel(tvs)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getPopular() {
        APICaller.shared.getPopular { [weak self] result in
            switch result {
            case .success(let popular):
                self?.popularDelegate?.popularModel(popular)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getUpcoming() {
        APICaller.shared.getUpcoming { [weak self] result in
            switch result {
            case .success(let upcoming):
                self?.upcomingDelegate?.upcomingModel(upcoming)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func getTopRated() {
        APICaller.shared.getTopRated { [weak self] result in
            switch result {
            case .success(let topRated):
                self?.topRatedDelegate?.topRatedModel(topRated)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
