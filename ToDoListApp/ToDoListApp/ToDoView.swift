//
//  ToDo.swift
//  ToDoListApp
//
//  Created by Krzysztof on 17/10/2024.
//

import SwiftUICore
import SwiftData
import SwiftUI

enum Priority: Int, Codable {
    case low = 0
    case medium = 1
    case high = 2
}

@Model
class ToDo {
    
    var title: String
    var desc: String?
    var priority: Priority
    var finishDate: Date?
    var deadline: Date?
    var todayDate = Date()
    
    var taskChecked: Bool = false
    
    init(title: String, desc: String?, priority: Priority, finishDate: Date?, deadline: Date?) {
        self.title = title
        self.desc = desc
        self.priority = priority
        self.finishDate = finishDate
        self.deadline = deadline
    }
    
    init(title: String, priority: Priority) {
        self.title = title
        self.priority = priority
    }
    
    init(title: String, priority: Priority, finishDate: Date?) {
        self.title = title
        self.priority = priority
        self.finishDate = finishDate
    }
    
    init(title: String, priority: Priority, deadline: Date?) {
        self.title = title
        self.priority = priority
        self.deadline = deadline
    }
    
    static let sampleData: [ToDo] = [
        ToDo(title: "some title", desc: "some desc", priority: .low, finishDate: getDate(from: "15/10/2024"), deadline: getDate(from: "13/10/2024")),
        ToDo(title: "Ex. Title", desc: "ex desc", priority: .high, finishDate: getDate(from: "21/11/2025"), deadline: getDate(from: "05/01/2025")),
        ToDo(title: "Ex. Title", desc: "ex desc", priority: .medium, finishDate: getDate(from: "21/12/2024"), deadline: getDate(from: "05/11/2024")),
        ToDo(title: "Plan Vacation", desc: "Book flights and hotels", priority: .high, finishDate: getDate(from: "20/12/2024"), deadline: getDate(from: "01/12/2024")),
        ToDo(title: "Grocery Shopping", desc: "Buy essentials for the week", priority: .medium, finishDate: getDate(from: "18/10/2024"), deadline: getDate(from: "17/10/2024")),
//        ToDo(title: "Team Meeting", desc: "Prepare agenda for review", priority: Priority.Low, finishDate: getDate(from: "10/11/2024"), deadline: getDate(from: "05/11/2024")),
//        ToDo(title: "Doctor Appointment", desc: "Annual checkup at clinic", priority: Priority.High, finishDate: getDate(from: "02/01/2025"), deadline: getDate(from: "29/12/2024")),
//        ToDo(title: "Submit Report", desc: "Finalize quarterly report", priority: Priority.Medium, finishDate: getDate(from: "15/01/2025"), deadline: getDate(from: "10/01/2025")),
//        ToDo(title: "Read Book", desc: "Finish reading for book club", priority: Priority.Low, finishDate: getDate(from: "30/11/2024"), deadline: getDate(from: "25/11/2024")),
//        ToDo(title: "Renew Insurance", desc: "Renew car insurance policy", priority: Priority.Medium, finishDate: getDate(from: "15/02/2025"), deadline: getDate(from: "10/02/2025")),
//        ToDo(title: "Workout Session", desc: "Complete strength training", priority: Priority.Low, finishDate: getDate(from: "19/10/2024"), deadline: getDate(from: "19/10/2024")),
//        ToDo(title: "Client Presentation", desc: "Prepare slides for review", priority: Priority.High, finishDate: getDate(from: "01/12/2024"), deadline: getDate(from: "27/11/2024"))
    ]
}

struct ToDoView: View {
    let todo: ToDo
    
    var finalDesc: String {
        if todo.desc == nil {
            return ""
        } else {
            return todo.desc ?? ""
        }
    }
    
    var daysToOrAfterDeadline: String {
        if todo.deadline == nil {            
            return ""
        }
        let diffInDays = Calendar.current.dateComponents([.day], from: todo.todayDate, to: todo.deadline!).day
        if diffInDays! == 0 {
            return "deadline today"
        } else if diffInDays! == 1 {
            return "\(diffInDays!) day to deadline"
        } else if diffInDays! > 1 {
            return "\(diffInDays!) days to deadline"
        } else if diffInDays == -1 {
            return "\(abs(diffInDays!)) day after deadline"
        } else {
            return "\(abs(diffInDays!)) days after deadline"
        }
        
    }
    
    var dotColor: Color {
        switch todo.priority {
        case .high:
            Color("High priority")
        case .medium:
            Color("Medium priority")
        case .low:
            Color("Low priority")
        }
    }
    
    var finishDateFinal: String {
        if todo.finishDate == nil {
            return ""
        }
        let diffInDays = Calendar.current.dateComponents([.day], from: todo.todayDate, to: todo.finishDate!).day
        let finishInfo = "Finish time: "
        if diffInDays == 0 {
            return finishInfo + "today"
        } else if diffInDays == 1 {
            return finishInfo + "tomorrow"
        } else if diffInDays == 2 {
            return finishInfo + "day after tomorrow"
        } else {
            let currentYear = Calendar.current.component(.year, from: todo.todayDate)
            
            let finishYear =
            Calendar.current.component(.year, from: todo.finishDate!)
            
            let dateFormatter = DateFormatter()
            if currentYear == finishYear {
                dateFormatter.dateFormat = "dd/MM"
            } else {
                dateFormatter.dateFormat = "dd/MM/yyyy"
            }
            return finishInfo + dateFormatter.string(from: todo.finishDate!)
        }
    }
    

    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    CheckBoxView(isChecked: todo.taskChecked)
                        .onTapGesture {
                            todo.taskChecked = !todo.taskChecked
                        }
                    Text(todo.title)
                        .foregroundStyle(todo.taskChecked ? .gray : dotColor)
                        .strikethrough(todo.taskChecked)
                    Spacer()
                    Image(systemName: "dot.circle.fill")
                        .foregroundStyle(todo.taskChecked ? .gray : dotColor)
                        .strikethrough(todo.taskChecked)
                }
                .font(Font.title2)
                .fontWeight(Font.Weight.semibold)
                if !finalDesc.isEmpty{
                    Text(finalDesc)
                        .strikethrough(todo.taskChecked)
                }
                if !finishDateFinal.isEmpty {
                    Text(finishDateFinal)
                        .strikethrough(todo.taskChecked)
                }
                if !daysToOrAfterDeadline.isEmpty {
                    Text(daysToOrAfterDeadline)
                        .strikethrough(todo.taskChecked)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(17)
           .background(Rectangle().fill(Color("Frame bg")).shadow(radius: 3))
            .cornerRadius(15)
            .opacity(0.8)
        }
        .padding(.bottom, 12)
    }
}

