//
//  CustomDatePicker.swift
//  Example
//
//  Created by Scholar on 7/3/24.
//

import SwiftUI

struct CustomDatePicker: View {
    // variable to keep track of what date a user clicks on
    @Binding var selectedDate: Date
    
    @State private var month = 0
    @State private var currentDisplayedMonth = Date()
    
    let daysOfWeek = ["S", "M", "T", "W", "T", "F", "S"]
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    var body: some View {
        VStack {
            HStack {
                // show the previous month
                Button {
                    month -= 1
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.pink.opacity(0.7))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    // display the shown month and year
                    Text("\(extractMonthYear())")
                    
                    // display days of week
                    HStack(spacing: 0) {
                        ForEach(daysOfWeek.indices, id:\.self) { day in
                            Text(daysOfWeek[day])
                                .frame(maxWidth: .infinity)
                        }
                    }
                    
                    // display dates in numbers
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(extractDates()) { value in
                            VStack(spacing: 0) {
                                if value.day != -1 {
                                    ZStack {
                                        Circle()
                                            .fill(selectedDate == value.date ? .pink.opacity(0.3) : .clear) // using a ternary operator!
                                            
                                        Text("\(value.day)")
                                            .foregroundStyle(isToday(date: value.date) ? .pink.opacity(0.8) : .black)
                                    }
                                    .frame(width: 30, height: 30)
                                }
                            }
                            .onTapGesture {
                                // updates the selected date
                                selectedDate = value.date
                            }
                        }
                    }
                }
                
                // show the next month
                Button {
                    month += 1
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.pink.opacity(0.7))
                }
            }
        }
        .onChange(of: month) {
            // update the month to display
            currentDisplayedMonth = getCurrentMonth()
        }
    }
    
    // check whether a date is the same as today
    func isToday(date: Date) -> Bool {
        return Calendar.current.startOfDay(for: Date()) == Calendar.current.startOfDay(for: date)
    }
    
    // extract month and year to display
    func extractMonthYear() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM YYYY"
        return formatter.string(from: currentDisplayedMonth)
    }
    
    // update to a new month
    func getCurrentMonth() -> Date {
        guard let currentMonth = Calendar.current.date(byAdding: .month, value: month, to: Date()) else { return Date() }
        return currentMonth
    }
    
    // get an array of all dates in a given month
    func extractDates() -> [DateValue] {
        let currentMonth = getCurrentMonth()
        var dates = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = Calendar.current.component(.day, from: date)
            return DateValue(day: day, date: date)
        }
        
        // add offset days
        let firstWeekDay = Calendar.current.component(.weekday, from: dates.first?.date ?? Date())
        
        for _ in 0..<firstWeekDay-1 {
            dates.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return dates
    }
}
