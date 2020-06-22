//
//  StackOverFlowAPICalls.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import Foundation


class StackOverflowApiCalls {
    let dispatchGroup = DispatchGroup()
    
    func fetchSearchResult(searchObjectModel: searchSOInputObjectModel, completion: @escaping(Result<allSearchItems,APIError>) -> Void) {
        
        dispatchGroup.enter()
        
        let url = getEndpointForSearchResult(SearchObjectModel: searchObjectModel)
        
        do{
            
            let dataTask = URLSession.shared.dataTask(with: url) { (searchResult, urlResponse, error) in
                
                if error != nil  {
                    completion(.failure(.apiError))
                }
                
                let httpUrlResponse = urlResponse as? HTTPURLResponse
                
                switch(httpUrlResponse?.statusCode){
                case 500:
                    completion(.failure(.statusCode(.internal_error)))
                case 502:
                    completion(.failure(.statusCode(.throttle_violation)))
                case 503:
                    completion(.failure(.statusCode(.temporarily_unavailable)))
                default:
                    print("NO FAILURE")
                }
                
                guard  let jsonResponse = searchResult else {
                    completion(.failure(.InvalidJSONData))
                    return
                }
                do{
                    let finalSearchResult = try JSONDecoder().decode(allSearchItems.self, from: jsonResponse)
                    completion(.success(finalSearchResult))
                }catch let decodableError{
                    completion(.failure(.unknown(decodableError.localizedDescription)))
                }
                self.dispatchGroup.leave()
            }
            dataTask.resume()
        }
    }//fetchSearchResult
    
    
    func fetchAnswersForQuestion(answersInputParametersModel:AnswersInputParametersModel,completion: @escaping(Result<allAnswersItems,APIError>) -> Void){
        
        dispatchGroup.enter()
        let url = getEndPointForAnswers(answersInputParametersModel: answersInputParametersModel)
        
        do{
            let dataTask = URLSession.shared.dataTask(with: url) { (answers, urlResponse, error) in
                
                if error != nil  {
                    completion(.failure(.apiError))
                }
                
                let httpUrlResponse = urlResponse as? HTTPURLResponse
                
                switch(httpUrlResponse?.statusCode){
                case 500:
                    completion(.failure(.statusCode(.internal_error)))
                case 502:
                    completion(.failure(.statusCode(.throttle_violation)))
                case 503:
                    completion(.failure(.statusCode(.temporarily_unavailable)))
                default:
                    print("NO FAILURE")
                }
                
                guard  let jsonResponse = answers else {
                    completion(.failure(.InvalidJSONData))
                    return
                }
                
                do{
                    let finalSearchResult = try JSONDecoder().decode(allAnswersItems.self, from: jsonResponse)
                    completion(.success(finalSearchResult))
                }catch let decodableError{
                    completion(.failure(.unknown(decodableError.localizedDescription)))
                }
                self.dispatchGroup.leave()
            }
            dataTask.resume()
        }
        
    }//fetchAnswersForQuestion
    
    
    
    
    
}


