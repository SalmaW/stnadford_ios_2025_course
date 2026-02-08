//
//  MatchMarkers.swift
//  standford_course_2025
//
//  Created by Wael Maarouf on 08/02/2026.
//

import SwiftUI

enum Match {
    case nomatch //$0
    case exact
    case inexact
}

struct MatchMarkers: View {
    var matches: [Match]  // Array<Match> == [Match]
    var body: some View {
        HStack {
            VStack {

                matchMarker(peg: 0)
                matchMarker(peg: 1)
                //                    Circle()
                //                    Circle().strokeBorder(.primary, lineWidth: 3).aspectRatio(1,contentMode: .fit)
            }
            VStack {
                matchMarker(peg: 2)
                matchMarker(peg: 3)
                //                    Circle()
                //                    Circle().opacity(0)
            }
        }
    }

    func matchMarker(peg: Int) -> some View {
        let exactCount: Int = matches.count { $0 == .exact }  // $0 is the same as the (first argument) Match.exact
        let foundCount: Int = matches.count{ $0 != .nomatch }

        return Circle()
            .fill(
                exactCount
                    > peg ? .primary : Color.clear
            )
            .strokeBorder(
                foundCount > peg ? .primary : Color.clear,
                lineWidth: 2
            )
            .aspectRatio(1, contentMode: .fit)
    }
    
    func isExact(match: Match) -> Bool{
        match == .exact
    }
}

#Preview {
    MatchMarkers(matches: [.exact, .nomatch, .inexact])
}
