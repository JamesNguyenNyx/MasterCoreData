//
//  MainViewModel.swift
//  Tuberose
//
//  Created by James Nguyen on 2017/08/21.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit
import CoreData

class MainViewModel: NSObject {
    
    var clubs: [NSManagedObject] = []
    
    override init() {
        super.init()
    }
}


//MARK: UITableViewDataSource
extension MainViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let club = clubs[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.identifier, for: indexPath) as? MainCell {
            cell.mainTitle?.text = club.value(forKeyPath: "name_club") as? String
            return cell
        }
        return UITableViewCell()
    }
}


//MARK: UITableViewDelegate
extension MainViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
