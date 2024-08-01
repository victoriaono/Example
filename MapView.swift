//
//  MapView.swift
//  Example
//
//  Created by Scholar on 7/4/24.
//

import SwiftUI

struct MapView: View {
    var body: some View {
        Link("Kode With Klossy", destination: URL(string: "https://www.learn.kodewithklossy.com")!)
            .foregroundStyle(.green)
        Link(destination: URL(string: "https://www.learn.kodewithklossy.com")!) {
            Image(systemName: "desktopcomputer")
                .foregroundStyle(.purple)
        }
    }
}

#Preview {
    MapView()
}
