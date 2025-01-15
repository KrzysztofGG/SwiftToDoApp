//
//  ToDoDetails.swift
//  ToDoListApp
//
//  Created by Krzysztof on 24/10/2024.
//
import SwiftUI

struct ToDoDetails: View {

    @Bindable var todo: ToDo
    let isNew: Bool
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var localDesc: String
    @State private var localFinishDate: Date? = nil
    @State private var localDeadline: Date? = nil
    private let currentDate = Date()
    
    init(todo: ToDo, isNew: Bool = false) {
        self.todo = todo
        self.isNew = isNew
        _localDesc = State(initialValue: todo.desc ?? "")
        _localFinishDate = State(initialValue: todo.finishDate)
        _localDeadline = State(initialValue: todo.deadline)
    }
    
    var body: some View {

        Form {
            Section(header: Text("Title")) {
//                Text("Title")
//                    .foregroundColor(.primary)
                TextField("Title", text: $todo.title)
                    .font(.title2)
                    .padding()
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
            }
            Section(header: Text("Description")) {
                VStack {
                    TextEditor(text: $localDesc)
                        .font(.body)
                        .frame(height: 100)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                    
                    Button(localDesc == "" ? "No Description" : "Clear Description") {
                        localDesc = ""
                    }
                    .disabled(localDesc == "")
                    .foregroundStyle(localDesc == "" ? .gray : .blue)
                }
                .onChange(of: localDesc) { newValue in
                    todo.desc = newValue.isEmpty ? nil : newValue
                }
            }
            
            Section(header: Text("Priority")) {
                VStack {
                    Picker("Priority", selection: $todo.priority) {
                        Text("Low").tag(Priority.low)
                        Text("Medium").tag(Priority.medium)
                        Text("High").tag(Priority.high)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(5)
                }
            }
            
            Section(header: Text("Finish Date")) {
                VStack {
                    DatePicker("Finish Date", selection: Binding(
                        get: { localFinishDate ?? currentDate },
                        set: { localFinishDate = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Button(localFinishDate == nil ? "No Finish Date Set" : "Clear Finish Date") {
                        localFinishDate = nil
                    }
                    .disabled(localFinishDate == nil)
                    .foregroundStyle(localFinishDate == nil ? .gray : .blue)
                    
                    .onChange(of: localFinishDate) { newValue in
                        todo.finishDate = newValue == nil ? nil : Calendar.current.startOfDay(for: newValue!)
                    }
                }
            }
            
            Section(header: Text("Deadline")) {
                VStack {
                    DatePicker("Deadline", selection: Binding(
                        get: { localDeadline ?? currentDate },
                        set: { localDeadline = $0 }
                    ), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    
                    Button(localDeadline == nil ? "No Deadline Set" : "Clear Deadline") {
                        localDeadline = nil
                    }
                    .disabled(localDeadline == nil)
                    .foregroundStyle(localDeadline == nil ? .gray : .blue)
                    
                    .onChange(of: localDeadline) { newValue in
                        todo.deadline = newValue == nil ? nil : Calendar.current.startOfDay(for: newValue!)
                    }
                }
            }
        
        }
        .onDisappear {
            todo.desc = localDesc.isEmpty ? nil : localDesc
            todo.finishDate = localFinishDate == currentDate ? nil : localFinishDate
            todo.deadline = localDeadline == currentDate ? nil : localDeadline
        }
        .navigationTitle(isNew ? "New task" : "Task")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if isNew {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        if todo.title == "" {
                            context.delete(todo)
                        }
                        dismiss()
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        context.delete(todo)
                        dismiss()
                    }
                }
            }
        }

    }
}

#Preview {
    NavigationStack {
        ToDoDetails(todo: SampleData.shared.todo)
    }
}

#Preview("New ToDo") {
    NavigationStack {
        ToDoDetails(todo: SampleData.shared.todo, isNew: true)
    }
}
