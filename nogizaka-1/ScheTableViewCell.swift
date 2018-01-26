//
//  ScheTableViewCell.swift
//  nogizaka-1
//
//  Created by kken7231 on 2018/01/13.
//  Copyright © 2018 kken7231. All rights reserved.
//

import UIKit

class ScheTableViewCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var TimeAndCompany: UILabel!
    @IBOutlet weak var Member: UILabel!
    @IBOutlet weak var KindImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Title.adjustsFontSizeToFitWidth = true
        Title.minimumScaleFactor = 0.8
        TimeAndCompany.adjustsFontSizeToFitWidth = true
        TimeAndCompany.minimumScaleFactor = 0.8
        Member.adjustsFontSizeToFitWidth = true
        Member.minimumScaleFactor = 0.8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
