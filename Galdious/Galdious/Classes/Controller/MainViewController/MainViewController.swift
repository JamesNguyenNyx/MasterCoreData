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
    
    @IBOutlet fileprivate weak var tableView: UITableView?
    
    fileprivate var modelView = MainViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMainView()
        self.configureNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FootballClub")
        do {
            modelView.clubs = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

//MARK: FilePrivate Configure
extension MainViewController {
    
    fileprivate func configureMainView() {
        self.title = "Football Clubs"
        self.configureTableView()
    }
    
    fileprivate func configureTableView() {
        self.tableView?.dataSource = modelView
        self.tableView?.delegate = modelView
        tableView?.estimatedRowHeight = 100
        tableView?.tableFooterView = UIView()
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.register(MainCell.nib, forCellReuseIdentifier: MainCell.identifier)
    }
    
    fileprivate func configureNavigation() {
        let button = UIButton.init(type: .custom)
        button.setImage(UIImage.init(named: "ic_addPerson.png"), for: UIControlState.normal)
        button.addTarget(self, action:#selector(MainViewController.addPerson), for: UIControlEvents.touchUpInside)
        button.frame = CGRect.init(x: 0, y: 0, width: 25, height: 25)
        let barButton = UIBarButtonItem.init(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc fileprivate func addPerson() {
        let alert = UIAlertController(title: "New Club", message: "Add a new football club", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            guard let textField = alert.textFields?.first, let nameToSave = textField.text else {
                return
            }
            self.save(name: nameToSave)
            self.tableView?.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func save(name: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "FootballClub",
                                                in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        person.setValue(name, forKeyPath: "name_club")
        
        do {
            try managedContext.save()
            modelView.clubs.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

}






