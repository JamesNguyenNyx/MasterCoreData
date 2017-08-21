//
//  NSObjectExtension.swift
//  Lotus
//
//  Created by James Nguyen on 2017/08/15.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import Foundation

public extension NSObject {
    
    public class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    public var className: String {
        return NSStringFromClass(type(of:self)).components(separatedBy: ".").last!
    }
    
    public func toDictionary() -> Dictionary <String, AnyObject> {
        var dict: [String: AnyObject] = Dictionary()
        let otherSelf = Mirror(reflecting: self)
        for child in otherSelf.children {
            if let key = child.label {
                dict[key] = child.value as AnyObject?
            }
        }
        return dict
    }
}
