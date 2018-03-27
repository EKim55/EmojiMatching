//
//  ViewController.swift
//  EmojiMatching
//
//  Created by CSSE Department on 3/26/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var emojiButtons: [UIButton]!
    
    var game = MatchingGame(numPairs: 10)
    
    var blockUI = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0..<game.cards.count {
            emojiButtons[i].setTitle("\(game.cardBack)", for: .normal)
        }
        print("\(game.description)")
        updateEmojis()
    }

    @IBAction func pressedEmoji(_ sender: Any) {
        if (blockUI == true) {
            return
        }
        let emojiButton = sender as! UIButton
        game.pressedCard(atIndex: emojiButton.tag)
        updateEmojis()
    }
    
    @IBAction func pressedNewGame(_ sender: Any) {
        if (blockUI == true) {
            return
        }
        game = MatchingGame(numPairs: 10)
        print("\(game.description)")
        updateEmojis()
    }
    
    func updateEmojis() {
        let firstIndex = game.firstIndex
        let firstSelection = game.firstSelection
        let secondIndex = game.secondIndex
        let secondSelection = game.secondSelection
        switch (game.gameState) {
        case .first:
            for i in 0..<game.cards.count {
                if (game.cardStates[i] == .hidden) {
                    emojiButtons[i].setTitle("\(game.cardBack)", for: .normal)
                }
            }
            return
        case .second(_):
            emojiButtons[firstIndex].setTitle("\(firstSelection)", for: .normal)
        case .turnComplete(_,_):
            game.startNewTurn()
            emojiButtons[secondIndex].setTitle("\(secondSelection)", for: .normal)
            blockUI = true
            delay(1.2) {
                if (self.game.cardStates[firstIndex] == .matched) {
                    self.emojiButtons[firstIndex].setTitle("", for: .normal)
                    self.emojiButtons[secondIndex].setTitle("", for: .normal)
                }
                else {
                    self.emojiButtons[firstIndex].setTitle("\(self.game.cardBack)", for: .normal)
                    self.emojiButtons[secondIndex].setTitle("\(self.game.cardBack)", for: .normal)
                }
                self.blockUI = false
            }
        }
    }
    
    func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}

