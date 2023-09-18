//
//  SearchResultViewModel.swift
//  MovieApp
//
//  Created by Altan on 18.09.2023.
//

import Foundation

class SearchResultViewModel {
    
    var query: String?
    var overview: String?
    var backdropPath: String?
    var previewViewModel: PreviewViewModel?
    
    var didUpdateData: (() -> Void)?
    
    func getYoutubeResult() {
        guard let query = query else { return }
        guard let overview = overview else { return }
        guard let backdropPath = backdropPath else { return }
        
        APICaller.shared.getVideoFromYoutube(with: query + " trailer") { [weak self] result in
            switch result {
            case .success(let youtubeModel):
                let viewModel = PreviewViewModel(title: query, youtubeVideo: youtubeModel, titleOverview: overview, backdrop_path: backdropPath)
                self?.previewViewModel = viewModel
                self?.didUpdateData?()
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
