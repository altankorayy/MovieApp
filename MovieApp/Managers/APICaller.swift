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
    static let youtubeApiKey = "AIzaSyCMmSfyrVUANJZEcHYm-UT1A8m9HCbSenY"
    static let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum ApiCallError: Error {
    case dataTaskFailed
    case jsonDecodeError
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
    
    func search(with query: String, completion: @escaping(Result<[MovieModel], Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constanst.baseURL)/3/search/tv?api_key=\(Constanst.apiKey)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard error == nil, let data = data else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(MovieModelResponse.self, from: data)
                completion(.success(result.results))
            } catch {
                
            }
        }
        task.resume()
    }
    
    func getVideoFromYoutube(with query: String, completion: @escaping(Result<YoutubeModelResults, Error>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(Constanst.youtubeBaseURL)q=\(query)&key=\(Constanst.youtubeApiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(ApiCallError.dataTaskFailed))
                return
            }
            
            do {
                let results = try JSONDecoder().decode(YoutubeModel.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}

