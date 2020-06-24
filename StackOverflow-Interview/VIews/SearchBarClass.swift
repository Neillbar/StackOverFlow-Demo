//
//  SearchBarClass.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/23.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class SearchBarClass: UISearchBar {

    override func awakeFromNib() {
             self.layer.borderWidth = 1.0
             self.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
             self.layer.cornerRadius = 10
             self.searchTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

}
