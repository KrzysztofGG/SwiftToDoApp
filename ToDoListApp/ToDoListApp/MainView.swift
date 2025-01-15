//
//  MainView.swift
//  ToDoListApp
//
//  Created by Krzysztof on 17/10/2024.
//

import SwiftUICore
import SwiftUI


struct MainView: View {

    @Environment(\.modelContext) private var context
    var body: some View {
        TabView() {
            Tab("Summary", systemImage: "list.bullet.clipboard.fill"){
                SummaryView()
            }
            
            Tab("All", systemImage: "list.bullet.clipboard.fill"){
                ToDoListView()
            }
            
            Tab("Upcoming", systemImage: "list.bullet.clipboard.fill"){
                ToDoListView(listType: "Upcoming")
            }
            
            Tab("Overdue", systemImage: "list.bullet.clipboard.fill"){
                ToDoListView(listType: "Overdue")
            }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(SampleData.shared.modelContainer)
}
