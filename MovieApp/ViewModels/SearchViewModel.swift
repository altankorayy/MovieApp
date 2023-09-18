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
    
    var query: String?
    var overview: String?
    var backdropPath: String?
    var previewViewModel: PreviewViewModel?
    var movieModel = [MovieModel]()
    
    var didUpdateData: (() -> Void)?
    
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
    
    func getYoutubeResult() {
        guard let query = query else { return }
        guard let overview = overview else { return }
        guard let backdropPath = backdropPath else { return }
        
        APICaller.shared.getVideoFromYoutube(with: query + " trailer") { [weak self] result in
            switch result {
            case .success(let youtubeResult):
                let viewModel = PreviewViewModel(title: query, youtubeVideo: youtubeResult, titleOverview: overview, backdrop_path: backdropPath)
                self?.previewViewModel = viewModel
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func searchForMovie() {
        guard let query = query else { return }
        
        APICaller.shared.search(with: query) { [weak self] result in
            switch result {
            case .success(let movieModel):
                self?.movieModel = movieModel
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
