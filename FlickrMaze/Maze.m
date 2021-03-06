//
//  Maze.m
//  FlickrMaze
//
//  Created by Minhung Ling on 2017-02-03.
//  Copyright © 2017 Minhung Ling. All rights reserved.
//

#import "Maze.h"
#import <UIKit/UIKit.h>
#import "GameManager.h"

@interface Maze ()
@property (nonatomic) NSDictionary <NSNumber *, NSArray<NSNumber*>*>*invalidSquareDictionary;
@property (nonatomic) GameManager *manager;
@end

@implementation Maze

- (instancetype)init
{
    self = [super init];
    if (self) {
        _manager = [GameManager sharedManager];
    }
    return self;
}

- (NSArray *) makeMazeWith: (NSArray <MazeTile*> *)mazeTileArray {
    [self createBasicInvalidSquares];
    NSMutableArray *columnArray = [NSMutableArray new];
    int x = 0;
    for (int section = 0; section < 10; section+=1) {
        NSMutableArray *rowArray = [NSMutableArray new];
        for (int row = 0; row <10; row+=1) {
            MazeTile *tile = mazeTileArray[x];
            tile.xPosition = row;
            tile.yPosition = section;
            if ([self.invalidSquareDictionary[@(section)] containsObject:@(row)]) {
                tile.valid = NO;
                tile.image = self.invalidSquareImage;
            }
            if (section == self.endY && row == self.endX) {
                UIImage *trophy = [UIImage imageNamed:@"Trophy"];
                NSData *data = UIImagePNGRepresentation(trophy);
                tile.image = data;
            }
            [rowArray addObject:tile];
            x+=1;
        }
        [columnArray addObject:rowArray];
    }
    [self.manager saveContext];
    return columnArray;
}

- (void) createBasicInvalidSquares {
    int selection = [self getTheme];
    int mazeID = arc4random_uniform(5)+1;
    self.manager.player.mazeID = mazeID;
    self.manager.player.themeID = selection;
    [self selectThemeWithID:selection];
    [self selectMazeWithID:self.manager.player.mazeID];
}

- (int) getTheme {
    NSString *theme = self.manager.gameTheme;
    if ([theme isEqualToString:@"Donald_Trump"]) {
        return 0;
    }
    else if ([theme isEqualToString:@"Cats"]) {
        return 1;
    }
    else if ([theme isEqualToString:@"Jaws"]) {
        return 2;
    }
        return 5;
}

