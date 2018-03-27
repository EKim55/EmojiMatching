//
//  MatchingGame.swift
//  EmojiMatching
//
//  Created by CSSE Department on 3/26/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import Foundation

class MatchingGame {
    
    enum CardState: String {
        case hidden = "Hidden"
        case revealed = "Revealed"
        case matched = "Matched"
    }
    
    enum GameState: String {
        case finished = "Game Won"
        case ongoing = "Game not beaten"
    }
    
    var gameState : GameState
    
    var numPairs: Int;
    
    let allCardBacks = Array("🎆🎇🌈🌅🌇🌉🌃🌄⛺⛲🚢🌌🌋🗽")
    let allEmojiCharacters = Array("🚁🐴🐇🐢🐱🐌🐒🐞🐫🐠🐬🐩🐶🐰🐼⛄🌸⛅🐸🐳❄❤🐝🌺🌼🌽🍌🍎🍡🏡🌻🍉🍒🍦👠🐧👛🐛🐘🐨😃🐻🐹🐲🐊🐙")
    
    var cardBack : Character
    var cards : [Character]
    var cardStates : [CardState]
    
    init(numPairs: Int) {
        self.numPairs = numPairs;
        
        gameState = .ongoing
        
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
        for i in 0..<cards.count {
            cardStates[i] = .hidden
        }
    }
    
    func pressedCard(atIndex: Int) {
        switch(cardStates[atIndex]) {
        case .hidden:
            for i in 0..<cards.count {
                if (cardStates[i] == .revealed) {
                    if (cards[i] == cards[atIndex]) {
                        cardStates[i] = .matched
                        cardStates[atIndex] = .matched
                        checkForGameOver()
                    }
                    else {
                        cardStates[i] = .hidden
                        cardStates[atIndex] = .hidden
                    }
                    return
                }
            }
            cardStates[atIndex] = .revealed
            return
        case .revealed:
            return
        case .matched:
            return
        }
    }
    
    func checkForGameOver() {
        for i in 0..<cards.count {
            if (cardStates[i] != .matched) {
                return
            }
        }
        gameState = .finished
        return
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

