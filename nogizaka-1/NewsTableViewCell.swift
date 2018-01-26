//
//  NewsTableViewCell.swift
//  nogizaka-1
//
//  Created by kken7231 on 2018/01/13.
//  Copyright © 2018 kken7231. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var Title: UILabel!
    @IBOutlet weak var Date: UILabel!
    @IBOutlet weak var Explanation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