- (void) selectThemeWithID:(NSInteger) themeID {
    switch (themeID) {
        case 0:
        {
            UIImage *goImage = [UIImage imageNamed:@"Donald_Trump_game_over"];
            self.gameOverImage = UIImagePNGRepresentation(goImage);
            UIImage *image = [UIImage imageNamed:@"Donald_Trump_invalid"];
            NSData *data = UIImagePNGRepresentation(image);
            self.invalidSquareImage = data;
            UIImage *cliffImage = [UIImage imageNamed:@"Cliff"];
            NSData *cliffData = UIImagePNGRepresentation(cliffImage);
            self.outOfBoundsImage = cliffData;
            UIImage *pathImage = [UIImage imageNamed:@"Donald_Trump_path"];
            NSData *pathData = UIImagePNGRepresentation(pathImage);
            self.pathImage = pathData;
            UIImage *ghostImage = [UIImage imageNamed:@"Donald_Trump_ghost"];
            NSData *ghostData = UIImagePNGRepresentation(ghostImage);
            self.ghostImage = ghostData;
            NSDataAsset *musicData = [[NSDataAsset alloc] initWithName:@"Donald_Trump_music"];
            self.music = musicData;
            self.manager.player.mazeID = 0;
            self.sounds =  @[@"Donald_Trump_out_of_bounds",@"Donald_Trump_invalid_sound",@"Donald_Trump_ghost_start",@"Donald_Trump_ghost_move",@"Donald_Trump_ghost_close", @"Donald_Trump_game_over_defeat"];
            return;
        }
        case 1:
        {   UIImage *goImage = [UIImage imageNamed:@"Game_over"];
            self.gameOverImage = UIImagePNGRepresentation(goImage);
            UIImage *image = [UIImage imageNamed:@"Cats_invalid"];
            NSData *data = UIImagePNGRepresentation(image);
            self.invalidSquareImage = data;
            UIImage *cliffImage = [UIImage imageNamed:@"Cliff"];
            NSData *cliffData = UIImagePNGRepresentation(cliffImage);
            self.outOfBoundsImage = cliffData;
            UIImage *pathImage = [UIImage imageNamed:@"Cats_path"];
            NSData *pathData = UIImagePNGRepresentation(pathImage);
            self.pathImage = pathData;
            UIImage *ghostImage = [UIImage imageNamed:@"Cats_ghost"];
            NSData *ghostData = UIImagePNGRepresentation(ghostImage);
            self.ghostImage = ghostData;
            NSDataAsset *musicData = [[NSDataAsset alloc] initWithName:@"Cats_music"];
            self.music = musicData;
             self.sounds = @[@"Cats_out_of_bounds",@"Cats_invalid_sound",@"Cats_ghost_start",@"Cats_ghost_move",@"Cats_ghost_close",@"Cats_game_over_defeat",@"Cats_game_over_victory"];

            return;
            break;
        }
            
        case 2:
        {   UIImage *goImage = [UIImage imageNamed:@"Game_over"];
            self.gameOverImage = UIImagePNGRepresentation(goImage);
            UIImage *image = [UIImage imageNamed:@"Jaws_invalid"];
            NSData *data = UIImagePNGRepresentation(image);
            self.invalidSquareImage = data;
            self.outOfBoundsImage = data;
            UIImage *pathImage = [UIImage imageNamed:@"Jaws_path"];
            NSData *pathData = UIImagePNGRepresentation(pathImage);
            self.pathImage = pathData;
            UIImage *ghostImage = [UIImage imageNamed:@"Jaws_ghost"];
            NSData *ghostData = UIImagePNGRepresentation(ghostImage);
            self.ghostImage = ghostData;
            NSDataAsset *musicData = [[NSDataAsset alloc] initWithName:@"Jaws_music"];
            self.music = musicData;
            self.sounds =  @[@"Jaws_out_of_bounds",@"Jaws_out_of_bounds",@"Jaws_ghost_start",@"Jaws_ghost_move",@"Jaws_ghost_close",@"Congratulations"];
            return;
            break;
        }
            
        default:{
            UIImage *goImage = [UIImage imageNamed:@"Game_over"];
            self.gameOverImage = UIImagePNGRepresentation(goImage);
            UIImage *image = [UIImage imageNamed:@"Default_invalid"];
            NSData *data = UIImagePNGRepresentation(image);
            self.invalidSquareImage = data;
            UIImage *cliffImage = [UIImage imageNamed:@"Cliff"];
            NSData *cliffData = UIImagePNGRepresentation(cliffImage);
            self.outOfBoundsImage = cliffData;
            UIImage *pathImage = [UIImage imageNamed:@"Default_path"];
            NSData *pathData = UIImagePNGRepresentation(pathImage);
            self.pathImage = pathData;
            NSDataAsset *musicData = [[NSDataAsset alloc] initWithName:@"Default_music"];
            self.music = musicData;
            self.sounds =  @[@"Default_out_of_bounds",@"Default_invalid_sound",@"Default_ghost_start",@"Default_ghost_move",@"Default_ghost_close",@"Default_game_over_defeat",@"Default_game_over_victory"];

            UIImage *ghostImage = [UIImage imageNamed:@"Default_ghost"];
            NSData *ghostData = UIImagePNGRepresentation(ghostImage);
            self.ghostImage = ghostData;

            return;
            break;
        }
    }
}

