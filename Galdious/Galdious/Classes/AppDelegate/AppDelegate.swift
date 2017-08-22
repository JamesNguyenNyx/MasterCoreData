//
//  AppDelegate.swift
//  Galdious
//
//  Created by James Nguyen on 2017/08/22.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.configureLogin()
        guard let vc = window?.rootViewController as? MainViewController else {
            return true
        }
        
        
        vc.managedContext = persistentContainer.viewContext
        
        return true
    }
    
    
    //MARK: Core Data Stack
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Galdious")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
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
