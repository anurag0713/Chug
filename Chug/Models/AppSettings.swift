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
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        NotificationManager.shared.stop()
        NotificationManager.shared.requestPermission()
        setupBindings()
    }
    
    private func setupBindings() {
        
        // Observing for Start/Stop
        $isRunning
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
        
        // Observing when interval changes while running
        $selectedInterval
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
