//
//  MatchingGame.h
//  EmojiMatching
//
//  Created by CSSE Department on 4/4/18.
//  Copyright © 2018 CSSE Department. All rights reserved.
//

#import <Foundation/Foundation.h>
#define MAX_NUM_PAIRS 100

typedef NS_ENUM(NSInteger, CardState) {
    CardStateHidden,
    CardStateRevealed,
    CardStateMatched,
};

typedef NS_ENUM(NSInteger, GameState) {
    GameStateFirst,
    GameStateSecond,
    GameStateTurnComplete,
};

@interface MatchingGame : NSObject {
    CardState cardStates[MAX_NUM_PAIRS];
}

- (id) initWithNumPairs:(NSInteger) numPairs;
- (void) pressedCard:(NSInteger) atIndex;
- (void) startNewTurn;
- (CardState) getCardStateAtIndex:(NSInteger) atIndex;

@property (nonatomic) GameState gameState;
@property (nonatomic) NSInteger numPairs;
@property (nonatomic) NSArray* cards;
@property (nonatomic) NSString* cardBack;
@property (nonatomic) NSString* firstSelection;
@property (nonatomic) NSInteger firstIndex;
@property (nonatomic) NSString* secondSelection;
@property (nonatomic) NSInteger secondIndex;

@end
