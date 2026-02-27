//
//  AppSettings.swift
//  Chug
//
//  Created by Anurag Singh on 25/02/26.
//


import Foundation
import Combine

class AppSettings: ObservableObject {
    
    @Published var selectedInterval: ReminderInterval {
        didSet {
            UserDefaults.standard.set(selectedInterval.rawValue, forKey: Keys.interval)
        }
    }
    
    @Published var isRunning: Bool {
        didSet {
            UserDefaults.standard.set(isRunning, forKey: Keys.isRunning)
        }
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    private struct Keys {
        static let interval = "chug.selectedInterval"
        static let isRunning = "chug.isRunning"
    }
    
    init() {
        // Get saved interval
        let savedInterval = UserDefaults.standard.double(forKey: Keys.interval)
        self.selectedInterval = ReminderInterval(rawValue: savedInterval) ?? .oneHour
        
        // Get running state
        self.isRunning = UserDefaults.standard.bool(forKey: Keys.isRunning)
        
        setupBindings()
        
        // If previously running, restart notifications
        if isRunning {
            NotificationManager.shared.start(interval: selectedInterval.rawValue)
        }
    }
    
    private func setupBindings() {
        
        $isRunning
            .dropFirst()
            .sink { isRunning in
                if isRunning {
                    NotificationManager.shared.start(
                        interval: self.selectedInterval.rawValue
                    )
                } else {
                    NotificationManager.shared.stop()
                }
            }
            .store(in: &cancellables)
        
        $selectedInterval
            .dropFirst()
            .sink { newInterval in
                if self.isRunning {
                    NotificationManager.shared.start(
                        interval: newInterval.rawValue
                    )
                }
            }
            .store(in: &cancellables)
    }
}
