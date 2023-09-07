//
//  HomeViewController.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit

enum Sections: Int {
    case trendingMovies = 0
    case trendingTv = 1
    case popular = 2
    case upcomingMovies = 3
    case topRated = 4
}

class HomeViewController: UIViewController {
    
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let sectionTitles = ["Trendıng Movıes", "Trendıng TV", "Popular", "Upcomıng Movıes", "Top Rated"]
    private let viewModel = HomeViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        let headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeTableView.tableHeaderView = headerView
        
        configureNavigationBar()
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeTableView.frame = view.bounds
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
            firstLabel.text = "   For you"
            firstLabel.textColor = .label
            firstLabel.font = .systemFont(ofSize: 22, weight: .semibold)
            navigationBar.addSubview(firstLabel)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Configure Titles Attributes
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        header.textLabel?.textColor = .label
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            
            viewModel.getTrendingMovies()
            let model = viewModel.trendingMovies
            cell.configure(model: model)
            
        case Sections.trendingTv.rawValue:
            
            viewModel.getTrendingTV()
            let model = viewModel.trendingTV
            cell.configure(model: model)
            
        case Sections.popular.rawValue:
            
            viewModel.getPopular()
            let model = viewModel.popular
            cell.configure(model: model)
            
        case Sections.upcomingMovies.rawValue:
            
            viewModel.getUpcoming()
            let model = viewModel.upcoming
            cell.configure(model: model)
            
        case Sections.topRated.rawValue:
            
            viewModel.getTopRated()
            let model = viewModel.topRated
            cell.configure(model: model)
            
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    //For Section Titles
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
}
