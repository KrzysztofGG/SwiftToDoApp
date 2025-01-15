//
//  CheckBoxVIew.swift
//  ToDoListApp
//
//  Created by Krzysztof on 03/11/2024.
//

import SwiftUICore

struct CheckBoxView: View {
    
    var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundColor(isChecked ? .blue : .gray)
        }
    }
}
