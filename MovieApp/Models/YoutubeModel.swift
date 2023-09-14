//
//  YoutubeModel.swift
//  MovieApp
//
//  Created by Altan on 13.09.2023.
//

import Foundation

struct YoutubeModel: Codable {
    let items: [YoutubeModelResults]
}

struct YoutubeModelResults: Codable {
    let id: VideoIdElement
}

struct VideoIdElement: Codable {
    let kind: String
    let videoId: String
}
