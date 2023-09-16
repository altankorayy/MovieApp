//
//  MyNetflixViewController.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit
import CoreData

class MyNetflixViewController: UIViewController {
    
    public let listTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var headerView: ListHeaderView?
    var movieItem = [MovieItem]()
    private let viewModel = MyNetflixViewModel()
    var deleteStatus: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(listTableView)
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        headerView = ListHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 100))
        listTableView.tableHeaderView = headerView
        
        configureNavigationBar()
        fetchDownloads()
        listenDownloadedTitles()
        
        viewModel.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        listTableView.frame = view.bounds
    }
    
    private func listenDownloadedTitles() {
        NotificationCenter.default.addObserver(forName: NSNotification.Name("titleDownloaded"), object: nil, queue: nil) { [weak self] _ in
            self?.fetchDownloads()
            self?.listTableView.reloadData()
        }
    }
    
    private func fetchDownloads() {
        viewModel.fetchDownloads()
        movieItem = viewModel.movieItem
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
        titleLabel.text = "My Netflix"
        let labelBarButton = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = labelBarButton
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    @objc private func didTapSearch() {
        let searchVC = SearchViewController()
        searchVC.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(searchVC, animated: true)
    }
    
    private func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }

}

extension MyNetflixViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.identifier, for: indexPath) as? ListTableViewCell else {
            return UITableViewCell()
        }
        let model = movieItem[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let model = movieItem[indexPath.row]
            viewModel.deleteMovieItem = model
            viewModel.deleteDownloads()
            
            guard let status = deleteStatus else { return }
            
            if status {
                movieItem.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } else {
                makeAlert(title: "Something went wrong", message: "Failed to delete.")
            }
        }
    }
}

extension MyNetflixViewController: DidDeleteFromDatabase {
    func didDelete(_ deleted: Bool) {
        deleteStatus = deleted
    }
}
