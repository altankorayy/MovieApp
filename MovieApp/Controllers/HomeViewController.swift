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

class HomeViewController: UIViewController, RandomTrendingMovie {
    
    private let homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        return tableView
    }()
    
    let sectionTitles = ["Trendıng Movıes", "Trendıng TV", "Popular", "Upcomıng Movıes", "Top Rated"]
    private let viewModel = HomeViewModel()
    
    private var trendingMovieModel = [MovieModel]()
    private var trendingTVModel = [MovieModel]()
    private var popularModel = [MovieModel]()
    private var upcomingModel = [MovieModel]()
    private var topRatedModel = [MovieModel]()
    var heroModel: MovieModel?
    var headerView: HeaderView?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeTableView)
        
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
        configureNavigationBar()
        
        viewModel.getTrendingMovies()
        viewModel.getTrendingTV()
        viewModel.getPopular()
        viewModel.getUpcoming()
        viewModel.getTopRated()
        
        viewModel.trendingMoviesDelegate = self
        viewModel.trendingTVDelegate = self
        viewModel.popularDelegate = self
        viewModel.upcomingDelegate = self
        viewModel.topRatedDelegate = self
        viewModel.randomTrendingMovieDelegate = self
        
        headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeTableView.tableHeaderView = headerView
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeTableView.frame = view.bounds
    }
    
    func randomTrendingMovieDelegate(_ model: [MovieModel]) {
        let randomTrendingMovieModel = model.randomElement()
        headerView?.configure(model: HeaderModel(titleName: randomTrendingMovieModel?.original_title ?? "nil", posterUrl: randomTrendingMovieModel?.poster_path ?? "nil"))
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
        titleLabel.text = "For You"
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, TrendingMoviesDelegate, TrendingTVDelegate, PopularDelegate, UpcomingDelegate, TopRatedDelegate {
    
    func trendingMoviesModel(_ model: [MovieModel]) {
        self.trendingMovieModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.homeTableView.reloadData()
        }
    }
    
    func trendingTVModel(_ model: [MovieModel]) {
        self.trendingTVModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.homeTableView.reloadData()
        }
    }
    
    func popularModel(_ model: [MovieModel]) {
        self.popularModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.homeTableView.reloadData()
        }
    }
    
    func upcomingModel(_ model: [MovieModel]) {
        self.upcomingModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.homeTableView.reloadData()
        }
    }
    
    func topRatedModel(_ model: [MovieModel]) {
        self.topRatedModel = model
        
        DispatchQueue.main.async { [weak self] in
            self?.homeTableView.reloadData()
        }
    }
    
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
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.trendingMovies.rawValue:
            
            cell.configure(model: trendingMovieModel)
            
        case Sections.trendingTv.rawValue:
            
            cell.configure(model: trendingTVModel)
            
        case Sections.popular.rawValue:
            
            cell.configure(model: popularModel)
            
        case Sections.upcomingMovies.rawValue:
            
            cell.configure(model: upcomingModel)
            
        case Sections.topRated.rawValue:
            
            cell.configure(model: topRatedModel)
            
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

extension HomeViewController: DidTapCellDelegate {
    func didTapCell(_ cell: HomeTableViewCell, viewModel: PreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let previewVC = PreviewViewController()
            previewVC.configure(with: viewModel)
            self?.navigationController?.pushViewController(previewVC, animated: true)
        }
    }
}
