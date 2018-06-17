//
//  Date+MillisecondsSince1970.swift
//  cyberDiscovery
//
//  Created by Joseph Bywater on 17/06/2018.
//  Copyright © 2018 Joseph Bywater. All rights reserved.
//

import Foundation

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds / 1000))
    }
}
