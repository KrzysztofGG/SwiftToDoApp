//
//  ToDoListView.swift
//  ToDoListApp
//
//  Created by Krzysztof on 17/10/2024.
//

import SwiftUI
import SwiftData


struct ToDoListView: View {
    
    @Query(sort: \ToDo.title) private var toDos: [ToDo]
    @Environment(\.modelContext) private var context
    @State private var newToDo: ToDo?

    var listType: String = "All"
    
    var finalList: [ToDo] {
        switch listType {
        case "Upcoming":
            toDos.filter( {$0.finishDate != nil && $0.finishDate! >= Date()} )
        case "Overdue":
            toDos.filter( {$0.deadline != nil && $0.deadline! < Date()} )
        default:
            toDos
        }
    }
    
    var body: some View {
        NavigationSplitView {
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color("Bg gradient top"), Color("Bg gradient bottom")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack(alignment: .leading) {
                    List {
                        ForEach(finalList) { todo in
                            NavigationLink(destination: ToDoDetails(todo: todo)) {
                                ToDoView(todo: todo)
                                    .tag(todo)
                            }
                            .padding(.horizontal, 5)
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets())
                        }
                        .onDelete(perform: deleteToDos(indexes:))
                    }
                    .scrollContentBackground(.hidden)
                    .navigationTitle(listType + " Tasks")
                    .frame(maxWidth: .infinity)
                    .toolbar{
                        ToolbarItem {
                            Button("Add task", systemImage: "plus", action: addToDo)
                        }
                        ToolbarItem(placement: .topBarTrailing) {
                            EditButton()
                        }
                    }
                    .sheet(item: $newToDo) { todo in
                        NavigationStack {
                            ToDoDetails(todo: todo, isNew: true)
                        }
                        .interactiveDismissDisabled()
                    }
                }
            }


        } detail: {
//            if let todo = selectedToDo {
//                ToDoDetails(todo: todo)
//            } else {
//                Text("Select a ToDo")
//                    .foregroundStyle(.secondary)
//            }
            Text("Select a task")
                .navigationTitle("Task")
                .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    
    private func addToDo(){
        let newToDo = ToDo(title: "", priority: .low)
        context.insert(newToDo)
        self.newToDo = newToDo
    }
    
    private func deleteToDos(indexes: IndexSet) {
        for index in indexes {
            context.delete(toDos[index])
        }
    }
}

func getDate(from string: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    return formatter.date(from: string)
}

#Preview {
    ToDoListView()
        .modelContainer(SampleData.shared.modelContainer)
}
