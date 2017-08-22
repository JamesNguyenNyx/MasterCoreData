//
//  NikeShoes+CoreDataProperties.swift
//  Galdious
//
//  Created by James Nguyen on 2017/08/22.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import Foundation
import CoreData


extension NikeShoes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NikeShoes> {
        return NSFetchRequest<NikeShoes>(entityName: "NikeShoes")
    }

    @NSManaged public var isFavorite: Bool
    @NSManaged public var lastWorn: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var searchKey: String?
    @NSManaged public var timesWorn: Int32
    @NSManaged public var photoShoe: NSData?
    @NSManaged public var tintColor: NSObject?

}
