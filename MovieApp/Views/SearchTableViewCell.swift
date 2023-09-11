//
//  SearchTableViewCell.swift
//  MovieApp
//
//  Created by Altan on 11.09.2023.
//

import UIKit
import SDWebImage

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()

    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(posterImageView)
        addSubview(playButton)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: MovieModel) {
        guard let backdropPath = model.backdrop_path else { return }
        guard let originalName = model.original_name else { return }
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(backdropPath)") else { return }
        titleLabel.text = originalName
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func setConstraints() {
        let posterImageViewConstraints = [
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            posterImageView.widthAnchor.constraint(equalToConstant: 130)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        let playButtonConstraints = [
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            playButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(playButtonConstraints)
    }
    
}
