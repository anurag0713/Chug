//
//  ChugApp.swift
//  Chug
//
//  Created by Anurag Singh on 25/02/26.
//

import SwiftUI

@main
struct ChugApp: App {
    
    @StateObject private var settings = AppSettings()
    
    var body: some Scene {
        
        // MARK: - Menu Bar
        MenuBarExtra("Chug", systemImage: "timelapse") {
            MenuView()
                .environmentObject(settings)
        }
    }
}
