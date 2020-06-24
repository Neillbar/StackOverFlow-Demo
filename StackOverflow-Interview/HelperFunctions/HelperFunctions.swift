//
//  HelperFunctions.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import Foundation
import UIKit

func convertIntDateToSearchResultDate(date:Int) -> String{
    let timeInterval = Double(date)
    let myNSDate = Date(timeIntervalSince1970: timeInterval)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d `yy"
    return dateFormatter.string(from: myNSDate)
}

func convertIntToFullDateString(date:Int) -> String{
    let timeInterval = Double(date)
    let myNSDate = Date(timeIntervalSince1970: timeInterval)
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d y 'at' HH:mm"
    return dateFormatter.string(from: myNSDate)
}


func convertIntToDate(timeInt:Int) -> Date {
    let timeInterval = Double(timeInt)
    let myNSDate = Date(timeIntervalSince1970: timeInterval)
    return myNSDate
}

func checkInterConnection() -> Bool{
    if Reachability.isConnectedToNetwork(){
        //Internet Connection Available
        return true;
    }else{
        //Internet Connection not Available
        return false
    }
}

