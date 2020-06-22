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
        
        let calendar = NSCalendar.current
        let fullDate = calendar.dateComponents([.month,.day,.year], from: myNSDate)
        //Convert Int Date to String etc January...
        let convertMonth = getYear(rawValue: fullDate.month!)
       
        return "asked \(convertMonth!) \(fullDate.day!)`\(fullDate.year! % 100)"
}

func convertIntToFullDateString(date:Int) -> String{
        let timeInterval = Double(date)
        let myNSDate = Date(timeIntervalSince1970: timeInterval)
        
        let calendar = NSCalendar.current
    let fullDate = calendar.dateComponents([.month,.day,.year,.hour,.minute], from: myNSDate)
        //Convert Int Date to String etc January...
        let convertMonth = getYear(rawValue: fullDate.month!)
       
    return "\(convertMonth!) \(fullDate.day!) \(fullDate.year!) at \(fullDate.hour!):\(fullDate.minute!)"
}


func convertIntToDate(timeInt:Int) -> Date {
    let timeInterval = Double(timeInt)
    let myNSDate = Date(timeIntervalSince1970: timeInterval)
    
    return myNSDate
}
    


func checkInterConnection() -> Bool{
      if Reachability.isConnectedToNetwork(){
             //"Internet Connection Available!")
              return true;
           }else{
           //"Internet Connection not Available!")
              return false
           }
  }

