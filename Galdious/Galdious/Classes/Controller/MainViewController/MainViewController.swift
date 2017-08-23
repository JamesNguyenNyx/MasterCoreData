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
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timesWornLabel: UILabel!
    @IBOutlet weak var lastWornLabel: UILabel!
//    @IBOutlet weak var favoriteLabel: UILabel!
    
    fileprivate var modelView = MainViewModel()
    var managedContext: NSManagedObjectContext?
    var currentNikeShoe: NikeShoes?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureMainView()
        
//        let request = NSFetchRequest<NikeShoes>(entityName: "NikeShoes")
//        let firstTitle = segmentedControl.titleForSegment(at: 0)!
//        request.predicate = NSPredicate(format: "searchKey == %@", firstTitle)
//        
//        do {
//            let results = try managedContext?.fetch(request)
//            currentNikeShoe = results?.first
//            
//            populate(shoe: (results?.first!)!)
//            
//        } catch let error as NSError {
//            
//            print("Could not fetch \(error), \(error.userInfo)")
//        }
    }
    
    func populate(shoe: NikeShoes) {
        
        guard let imageData = shoe.photoShoe as Data?,
            let lastWorn = shoe.lastWorn as Date?,
            let tintColor = shoe.tintColor as? UIColor else {
                return
        }
        
        imageView.image = UIImage(data: imageData)
        nameLabel.text = shoe.name
        ratingLabel.text = "Rating: \(shoe.rating)/5"
        
        timesWornLabel.text = "# times worn: \(shoe.timesWorn)"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        lastWornLabel.text =
            "Last worn: " + dateFormatter.string(from: lastWorn)
        
//        favoriteLabel.isHidden = !shoe.isFavorite
        view.tintColor = tintColor
        
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
    
    @IBAction func segmentedControl(_ sender: AnyObject) {
        guard let control = sender as? UISegmentedControl else {
            return
        }
        
        let selectedValue = control.titleForSegment(at: control.selectedSegmentIndex)
        let request = NSFetchRequest<NikeShoes>(entityName: "NikeShoes")
        request.predicate = NSPredicate(format: "searchKey == %@", selectedValue!)
        
        do {
            let results =  try managedContext?.fetch(request)
            currentNikeShoe =  results?.first
            populate(shoe: currentNikeShoe!)
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
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
    
    @objc fileprivate func addRating(_ sender: AnyObject) {
        let alert = UIAlertController(title: "New Rating",
                                      message: "Rate this bow tie",
                                      preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.keyboardType = .decimalPad
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard let textField = alert.textFields?.first else {
                return
            }
            
            self.update(rating: textField.text)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        
        present(alert, animated: true)

    }
    
    @objc fileprivate func addWearNumber(_ sender: AnyObject) {
        let times = currentNikeShoe?.timesWorn
        currentNikeShoe?.timesWorn = times! + 1
        
        currentNikeShoe?.lastWorn = NSDate()
        
        do {
            
            try managedContext?.save()
            populate(shoe: currentNikeShoe!)
            
        } catch let error as NSError {
            
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func update(rating: String?) {
        
        guard let ratingString = rating,
            let rating = Double(ratingString) else {
                return
        }
        
        do {
            
            currentNikeShoe?.rating = rating
            try managedContext?.save()
            populate(shoe: currentNikeShoe!)
            
        } catch let error as NSError {
            
            if error.domain == NSCocoaErrorDomain &&
                (error.code == NSValidationNumberTooLargeError ||
                    error.code == NSValidationNumberTooSmallError) {
                addRating(currentNikeShoe!)
            } else {
                print("Could not save \(error), \(error.userInfo)")
            }
        }
    }
    
    func insertSampleData() {
        let fetch = NSFetchRequest<NikeShoes>(entityName: "NikeShoes")
        fetch.predicate = NSPredicate(format: "searchKey != nil")
        
        let count = try! managedContext?.count(for: fetch)
        
        if count! > 0 {
            // SampleData.plist data already in Core Data
            return
        }
        
        let path = Bundle.main.path(forResource: "SampleData", ofType: "plist")
        let dataArray = NSArray(contentsOfFile: path!)!
        
        for dict in dataArray {
            let entity = NSEntityDescription.entity(forEntityName: "Bowtie",
                                                    in: managedContext!)!
            let bowtie = NikeShoes(entity: entity, insertInto: managedContext)
            let btDict = dict as! [String: AnyObject]
            
            bowtie.name = btDict["name"] as? String
            bowtie.searchKey = btDict["searchKey"] as? String
            bowtie.rating = btDict["rating"] as! Double
            let colorDict = btDict["tintColor"] as! [String: AnyObject]
            bowtie.tintColor = UIColor.color(dict: colorDict)
            
            let imageName = btDict["imageName"] as? String
            let image = UIImage(named: imageName!)
            let photoData = UIImagePNGRepresentation(image!)!
            bowtie.photoShoe = NSData(data: photoData)
            
            bowtie.lastWorn = btDict["lastWorn"] as? NSDate
            let timesNumber = btDict["timesWorn"] as! NSNumber
            bowtie.timesWorn = timesNumber.int32Value
            bowtie.isFavorite = btDict["isFavorite"] as! Bool
        }
        
        try! managedContext?.save()
    }


}


private extension UIColor {
    
    static func color(dict: [String: AnyObject]) -> UIColor? {
        guard let red = dict["red"] as? NSNumber,
            let green = dict["green"] as? NSNumber,
            let blue = dict["blue"] as? NSNumber else {
                return nil
        }
        
        return UIColor(red: CGFloat(red)/255.0,
                       green: CGFloat(green)/255.0,
                       blue: CGFloat(blue)/255.0,
                       alpha: 1)
    }
}







