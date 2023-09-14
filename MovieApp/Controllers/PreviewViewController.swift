//
//  PreviewViewController.swift
//  MovieApp
//
//  Created by Altan on 13.09.2023.
//

import UIKit
import WebKit

class PreviewViewController: UIViewController {
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let playButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Play"
        configuration.image = UIImage(systemName: "play.fill")
        configuration.imagePadding = 10
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.tintColor = .black
        button.clipsToBounds = true
        return button
    }()
    
    private let downloadButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Download"
        configuration.image = UIImage(systemName: "arrow.down.to.line")
        configuration.imagePadding = 10
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGray4
        button.layer.cornerRadius = 5
        button.tintColor = .white
        button.clipsToBounds = true
        return button
    }()
    
    private let overViewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private let addListButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "hand.thumbsup", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "paperplane", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .label
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(webView)
        view.addSubview(titleLabel)
        view.addSubview(playButton)
        view.addSubview(downloadButton)
        view.addSubview(overViewLabel)
        view.addSubview(addListButton)
        view.addSubview(likeButton)
        view.addSubview(shareButton)
        
        setConstraints()
        
        navigationController?.navigationBar.tintColor = .label
    }
    
    func configure(with model: PreviewViewModel) {
        titleLabel.text = model.title
        overViewLabel.text = model.titleOverview
        
        guard let url = URL(string: "https://www.youtube.com/embed/\(model.youtubeVideo.id.videoId)") else { return }
        webView.load(URLRequest(url: url))
    }
    
    private func setConstraints() {
        let webViewConstraints = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let titleLabelConstrainst = [
            titleLabel.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ]
        
        let playButtonConstraints = [
            playButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            playButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let downloadButtonConstrainst = [
            downloadButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 10),
            downloadButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            downloadButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            downloadButton.heightAnchor.constraint(equalToConstant: 35)
        ]
        
        let overViewLabelConstraints = [
            overViewLabel.topAnchor.constraint(equalTo: downloadButton.bottomAnchor, constant: 10),
            overViewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            overViewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ]
        
        let addListButtonConstraints = [
            addListButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 30),
            addListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ]
                
        let likeButtonConstraints = [
            likeButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 30),
            likeButton.leadingAnchor.constraint(equalTo: addListButton.trailingAnchor, constant: 25)
        ]
                
        let shareButtonConstraints = [
            shareButton.topAnchor.constraint(equalTo: overViewLabel.bottomAnchor, constant: 30),
            shareButton.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 20)
        ]
        
        NSLayoutConstraint.activate(webViewConstraints)
        NSLayoutConstraint.activate(titleLabelConstrainst)
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadButtonConstrainst)
        NSLayoutConstraint.activate(overViewLabelConstraints)
        NSLayoutConstraint.activate(addListButtonConstraints)
        NSLayoutConstraint.activate(likeButtonConstraints)
        NSLayoutConstraint.activate(shareButtonConstraints)
    }

}
