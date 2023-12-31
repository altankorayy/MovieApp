//
//  HomeTableViewCell.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit

protocol DidTapCellDelegate: AnyObject {
    func didTapCell(_ cell: HomeTableViewCell, viewModel: PreviewViewModel)
}

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    private var model = [MovieModel]()
    weak var delegate: DidTapCellDelegate?
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }
    
    public func configure(model: [MovieModel]) {
        self.model = model
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        guard let posterUrl = model[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(posterUrl: posterUrl)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let selectedModel = model[indexPath.row]
        guard let movieName = selectedModel.original_name ?? selectedModel.original_title else { return }
        guard let backdropPath = selectedModel.backdrop_path else { return }
        
        APICaller.shared.getVideoFromYoutube(with: movieName + " trailer") { [weak self] result in
            switch result {
            case .success(let youtubeModel):
                guard let overView = selectedModel.overview else { return }
                let viewModel = PreviewViewModel(title: movieName, youtubeVideo: youtubeModel, titleOverview: overView, backdrop_path: backdropPath)
                guard let strongSelf = self else { return }
                self?.delegate?.didTapCell(strongSelf, viewModel: viewModel)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
