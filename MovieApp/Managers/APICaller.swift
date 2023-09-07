//
//  APICaller.swift
//  MovieApp
//
//  Created by Altan on 5.09.2023.
//

import Foundation

struct Constanst {
    static let apiKey = "a3d5b6371229e178921fa1e4586699ab"
    static let baseURL = "https://api.themoviedb.org"
}

class APICaller {
    static let shared = APICaller()
    
    func getTrendingMovies(completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constanst.baseURL)/3/trending/movie/day?api_key=\(Constanst.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
                
            } catch {
                completion(.failure(ApiCallError.jsonDecodeError))
            }
        }
        task.resume()
    }
    
    func getTrendingTV(completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constanst.baseURL)/3/trending/tv/day?api_key=\(Constanst.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(ApiCallError.jsonDecodeError))
            }
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constanst.baseURL)/3/movie/popular?api_key=\(Constanst.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(ApiCallError.jsonDecodeError))
            }
        }
        task.resume()
    }
    
    func getUpcoming(completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constanst.baseURL)/3/movie/upcoming?api_key=\(Constanst.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
            } catch let error {
                print("JSON çözümleme hatası: \(error)")
                completion(.failure(ApiCallError.jsonDecodeError))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constanst.baseURL)/3/movie/top_rated?api_key=\(Constanst.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(ApiCallError.jsonDecodeError))
            }
        }
        task.resume()
    }
    
    func getLatestTV(completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let url = URL(string: "\(Constanst.baseURL)/3/movie/upcoming?api_key=\(Constanst.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                completion(.failure(ApiCallError.jsonDecodeError))
            }
        }
        task.resume()
    }
}

enum ApiCallError: Error {
    case dataTaskFailed
    case jsonDecodeError
}
