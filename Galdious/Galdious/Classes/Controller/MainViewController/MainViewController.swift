//
//  MainViewController.swift
//  Tuberose
//
//  Created by James Nguyen on 2017/08/21.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var cornerView: UIView?
    
    fileprivate var modelView = MainViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMainView()
    }
}

//MARK: FilePrivate Configure
extension MainViewController {
    
    fileprivate func configureMainView() {
        self.configureNavigation()
        let logo = UIImage(named: "ic_nike.png")
        let imageView = UIImageView(image:logo)
        self.navigationItem.titleView = imageView
        
        self.cornerView?.layer.cornerRadius = 5
        self.cornerView?.clipsToBounds = true
    }
    
    fileprivate func configureNavigation() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "ic_rating.png"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(MainViewController.addRating), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 22, height: 22)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
        
        
        let leftButton = UIButton.init(type: .custom)
        leftButton.setImage(UIImage.init(named: "ic_tag.png"), for: .normal)
        leftButton.addTarget(self, action: #selector(MainViewController.addWearNumber), for: .touchUpInside)
        leftButton.frame = CGRect.init(x: 0, y: 0, width: 22, height: 22)
        let leftBar = UIBarButtonItem.init(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBar
    }
    
    @objc fileprivate func addRating() {
        print("Press to Rating button")
    }
    
    @objc fileprivate func addWearNumber() {
        print("Press to Wear button")
    }
}






