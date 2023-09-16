//
//  ListTableViewCell.swift
//  MovieApp
//
//  Created by Altan on 15.09.2023.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    static let identifier = "ListTableViewCell"
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(titleLabel)
        addSubview(posterImageView)
        
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: MovieItem) {
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
            posterImageView.widthAnchor.constraint(equalToConstant: 150)
        ]
        
        let titleLabelConstraints = [
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(posterImageViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
    }
    
}
