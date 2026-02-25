//
//  AppSettings.swift
//  Chug
//
//  Created by Anurag Singh on 25/02/26.
//


import Foundation
import Combine

class AppSettings: ObservableObject {
    @Published var selectedInterval: ReminderInterval = .oneHour
    @Published var isRunning: Bool = false
}
