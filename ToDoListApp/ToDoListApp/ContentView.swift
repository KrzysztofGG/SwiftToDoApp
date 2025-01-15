//
//  ContentView.swift
//  ToDoListApp
//
//  Created by Krzysztof on 12/10/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        MainView()
    }
}

#Preview {
    ContentView()
        .modelContainer(SampleData.shared.modelContainer)
}
