//
//  ContentView.swift
//  standford_course_2025
//
//  Created by Wael Maarouf on 08/02/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red, .green, .blue, .yellow])
            pegs(colors: [.red, .green, .blue, .purple])

        }
        .padding()
    }

    func pegs(colors: [Color] = []) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkers(matches: [.exact, .nomatch, .inexact])

        }
    }
}

#Preview {
    ContentView()
}
