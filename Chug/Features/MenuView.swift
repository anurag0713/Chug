//
//  MenuView.swift
//  Chug
//
//  Created by Anurag Singh on 25/02/26.
//


import SwiftUI

struct MenuView: View {
    
    @EnvironmentObject var settings: AppSettings
    @State private var launchAtLogin = LaunchAtLoginManager.shared.isEnabled
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text("Chug chug chug...")
                .font(.headline)
            
            Divider()
            
            Picker("Interval", selection: $settings.selectedInterval) {
                ForEach(ReminderInterval.allCases) { interval in
                    Text(interval.title)
                        .tag(interval)
                }
            }
            
            Divider()
            
            Toggle("Launch at Login", isOn: $launchAtLogin)
                .onChange(of: launchAtLogin) { oldValue, newValue in
                    LaunchAtLoginManager.shared.setEnabled(newValue)
                }
            
            Divider()
            
            Button(settings.isRunning ? "Stop Reminders" : "Start Reminders") {
                settings.isRunning.toggle()
            }
            
            Divider()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
        }
        .padding()
        .frame(width: 220)
    }
}
