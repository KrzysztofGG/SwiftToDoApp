//
//  SampleData.swift
//  ToDoListApp
//
//  Created by Krzysztof on 09/11/2024.
//

import Foundation
import SwiftData

@MainActor
class SampleData {
    static let shared = SampleData()


    let modelContainer: ModelContainer


    var context: ModelContext {
        modelContainer.mainContext
    }
    
    var todo: ToDo {
        ToDo.sampleData.first!
    }


    private init() {
        let schema = Schema([
            ToDo.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)


        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            
            insertSampleData()
            
            try context.save()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    private func insertSampleData() {
        for todo in ToDo.sampleData {
            context.insert(todo)
        }
    }
}
