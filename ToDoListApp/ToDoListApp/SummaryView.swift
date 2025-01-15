//
//  Summary.swift
//  ToDoListApp
//
//  Created by Krzysztof on 17/10/2024.
//

import SwiftUICore
import SwiftData
import SwiftUI

struct SummaryView: View {
    
    @Query private var toDos: [ToDo]
    @Environment(\.modelContext) private var context
    
    var upcomingTasks: Int {
        toDos.filter( {$0.finishDate != nil && $0.finishDate! >= Date()}).count
    }
    var overdueTasks: Int {
        toDos.filter( {$0.deadline != nil && $0.deadline! < Date()}).count
    }
    var highPriority: Int {
        toDos.filter( {$0.priority == .high}).count
    }
    var mediumPriority: Int {
        toDos.filter( {$0.priority == .medium}).count
    }
    var lowPriority: Int {
        toDos.filter( {$0.priority == .low}).count
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                Text("Summary")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.title)
                    .fontWeight(Font.Weight.medium)
                Text("\(upcomingTasks) upcoming")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(17)
                    .background(Rectangle().fill(Color("Frame bg")).shadow(radius: 3))
                    .cornerRadius(15)
                    .opacity(0.8)
                HStack {
                    Image(systemName: "calendar.badge.exclamationmark")
                        .foregroundStyle(Color("Overdue task"))
                    Text("\(overdueTasks) overdue")
                        .foregroundStyle(Color("Overdue task"))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(17)
                .background(Rectangle().fill(Color("Frame bg")).shadow(radius: 3))
                    .cornerRadius(15)
                    .opacity(0.8)
                HStack {
                    VStack(alignment: .leading) {
                        Text("!!")
                            .font(Font.headline)
                            .foregroundStyle(Color.red)
                        Text("!")
                            .font(Font.headline)
                            .foregroundStyle(Color.yellow)
                        Text("-")
                            .font(Font.headline)
                            .foregroundStyle(Color.blue)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("\(highPriority) high")
                        Text("\(mediumPriority) medium")
                        Text("\(lowPriority) low")
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 4)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(17)
                .background(Rectangle().fill(Color("Frame bg")).shadow(radius: 3))
                .cornerRadius(15)
                .opacity(0.8)


                Spacer()
            }
            Spacer()

        }
        .padding(.all, 10)
        .background(
            LinearGradient(gradient: Gradient(colors: [Color("Bg gradient top"), Color("Bg gradient bottom")]), startPoint: .top, endPoint: .bottom))
    }
}
