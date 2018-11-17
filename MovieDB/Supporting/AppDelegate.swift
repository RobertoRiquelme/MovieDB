//
//  AppDelegate.swift
//  MovieDB
//
//  Created by Roberto Riquelme on 11/11/18.
//  Copyright © 2018 Roberto Riquelme. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let tabBar = TabBarViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabBar

        window?.makeKeyAndVisible()

        return true
    }

}

