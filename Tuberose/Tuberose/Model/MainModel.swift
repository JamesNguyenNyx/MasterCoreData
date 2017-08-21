//
//  MainModel.swift
//  Tuberose
//
//  Created by James Nguyen on 2017/08/21.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit

class MainModel: NSObject {
    
    var mainTitle: String
    var subTitle: String
    
    init(mainTitle: String, subTitle: String) {
        self.mainTitle = mainTitle
        self.subTitle = subTitle
    }
}
