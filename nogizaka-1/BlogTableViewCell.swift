//
//  BlogTableViewCell.swift
//  nogizaka-1
//
//  Created by kken7231 on 2018/01/14.
//  Copyright © 2018 kken7231. All rights reserved.
//

import UIKit

class BlogTableViewCell: UITableViewCell {
    @IBOutlet weak var memberPic: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameAndTime: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var comNumLabel: UILabel!
    @IBAction func clipButton(_ sender: UIButton) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
