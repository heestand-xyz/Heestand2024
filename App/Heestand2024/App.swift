//
//  Heestand2024App.swift
//  Heestand2024
//
//  Created by Heestand, Anton Norman | Anton | GSSD on 2024-01-17.
//

import SwiftUI

@main
struct Heestand2024App: App {
    
    let isMobile = false
    let isDarkMode = true
    
    var body: some Scene {
        WindowGroup {
            ContentView(isMobile: isMobile, isDarkMode: isDarkMode)
        }
        .defaultSize(width: isMobile ? 400 : 1300,
                     height: isMobile ? 800 : 700)
    }
}
