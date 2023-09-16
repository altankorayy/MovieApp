//
//  DataPersistanceManager.swift
//  MovieApp
//
//  Created by Altan on 15.09.2023.
//

import Foundation
import UIKit
import CoreData

class DataPersistanceManager {
    
    static let shared = DataPersistanceManager()
    
    func downloadMovie(model: PreviewViewModel, completion: @escaping(Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let item = MovieItem(context: context)
        
        item.backdrop_path = model.backdrop_path
        item.original_title = model.title
        item.original_name = model.title
        item.overview = model.titleOverview
        
        do {
            try context.save()
            completion(true)
        } catch {
            print("Error: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    func fetchMovieFromDatabase(completion: @escaping(Result<[MovieItem], Error>) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        let request: NSFetchRequest<MovieItem>
        request = MovieItem.fetchRequest()
        
        do {
           let movies = try context.fetch(request)
            completion(.success(movies))
        } catch {
            print("Error: \(error.localizedDescription)")
            completion(.failure(DatabaseError.failedToFetchData))
        }
    }
    
    func deleteFromDatabase(model: MovieItem, completion: @escaping(Bool) -> Void) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        
        context.delete(model)
        
        do {
            try context.save()
            completion(true)
        } catch {
            completion(false)
        }
    }
}

enum DatabaseError: Error {
    case failedToFetchData
}
