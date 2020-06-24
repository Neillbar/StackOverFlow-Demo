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
                
                guard  let jsonResponse = searchResult else {
                    completion(.failure(.InvalidJSONData))
                    return
                }
                
                switch(httpUrlResponse?.statusCode){
                case 400:
                    do{
                        let errorInResult = try JSONDecoder().decode(internalError.self, from: jsonResponse)
                        completion(.failure(.internalError(self.handleInternalError(statusCodeError: errorInResult))))
                        return
                    }catch{
                        completion(.failure(.apiError))
                        return
                    }
                    
                default:
                    print("ALL GOOD ON STATUS CODE")
                }
                
                do{
                    let finalSearchResult = try JSONDecoder().decode(allSearchItems.self, from: jsonResponse)
                    completion(.success(finalSearchResult))
                }catch {
                    completion(.failure(.apiError))
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
                
                guard  let jsonResponse = answers else {
                    completion(.failure(.InvalidJSONData))
                    return
                }
                
                let httpUrlResponse = urlResponse as? HTTPURLResponse
                switch(httpUrlResponse?.statusCode){
                case 400:
                    do{
                        let errorInResult = try JSONDecoder().decode(internalError.self, from: jsonResponse)
                        completion(.failure(.internalError(self.handleInternalError(statusCodeError: errorInResult))))
                    }catch{
                        completion(.failure(.apiError))
                    }
                    
                default:
                      print("ALL GOOD ON STATUS CODE")
                }
                do{
                    let finalSearchResult = try JSONDecoder().decode(allAnswersItems.self, from: jsonResponse)
                    completion(.success(finalSearchResult))
                }catch{
                    completion(.failure(.apiError))
                }
                self.dispatchGroup.leave()
            }
            dataTask.resume()
        }
        
    }//fetchAnswersForQuestion
    
    func handleInternalError(statusCodeError:internalError) -> String{
        switch statusCodeError.error_id {
        case 500:
            return "We are experiencing an internal error, try again later"
        case 502:
            return "Too many requests were made from this IP, try again later"
        case 503:
            return "We are temporarily unavailable, try again later"
        default:
            return "Error unkown, try again later"
        }
        
    }//handleInternalError
    
}


