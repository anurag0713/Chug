//
//  ReminderInterval.swift
//  Chug
//
//  Created by Anurag Singh on 25/02/26.
//


import Foundation

enum ReminderInterval: Double, CaseIterable, Identifiable {
    case thirtyMinutes = 1800
    case oneHour = 3600
    case twoHours = 7200
    
    var id: Double { rawValue }
    
    var title: String {
        switch self {
        case .thirtyMinutes:
            return "30 Minutes"
        case .oneHour:
            return "1 Hour"
        case .twoHours:
            return "2 Hours"
        }
    }
}