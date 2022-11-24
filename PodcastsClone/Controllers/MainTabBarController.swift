//
//  MainTabBarController.swift
//  PodcastsClone
//
//  Created by Emir Alkal on 24.11.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearances()
        configureViewControllers()
    }
}

// MARK: - Configure View Controllers

extension MainTabBarController {
    func configureViewControllers() {
        viewControllers = [
            addVc(vc: SearchTableVC(), title: "Search"),
            addVc(vc: SearchTableVC(), title: "Favorites"),
            addVc(vc: SearchTableVC(), title: "Downloads")
        ]
    }
    
    func addVc(vc: UIViewController, title: String) -> UIViewController {
        vc.tabBarItem.title = title
        vc.navigationItem.title = title
        vc.tabBarItem.image = UIImage(named: title.lowercased())
        
        return UINavigationController(rootViewController: vc)
    }
}

// MARK: - Configure Appearance things

extension MainTabBarController {
    func configureAppearances() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        
        UITabBar.appearance().tintColor = .purple
        UITabBar.appearance().standardAppearance = tabBarAppearance
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let navBarAppearances = UINavigationBarAppearance()
        navBarAppearances.configureWithDefaultBackground()
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().standardAppearance = navBarAppearances
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearances
    }
}
