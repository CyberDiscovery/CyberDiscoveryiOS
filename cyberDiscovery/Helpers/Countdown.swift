//
//  Countdown.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import Foundation

func countdown(to: Date) -> String {
    
    // Current date
    let date = Date()
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: date as Date)

    let currentDate = calendar.date(from: components)
    let userCalendar = Calendar.current
    
    
    // here we set the due date. When the timer is supposed to finish
    let competitionDate = calendar.dateComponents([.hour, .minute, .month, .year, .day], from: to as Date)
    
    let competitionDay = userCalendar.date(from: competitionDate as DateComponents)!
    
    //here we change the seconds to hours,minutes and days
    let finalDayDifference = calendar.dateComponents([.day, .hour, .minute], from: currentDate!, to: competitionDay)
    
    
    //finally, here we set the variable to our remaining time
    let daysLeft = finalDayDifference.day
    let hoursLeft = finalDayDifference.hour
    let minutesLeft = finalDayDifference.minute
    
    return "\(daysLeft ?? 0) Days, \(hoursLeft ?? 0) Hours, \(minutesLeft ?? 0) Minutes"
}
