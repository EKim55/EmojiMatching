//
//  MatchingGame.swift
//  EmojiMatching
//
//  Created by CSSE Department on 3/26/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import Foundation

class MatchingGame: CustomStringConvertible {
    
    enum CardState: String {
        case hidden = "Hidden"
        case revealed = "Revealed"
        case matched = "Matched"
    }
    
    enum GameState {
        case first
        case second(Int)
        case turnComplete(Int, Int)
        
        func simpleDescription() -> String {
            switch(self) {
            case .first:
                return "Waiting for first selection."
            case .second(let firstIndex):
                return "Waiting for second selection. First click = \(firstIndex)"
            case .turnComplete(let firstIndex, let secondIndex):
                return "Turn complete. First click = \(firstIndex)  Second click = \(secondIndex)"
            }
        }
    }
    
    var gameState : GameState
    
    var numPairs: Int
    
    let allCardBacks = Array("🎆🎇🌈🌅🌇🌉🌃🌄⛺⛲🚢🌌🌋🗽")
    let allEmojiCharacters = Array("🚁🐴🐇🐢🐱🐌🐒🐞🐫🐠🐬🐩🐶🐰🐼⛄🌸⛅🐸🐳❄❤🐝🌺🌼🌽🍌🍎🍡🏡🌻🍉🍒🍦👠🐧👛🐛🐘🐨😃🐻🐹🐲🐊🐙")
    
    var cardBack : Character
    var cards : [Character]
    var cardStates : [CardState]
    var firstSelection : Character
    var firstIndex : Int
    var secondSelection : Character
    var secondIndex : Int
    
    init(numPairs: Int) {
        self.numPairs = numPairs
        gameState = .first
        
        let index = Int(arc4random_uniform(UInt32(allCardBacks.count)))
        cardBack = allCardBacks[index]
        
        var emojiSymbolsUsed = [Character]()
        while emojiSymbolsUsed.count < numPairs {
            let index = Int(arc4random_uniform(UInt32(allEmojiCharacters.count)))
            let symbol = allEmojiCharacters[index]
            if !emojiSymbolsUsed.contains(symbol) {
                emojiSymbolsUsed.append(symbol)
            }
        }
        cards = emojiSymbolsUsed + emojiSymbolsUsed
        cards.shuffle()
        
        cardStates = [CardState]()
        for _ in 0..<cards.count {
            cardStates.append(.hidden)
        }
        
        firstSelection = cards[0]
        firstIndex = 0
        
        secondSelection = cards[0]
        secondIndex = 0
    }
    
    func pressedCard(atIndex: Int) {
        switch(cardStates[atIndex]) {
        case .hidden:
            switch(gameState) {
            case .first:
                firstSelection = cards[atIndex]
                firstIndex = atIndex
                gameState = .second(firstIndex)
                break
            case .second:
                secondSelection = cards[atIndex]
                secondIndex = atIndex
                gameState = .turnComplete(firstIndex, secondIndex)
                break
            case .turnComplete:
                break
            }
            cardStates[atIndex] = .revealed
            return
        case .revealed:
            return
        case .matched:
            return
        }
    }
    
    func startNewTurn() {
        if (firstSelection == secondSelection) {
            cardStates[firstIndex] = .matched
            cardStates[secondIndex] = .matched
        }
        else {
            cardStates[firstIndex] = .hidden
            cardStates[secondIndex] = .hidden
        }
        gameState = .first
    }
    
    var description: String {
        return "\(cards[0]) \(cards[1]) \(cards[2]) \(cards[3])\n\(cards[4]) \(cards[5]) \(cards[6]) \(cards[7])\n\(cards[8]) \(cards[9]) \(cards[10]) \(cards[11])\n\(cards[12]) \(cards[13]) \(cards[14]) \(cards[15])\n\(cards[16]) \(cards[17]) \(cards[18]) \(cards[19])\n"
    }
}

extension Array {
    mutating func shuffle() {
        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            self.swapAt(i, j)
        }
    }
}

