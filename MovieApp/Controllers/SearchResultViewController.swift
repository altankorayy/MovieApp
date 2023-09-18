//
//  SearchResultViewController.swift
//  MovieApp
//
//  Created by Altan on 12.09.2023.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    public let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var searchModel = [MovieModel]()
    private let viewModel = SearchResultViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(searchResultTableView)
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        searchResultTableView.frame = view.bounds
    }

}

extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(model: searchModel[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedModel = searchModel[indexPath.row]
        guard let title = selectedModel.original_name ?? selectedModel.original_title else { return }
        guard let overView = selectedModel.overview else { return }
        guard let backdropPath = selectedModel.backdrop_path else { return }
        
        viewModel.query = title
        viewModel.overview = overView
        viewModel.backdropPath = backdropPath
        
        viewModel.getYoutubeResult()
        
        viewModel.didUpdateData = { [weak self] in
            DispatchQueue.main.async { [weak self] in
                let previewVC = PreviewViewController()
                guard let viewModel = self?.viewModel.previewViewModel else { return }
                previewVC.configure(with: viewModel)
                self?.present(previewVC, animated: true)
            }
        }
    }
}
