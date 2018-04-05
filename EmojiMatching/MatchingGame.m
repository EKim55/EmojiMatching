//
//  MatchingGame.m
//  EmojiMatching
//
//  Created by CSSE Department on 4/4/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

#import "MatchingGame.h"

@implementation MatchingGame

- (id) initWithNumPairs:(NSInteger)numPairs {
    self = [super init];
    if (self) {
        self.numPairs = numPairs;
        NSArray* allCardBacks = [@"🎆,🎇,🌈,🌅,🌇,🌉,🌃,🌄,⛺,⛲,🚢,🌌,🌋,🗽"
                                 componentsSeparatedByString:@","];
        NSArray* allEmojiCharacters =
        [@"🚁,🐴,🐇,🐢,🐱,🐌,🐒,🐞,🐫,🐠,🐬,🐩,🐶,🐰,🐼,⛄,🌸,⛅,🐸,🐳,❄,❤,🐝,🌺,🌼,🌽,🍌,🍎,🍡,🏡,🌻,🍉,🍒,🍦,👠,🐧,👛,🐛,🐘,🐨,😃,🐻,🐹,🐲,🐊,🐙" componentsSeparatedByString:@","];
        
        NSMutableArray* emojiSymbolsUsed = [[NSMutableArray alloc] init];
        while (emojiSymbolsUsed.count < numPairs) {
            NSString* symbol = allEmojiCharacters[arc4random_uniform((UInt32) allEmojiCharacters.count)];
            if (![emojiSymbolsUsed containsObject:symbol]) {
                [emojiSymbolsUsed addObject:symbol];
            }
        }
        [emojiSymbolsUsed addObjectsFromArray:emojiSymbolsUsed];
        
        for (int i = 0; i < emojiSymbolsUsed.count; i++) {
            UInt32 j = arc4random_uniform((UInt32) emojiSymbolsUsed.count - i) + 1;
            [emojiSymbolsUsed exchangeObjectAtIndex:i withObjectAtIndex:j];
        }
        self.cards = [NSArray arrayWithArray:emojiSymbolsUsed];
        self.cardBack = allCardBacks[arc4random_uniform((UInt32) allCardBacks.count)];
        
        for (int i = 0; i < self.cards.count; i++) {
            cardStates[i] = CardStateHidden;
        }
        self.gameState = GameStateFirst;
        self.firstSelection = self.cards[0];
        self.firstIndex = 0;
        self.secondSelection = self.cards[0];
        self.secondIndex = 0;
    }
    return self;
}

- (void) pressedCard:(NSInteger)atIndex {
    switch (cardStates[atIndex]) {
        case CardStateHidden:
            switch (self.gameState) {
                case GameStateFirst:
                    self.firstSelection = self.cards[atIndex];
                    self.firstIndex = atIndex;
                    self.gameState = GameStateSecond;
                    break;
                case GameStateSecond:
                    self.secondSelection = self.cards[atIndex];
                    self.secondIndex = atIndex;
                    self.gameState = GameStateTurnComplete;
                    break;
                case GameStateTurnComplete:
                    break;
            }
            break;
        case CardStateRevealed:
            return;
        case CardStateMatched:
            return;
    }
}

- (void) startNewTurn {
    if (self.firstSelection == self.secondSelection) {
        cardStates[self.firstIndex] = CardStateMatched;
        cardStates[self.secondIndex] = CardStateMatched;
    }
    else {
        cardStates[self.firstIndex] = CardStateHidden;
        cardStates[self.secondIndex] = CardStateHidden;
    }
    self.gameState = GameStateFirst;
}

- (CardState) getCardStateAtIndex:(NSInteger)atIndex {
    return cardStates[atIndex];
}

- (NSString*) description {
    return [NSString stringWithFormat: @"%@ %@ %@ %@\n%@ %@ %@ %@\n%@ %@ %@ %@\n%@ %@ %@ %@\n%@ %@ %@ %@",
            self.cards[0], self.cards[1], self.cards[2], self.cards[3],
            self.cards[4], self.cards[5], self.cards[6], self.cards[7],
            self.cards[8], self.cards[9], self.cards[10], self.cards[11],
            self.cards[12], self.cards[13], self.cards[14], self.cards[15],
            self.cards[16], self.cards[17], self.cards[18], self.cards[19]];
}

@end
