//
//  ContentView.swift
//  Custom Calendar
//  Source: https://youtu.be/UZI2dvLoPr8?si=AbonOKFKN1kmBU5T
//
//  Created by Victoria Ono on 6/7/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var selectedDate = Date()
    
    var body: some View {
        VStack {
            CustomDatePicker(selectedDate: $selectedDate)
                .padding()
            Text(selectedDate.formatted(date: .abbreviated, time: .omitted))
        }
    }
}

#Preview {
    ContentView()
}

extension Date {
    func getAllDates() -> [Date] {
        let calendar = Calendar.current
        
        // get start date
        let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: self)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
}

struct DateValue: Identifiable {
    var id = UUID().uuidString
    var day: Int
    var date: Date
}
