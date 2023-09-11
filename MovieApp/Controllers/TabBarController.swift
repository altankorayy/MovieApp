//
//  ViewController.swift
//  MovieApp
//
//  Created by Altan on 4.09.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let newAndPopularVC = UINavigationController(rootViewController: NewAndPopularViewController())
        let myNetflixVC = UINavigationController(rootViewController: MyNetflixViewController())
        
        homeVC.tabBarItem.image = UIImage(named: "homefill")
        newAndPopularVC.tabBarItem.image = UIImage(named: "popular")?.withRenderingMode(.alwaysOriginal)
        let myNetflixImage = UIImage(named: "netflix")?.withRenderingMode(.alwaysOriginal)
        myNetflixVC.tabBarItem.image = myNetflixImage
        
        homeVC.title = "Home"
        newAndPopularVC.title = "New and Popular"
        myNetflixVC.title = "My Netflix"
        
        tabBar.tintColor = .label
        
        setViewControllers([homeVC, newAndPopularVC, myNetflixVC], animated: true)
    }


}

