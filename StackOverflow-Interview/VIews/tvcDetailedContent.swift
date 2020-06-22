//
//  tvcDetailedContent.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/20.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class tvcDetailedContent: UITableViewCell {
    //TITLE
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblAsked: UILabel!
    @IBOutlet weak var lblAnswered: UILabel!
    @IBOutlet weak var lblViewed: UILabel!
    //BODY
    @IBOutlet weak var lblBody: UILabel!
    
    //FOOTER
    @IBOutlet weak var lblDateQuestionWasAsked: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblPoints: UILabel!
    @IBOutlet weak var imgAuthorProfile: UIImageView!
    
    //FILTER
    @IBOutlet weak var lblAnsweredTotal: UILabel!
    @IBOutlet weak var sgmFilter: UISegmentedControl!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if imgAuthorProfile != nil {
            imgAuthorProfile.layer.cornerRadius = 20
        }
        
        if sgmFilter != nil {
            sgmFilter.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            sgmFilter.layer.borderWidth = 1
        }
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
