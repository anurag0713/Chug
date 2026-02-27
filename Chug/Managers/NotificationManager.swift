//
//  NotificationManager.swift
//  Chug
//
//  Created by Anurag Singh on 26/02/26.
//


import Foundation
import UserNotifications

final class NotificationManager {
    
    static let shared = NotificationManager()
    private init() {}
    
    private let notificationID = "chug.water.reminder"
    
    private var debugTimer: Timer?
    private var remainingSeconds: Int = 0
    
    func requestPermission() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) { granted, error in
                print("Permission granted:", granted)
            }
    }
    
    func start(interval: TimeInterval) {
        stop()
        
        let content = UNMutableNotificationContent()
        content.title = "Chug chug chug..."
        content.body = "Time to drink some water!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: interval,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: notificationID,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func stop() {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [notificationID])
    }
}
