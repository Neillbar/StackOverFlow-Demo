//
//  cvcTags.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/21.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class cvcTags: UICollectionViewCell {
    
    @IBOutlet weak var tagsButton: UIButton!
    
    override func awakeFromNib() {
        if tagsButton != nil {
            tagsButton.layer.cornerRadius = 10
           
        }
    }
}
