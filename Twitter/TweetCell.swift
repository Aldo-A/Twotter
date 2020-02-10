//
//  TweetCell.swift
//  Twitter
//
//  Created by Aldo Almeida on 2/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
