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
        let searchButton = UIBarButtonItem(image: UIImage(named: "explore"), style: .plain, target: self, action: nil)
        searchButton.tintColor = .label
        let airplayButton = UIBarButtonItem(image: UIImage(named: "airplay"), style: .plain, target: self, action: nil)
        airplayButton.tintColor = .label
        navigationItem.rightBarButtonItems = [searchButton, airplayButton]
        
        if let navigationBar = navigationController?.navigationBar {
            let firstFrame = CGRect(x: 0, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            let firstLabel = UILabel(frame: firstFrame)
            firstLabel.text = "  New and Popular"
            firstLabel.font = .systemFont(ofSize: 22, weight: .semibold)
            firstLabel.textColor = .label
            navigationBar.addSubview(firstLabel)
        }
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
        
        let posterUrl = model[indexPath.row].poster_path ?? "nil"
        let title = model[indexPath.row].original_title ?? "nil"
        let overView = model[indexPath.row].overview ?? "nil"
        cell.configure(posterUrl: posterUrl, title: title, overView: overView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
