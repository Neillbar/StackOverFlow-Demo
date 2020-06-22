//
//  AnswersModels.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/21.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import Foundation



struct AnswersInputParametersModel {
    var questionId:Int
    var order:String
    var sort: String
}

struct allAnswersItems: Decodable{
    var items: [answersModel]
}

struct answersModel: Decodable {
    var owner : OwnerObjectModel?
    var is_accepted: Bool
    var score: Int
    var last_activity_date: Int
    var last_edit_date:Int?
    var creation_date:Int
    var answer_id:Int
    var question_id:Int
    var title:String
    var body:String
}
