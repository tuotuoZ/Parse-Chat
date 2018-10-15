//
//  ChatCell.swift
//  Parse Chat
//
//  Created by Priscilla on 2018/10/15.
//  Copyright © 2018年 Tony. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var messageText: UILabel!
    @IBOutlet weak var usernameText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
