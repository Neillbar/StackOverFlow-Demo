//
//  tvcSoSearchResult.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class tvcSoSearchResult: UITableViewCell {
    
    @IBOutlet weak var imgCheckMark: UIImageView!
    
    @IBOutlet weak var lblAnswerCount: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    @IBOutlet weak var lblViewsCount: UILabel!
    @IBOutlet weak var lblBody: UILabel!
    @IBOutlet weak var imgRightArrow: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
