//
//  MyNetflixViewController.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit

class MyNetflixViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        configureNavigationBar()
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
            firstLabel.text = "  My Netflix"
            firstLabel.font = .systemFont(ofSize: 22, weight: .semibold)
            firstLabel.textColor = .label
            navigationBar.addSubview(firstLabel)
        }
    }

}
