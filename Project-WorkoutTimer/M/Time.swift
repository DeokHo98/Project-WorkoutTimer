//
//  Time.swift
//  Project-WorkoutTimer
//
//  Created by 정덕호 on 2022/01/26.
//

import Foundation


struct Time {
    static var restTimeArrayMin: [String] = ["00","01","02","03","04","05","06","07","08","09","10"]
    
    static var restTimeArraySec: [String] {
        var num = ["00","01","02","03","04","05","06","07","08","09"]
        for i in 10...60 {
            num.append(String(i))
        }
        return num
    }
    
    static var restTimeMin: Int = 0
    
    static var restTimeSec: Int = 0
    
    static var totalRestTime: Int = 0
    
    static var duplicatedTotalRestTime: Int = 0
    
    var mainTimer: Timer?
    
    var timeCount: Int = 0
    
    static var setCount: Int = 0
    
    var timerCounting: Bool = false
}
