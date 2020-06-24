//
//  StackOverflowModels.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import Foundation

//Search input
struct searchSOInputObjectModel {
    var title:String
    var page:Int
    var pagesize:Int
}


//Search Result Items
struct allSearchItems: Decodable{
    var items: [searchResultObjectModel]
}

struct internalError:Decodable{
    var error_id: Int
    var error_message:String
}

//Search Result Object
struct searchResultObjectModel : Decodable {
    var tags: [String]
    var owner : OwnerObjectModel?
    var is_answered: Bool
    var view_count: Int
    var accepted_answer_id:Int
    var answer_count:Int
    var score: Int
    var last_activity_date: Int
    var creation_date:Int
    var last_edit_date:Int?
    var question_id:Int
    var content_license:String?
    var link:String
    var title:String
    var body:String
    
}


//Owner of each post model
struct OwnerObjectModel: Decodable{
    var reputation: Int?
    var user_id: Int?
    var user_type:String?
    var profile_image: String?
    var display_name: String?
    var link:String?
}
