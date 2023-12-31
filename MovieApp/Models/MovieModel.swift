//
//  MovieModel.swift
//  MovieApp
//
//  Created by Altan on 5.09.2023.
//

import Foundation

struct MovieModelResponse: Codable {
    let results: [MovieModel]
}

struct MovieModel: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let backdrop_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
