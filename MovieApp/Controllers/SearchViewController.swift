//
//  SearchViewController.swift
//  MovieApp
//
//  Created by Altan on 9.09.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: SearchResultViewController())
        searchController.searchBar.placeholder = "Search movie or tv series."
        searchController.searchBar.isHidden = false
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()
    
    private let viewModel = SearchViewModel()
    var movieModel = [MovieModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchTableView)
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        viewModel.getTrendingTV()
        viewModel.delegate = self
        
        configureNavigationBar()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchTableView.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.tintColor = .label
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.titleView = searchController.searchBar
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource, TrendingTvModelDelegate {
    func getTrendingTV(_ model: [MovieModel]) {
        self.movieModel = model
        DispatchQueue.main.async {
            self.searchTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: movieModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let query = searchController.searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let searchControllerVC = searchController.searchResultsController as? SearchResultViewController else { return }
        
        APICaller.shared.search(with: query) { result in
            switch result {
            case .success(let searchResult):
                searchControllerVC.searchModel = searchResult
                
                DispatchQueue.main.async {
                    searchControllerVC.searchResultTableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