- (void) selectMazeWithID:(NSInteger)mazeID {
    switch (mazeID) {
        case 0: {
            self.minMoves = 100;
            self.startX = 0;
            self.startY = 9;
            self.endX = 9;
            self.endY = 0;
            self.invalidSquareDictionary = @{@0: @[@0, @1, @2, @3, @4, @5, @6, @7, @8],
                                             @1: @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9],
                                             @2: @[@9],
                                             @3: @[@1, @2, @3, @5, @6, @7],
                                             @4: @[@2, @6],
                                             @5: @[@4],
                                             @6: @[@3, @4, @5],
                                             @8:@[@2, @3, @4, @5, @6],
                                             };
            break;
        }
        case 1: {
            self.minMoves = 22;
            self.startX = 0;
            self.startY = 9;
            self.endX = 9;
            self.endY = 0;
            self.invalidSquareDictionary = @{@0: @[@4, @5, @6, @7, @8],
                                             @1: @[@1, @2, @6],
                                             @2: @[@1, @2, @3, @4, @6, @8],
                                             @3: @[@4, @8],
                                             @4: @[@0, @2, @4, @6],
                                             @5: @[@2, @6, @7],
                                             @6: @[@1, @2, @4, @6, @7, @8],
                                             @7: @[@1, @4, @8],
                                             @8: @[@1, @3, @4, @6 ,@8],
                                             @9: @[@1, @6]
                                             };
            break;
        }
        case 2: {
            self.minMoves = 17;
            self.startX = 4;
            self.startY = 9;
            self.endX = 0;
            self.endY = 0;
            self.invalidSquareDictionary = @{//@0: @[],
                                             @1: @[@0, @1, @2, @4, @5, @6, @7, @8],
                                             @2: @[@2, @4, @8],
                                             @3: @[@1, @2, @4, @5, @6, @8],
                                             @4: @[@8],
                                             @5: @[@0, @1, @2, @3, @4, @5, @7, @8],
                                             @6: @[@0, @5],
                                             @7: @[@0, @2, @3, @4, @5, @7, @8],
                                             @8: @[@0, @7],
                                             @9: @[@0, @1, @2, @3, @5, @6, @7, @8, @9]
                                             };
            break;
        }
        case 3: {
            self.minMoves = 18;
            self.startX = 0;
            self.startY = 9;
            self.endX = 9;
            self.endY = 0;
            self.invalidSquareDictionary = @{@0: @[@3, @7],
                                             @1: @[@1, @3, @5, @7, @9],
                                             //@2: @[],
                                             @3: @[@0, @1, @3, @5, @6, @7, @8, @9],
                                             @4: @[@3],
                                             @5: @[@1, @3, @5, @7, @9],
                                             //@6: @[],
                                             @7: @[@0, @1, @3, @4, @5, @7, @9],
                                             @8: @[@7],
                                             @9: @[@1, @2, @3, @4, @5, @6, @7, @8, @9]
                                             };
            break;
        }
        case 4: {
            self.minMoves = 14;
            self.startX = 5;
            self.startY = 8;
            self.endX = 9;
            self.endY = 0;
            self.invalidSquareDictionary = @{@0: @[@3, @4, @5, @6, @7],
                                             @1: @[@1, @3, @9],
                                             @2: @[@1, @3, @6, @8, @9],
                                             @3: @[@1, @3, @4, @6],
                                             @4: @[@6],
                                             @5: @[@1],
                                             @6: @[@1, @2, @3, @4, @5, @6, @7, @9],
                                             @7: @[@3, @7],
                                             //@8: @[],
                                             @9: @[@3, @7]
                                             };
            break;
        }
        case 5: {
            self.minMoves = 14;
            self.startX = 9;
            self.startY = 9;
            self.endX = 4;
            self.endY = 4;
            self.invalidSquareDictionary = @{@0: @[@9],
                                             @1: @[@1, @2, @4, @6, @7, @9],
                                             @2: @[@1, @7, @9],
                                             @3: @[@3, @5, @9],
                                             @4: @[@1 ,@5, @7 ,@9],
                                             @5: @[@3, @4, @5, @7, @9],
                                             @6: @[@1, @9],
                                             @7: @[@1, @2, @4, @5, @7, @9],
                                             // @8: @[],
                                             @9: @[@0, @1, @2 , @3, @4, @5, @6, @7]
                                             };
            break;
        }
        default: {
            self.minMoves = 22;
            self.startX = 0;
            self.startY = 9;
            self.endX = 9;
            self.endY = 0;
            self.invalidSquareDictionary = @{@0: @[@4, @5, @6, @7, @8],
                                             @1: @[@1, @2, @6],
                                             @2: @[@1, @2, @3, @4, @6, @8],
                                             @3: @[@4, @8],
                                             @4: @[@0, @2, @4, @6],
                                             @5: @[@2, @6, @7],
                                             @6: @[@1, @2, @4, @6, @7, @8],
                                             @7: @[@1, @4, @8],
                                             @8: @[@1, @3, @4, @6 ,@8],
                                             @9: @[@1, @6]
                                             };
            break;
        }
    }
}

-(NSDictionary<NSNumber *,NSArray<NSNumber *> *> *)getDictionary{
    return self.invalidSquareDictionary;
}

-(void)makeSoundDictionary:(NSArray*)themeSounds{
    NSMutableDictionary *dictonary = [NSMutableDictionary new];
    for(NSString *soundName in themeSounds){
        NSDataAsset *sound = [[NSDataAsset alloc] initWithName:soundName];
        [dictonary setObject:sound forKey:soundName];
    }
    self.sounds =  [dictonary copy];
}

@end
