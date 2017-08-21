//
//  AppColor.swift
//  SampleApp
//
//  Created by James Nguyen on 2017/07/13.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import Foundation
import UIKit

func color(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) -> UIColor {
    return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: alpha)
}

struct AppColor {
    static let violet = color(r: 80, g: 76, b: 120)
    static let lightOrange = color(r: 245, g: 92, b: 87)
    static let white = UIColor.white
    static let blue = UIColor.blue
    static let strongBlue = color(r: 38, g: 50, b: 56)
    static let lightStrongBlue = color(r: 57, g: 71, b: 79)
    static let lightBlue = color(r: 90, g: 109, b: 121)
    static let lightGray = color(r: 162, g: 170, b: 174, alpha: 0.5)
    static let yellow = color(r: 255, g: 206, b: 7)
    
    static let lightGreen = color(r: 72, g: 149, b: 140)
    static let darkGreen = color(r: 55, g: 95, b: 97)
    static let mainGreen = color(r: 0, g: 79, b: 104)
    static let hightLight = color(r: 0, g: 79, b: 104, alpha: 0.5)
    
    static let clear = UIColor.clear
}
