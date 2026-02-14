//
//  CodeBreaker.swift
//  standford_course_2025
//
//  Created by Wael Maarouf on 08/02/2026.
//

import SwiftUI

extension Peg {
    static let missing = Color.clear
}

typealias Peg = Color
///anywhere i use  Peg, its actual type is Color

struct CodeBreaker {
    var masterCode: Code = Code(kind: .master)
    var guess: Code = Code(kind: .guess)
    var attempts: [Code] = []
    ///[Code]() == [Code] = []
    let pegChoices: [Peg] /*= [.red, .green, .blue, .yellow, .gray]*/

    init(pegChoices: [Peg] = [.red, .green, .blue, .gray]) {
        self.pegChoices = pegChoices
        masterCode.randomize(from: pegChoices)
        print(masterCode)
    }

    mutating func attemptGuess() {
        var attempt = guess
        attempt.kind = .attempt(guess.match(against: masterCode))

        attempts.append(attempt)
    }

    mutating func changeGuessPeg(at index: Int) {
        let existingPeg = guess.pegs[index]
        ///firstIndex returns self.index which is int
        if let indexOfExistingPegInPegChoices = pegChoices.firstIndex(
            of: existingPeg
        ) {

            let newPeg = pegChoices[
                (indexOfExistingPegInPegChoices + 1) % pegChoices.count
            ]
            guess.pegs[index] = newPeg
        } else {
            guess.pegs[index] = pegChoices.first ?? Code.missingPeg
        }

    }
}

struct Code {
    var pegs: [Peg] = Array(
        repeating: Peg.missing,
        count: 4
    ) /*[.green, .yellow, .gray, .red]*/
    var kind: Kind

    static let missingPeg: Peg = .clear

    enum Kind: Equatable {
        case master
        case guess
        case attempt([Match])
        case unknown
    }

    mutating func randomize(from pegChoices: [Peg]) {
        for index in pegChoices.indices {
            pegs[index] = pegChoices.randomElement() ?? Code.missingPeg
        }
    }

    var matches: [Match]? {
        switch kind {
        case .attempt(let matches): return matches
        default: return nil
        }
    }

    func match(against otherCode: Code) -> [Match] {
        var pegsToMatch = otherCode.pegs

        let backwardsExactMatches = pegs.indices.reversed().map { index in
            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
                pegsToMatch.remove(at: index)
                return Match.exact
            } else {
                return .nomatch
            }
        }

        //        for index in pegs.indices.reversed() {
        //            if pegsToMatch.count > index, pegsToMatch[index] == pegs[index] {
        //                results[index] = .exact
        //                pegsToMatch.remove(at: index)
        //            }
        //        }

        let exactMatches = Array(backwardsExactMatches.reversed())
        return pegs.indices.map { index in
            if exactMatches[index] != .exact, ///comma acts as &&
                let matchIndex = pegsToMatch.firstIndex(of: pegs[index])
            {
                pegsToMatch.remove(at: matchIndex)
                return .inexact
            } else {
                return exactMatches[index]

            }
        }
//        for index in pegs.indices {
//            if results[index] != .exact {
//                if let matchIndex = pegsToMatch.firstIndex(of: pegs[index]) {
//                    results[index] = .inexact
//                    pegsToMatch.remove(at: matchIndex)
//                }
//
//            }
//        }
//        return results

    }
}
