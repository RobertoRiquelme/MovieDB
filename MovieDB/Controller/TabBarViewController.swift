//
//  TabBarViewController.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/16/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let tabNowPlaying = NowPlayingCollectionViewController()
        let nowPlayingNavigation = UINavigationController(rootViewController: tabNowPlaying)
        let tabNowPlayingItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 0)
        nowPlayingNavigation.tabBarItem = tabNowPlayingItem

        let tabSearch = SearchViewController()
        let searchNavigation = UINavigationController(rootViewController: tabSearch)
        let tabSearchItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchNavigation.tabBarItem = tabSearchItem

        self.viewControllers = [nowPlayingNavigation, searchNavigation]
    }

    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
       // print("Selected \(viewController.title!)")
    }

}
