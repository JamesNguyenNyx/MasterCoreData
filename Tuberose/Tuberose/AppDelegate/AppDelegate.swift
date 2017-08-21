//
//  AppDelegate.swift
//  Tuberose
//
//  Created by James Nguyen on 2017/08/21.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.configureLogin()
        return true
    }
    
    
}


//MARK: FilePrivate AppDelegate
fileprivate extension AppDelegate {
    
    fileprivate func isLogin() -> Bool {
        return false
    }
    
    fileprivate func configureLogin() {
        if isLogin() {
            configureRootViewController()
        } else {
            setRootAuthenticationViewController()
        }
    }
    
    fileprivate func configureRootViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            let mainViewController = MainViewController(nibName: MainViewController.className, bundle: nil)
            let navigation = BaseNavigationController(rootViewController: mainViewController)
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        }
    }
    
    fileprivate func setRootAuthenticationViewController() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            let mainViewController = MainViewController(nibName: MainViewController.className, bundle: nil)
            let navigation = BaseNavigationController(rootViewController: mainViewController)
            window.rootViewController = navigation
            window.makeKeyAndVisible()
        }
        
    }
}

