//
//  MainCell.swift
//  Tuberose
//
//  Created by James Nguyen on 2017/08/21.
//  Copyright © 2017 James Nguyen. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet weak var mainTitle: UILabel?
    @IBOutlet weak var subTitle: UILabel?
    @IBOutlet fileprivate weak var avatarView: UIImageView?
    
    var mainModel: MainModel? {
        didSet {
            self.updateData(mainModel)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.hightLightForCell()
    }
    
    fileprivate func hightLightForCell() {
        let selectedView = UIView(frame: CGRect.zero)
        selectedView.backgroundColor = AppColor.hightLight
        selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    fileprivate func updateData(_: MainModel?) {
        mainTitle?.text = mainModel?.mainTitle
        subTitle?.text = mainModel?.subTitle
    }
    
}
