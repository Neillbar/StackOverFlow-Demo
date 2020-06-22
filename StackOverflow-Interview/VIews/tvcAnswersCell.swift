//
//  tvcAnswersCell.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/22.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class tvcAnswersCell: UITableViewCell {
    
    @IBOutlet weak var lblTotalVotes: UILabel!
    @IBOutlet weak var imgCheckMark: UIImageView!
    @IBOutlet weak var lblAnswer: UILabel!
    @IBOutlet weak var lblDatePosted: UILabel!
    @IBOutlet weak var imgAuthorProfileImage: UIImageView!
    @IBOutlet weak var lblAuthorName: UILabel!
    @IBOutlet weak var lblReputation: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if imgAuthorProfileImage != nil {
            imgAuthorProfileImage.layer.cornerRadius = 10
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
