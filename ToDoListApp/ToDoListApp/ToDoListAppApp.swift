//
//  ToDoListAppApp.swift
//  ToDoListApp
//
//  Created by Krzysztof on 12/10/2024.
//

import SwiftUI
import SwiftData

@main
struct ToDoListAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [ToDo.self])
    }
}
