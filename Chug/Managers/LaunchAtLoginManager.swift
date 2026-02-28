//
//  LaunchAtLoginManager.swift
//  Chug
//
//  Created by Anurag Singh on 28/02/26.
//


import Foundation
import ServiceManagement

final class LaunchAtLoginManager {
    
    static let shared = LaunchAtLoginManager()
    private init() {}
    
    var isEnabled: Bool {
        SMAppService.mainApp.status == .enabled
    }
    
    func setEnabled(_ enabled: Bool) {
        do {
            if enabled {
                try SMAppService.mainApp.register()
                print("Launch at login enabled")
            } else {
                try SMAppService.mainApp.unregister()
                print("Launch at login disabled")
            }
        } catch {
            print("Failed to update launch at login:", error)
        }
    }
}
