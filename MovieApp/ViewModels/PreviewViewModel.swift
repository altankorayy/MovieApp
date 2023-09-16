//
//  PreviewViewModel.swift
//  MovieApp
//
//  Created by Altan on 13.09.2023.
//

import Foundation

protocol PassDatabaseError: AnyObject {
    func databaseError(_ error: Bool)
}

struct PreviewViewModel {
    let title: String
    let youtubeVideo: YoutubeModelResults
    let titleOverview: String
    let backdrop_path: String
}

class PreviewViewControllerModel {
    
    var previewViewModel: PreviewViewModel?
    weak var delegate: PassDatabaseError?
    
    func downloadTitles() {
        guard let model = previewViewModel else { return }
        
        DataPersistanceManager.shared.downloadMovie(model: model) { [weak self] success in
            if success {
                NotificationCenter.default.post(name: NSNotification.Name("titleDownloaded"), object: nil)
                self?.delegate?.databaseError(true)
            } else {
                self?.delegate?.databaseError(false)
            }
        }
    }
}
