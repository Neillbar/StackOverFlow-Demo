//
//  endPoints.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import Foundation


//Here i will save all my end points, should this change in the future we can just ammend it here

//StackOverflow API

//Main URL
let stackApiUrl = "https://api.stackexchange.com/2.2/"


func getEndpointForSearchResult(SearchObjectModel:searchSOInputObjectModel) -> URL{
    let searchItem = SearchObjectModel.title.replacingOccurrences(of: " ", with: "%20")
//    print(searchItem)
    var searchResultEndpoint = stackApiUrl + "search/advanced?page=\(SearchObjectModel.page)&pagesize=\(SearchObjectModel.pagesize)&order=desc&sort=relevance&accepted=True&q=\(searchItem)&site=stackoverflow&filter=!9_bDDxJY5"
    
    let endPointUrl: URL = URL(string: searchResultEndpoint)!
    return endPointUrl
}


func getEndPointForAnswers(answersInputParametersModel:AnswersInputParametersModel) -> URL {
    let answersEndPoint = stackApiUrl + "questions/\(answersInputParametersModel.questionId)/answers?order=\(answersInputParametersModel.order)&sort=\(answersInputParametersModel.sort)&site=stackoverflow&filter=!--1nZx2SAHs1"
    
    let endPointUrl: URL = URL(string: answersEndPoint)!
    return endPointUrl
}

