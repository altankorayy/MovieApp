//
//  NewAndPopularViewController.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit

class NewAndPopularViewController: UIViewController {
    
    private let newAndPopularTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NewAndPopularTableViewCell.self, forCellReuseIdentifier: NewAndPopularTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let viewModel = NewAndPopularViewModel()
    private var model = [MovieModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(newAndPopularTableView)
        
        configureNavigationBar()
        
        newAndPopularTableView.delegate = self
        newAndPopularTableView.dataSource = self
        
        viewModel.getLatestTV()
        viewModel.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        newAndPopularTableView.frame = view.bounds
    }
    
    private func configureNavigationBar() {
        let searchButton = UIBarButtonItem(image: UIImage(named: "explore"), style: .plain, target: self, action: #selector(didTapSearch))
        searchButton.tintColor = .label
        let airplayButton = UIBarButtonItem(image: UIImage(named: "airplay"), style: .plain, target: self, action: nil)
        airplayButton.tintColor = .label
        navigationItem.rightBarButtonItems = [searchButton, airplayButton]
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 22, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.text = "New and Popular"
        let labelBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = labelBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc private func didTapSearch() {
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(searchVC, animated: true)
    }

}

extension NewAndPopularViewController: UITableViewDelegate, UITableViewDataSource, LatestTVModelDelegate {
    func latestTVModel(_ model: [MovieModel]) {
        self.model = model
        
        DispatchQueue.main.async { [weak self] in
            self?.newAndPopularTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewAndPopularTableViewCell.identifier, for: indexPath) as? NewAndPopularTableViewCell else {
            return UITableViewCell()
        }
        
        let posterUrl = model[indexPath.row].backdrop_path ?? "nil"
        let title = model[indexPath.row].original_title ?? "nil"
        let overView = model[indexPath.row].overview ?? "nil"
        cell.configure(posterUrl: posterUrl, title: title, overView: overView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedModel = model[indexPath.row]
        guard let title = selectedModel.original_title ?? selectedModel.original_name else { return }
        guard let overView = selectedModel.overview else { return }
        guard let backdropPath = selectedModel.backdrop_path else { return }
        
        APICaller.shared.getVideoFromYoutube(with: title + " trailer") { [weak self] result in
            switch result {
            case .success(let youtubeResults):
                let viewModel = PreviewViewModel(title: title, youtubeVideo: youtubeResults, titleOverview: overView, backdrop_path: backdropPath)
                
                DispatchQueue.main.async {
                    let previewVC = PreviewViewController()
                    previewVC.configure(with: viewModel)
                    self?.navigationController?.pushViewController(previewVC, animated: true)
                }
                
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 375
    }
}
