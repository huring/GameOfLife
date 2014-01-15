/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#import "SimpleAudioEngine.h"

@interface HelloWorldLayer (PrivateMethods)
@end

NSMutableArray* grid;
NSMutableArray* numNeighbors;

#define Y_OFF_SET 21
#define WIDTH_WINDOW 320
#define HEIGHT_WINDOW 480
#define CELL_WIDTH 20
#define WIDTH_GAME WIDTH_WINDOW
#define HEIGHT_GAME (HEIGHT_WINDOW - 60)
#define NUM_ROWS (HEIGHT_GAME / CELL_WIDTH)
#define NUM_COLUMNS (WIDTH_GAME / CELL_WIDTH)
#define DELAY_IN_SECONDS 0.15

bool done = true;
float priorX = 500;
float priorY = 500;

@implementation HelloWorldLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        grid = [[NSMutableArray alloc] init];
        
        for (int k = 0; k < NUM_ROWS; k++) {
            
            NSMutableArray* subArray = [[NSMutableArray alloc] init];
        
            for (int s = 0; s < NUM_COLUMNS; s++) {
            
                NSNumber *item = [NSNumber numberWithInt: 0];
                [subArray addObject:item];
                
            }
            
            [grid addObject:subArray];
        
        }
        
        numNeighbors = [[NSMutableArray alloc] init];
        for (int k = 0; k < NUM_ROWS; k++) {
            
            NSMutableArray* subArray = [[NSMutableArray alloc] init];
            
            for (int s = 0; s < NUM_COLUMNS; s++) {
                
                NSNumber *item = @0;
                [subArray addObject:item];
                
            }
            
            [numNeighbors addObject:subArray];
            
        }
        
	}
    
	return self;
}

-(void) draw
{
    
    ccColor4F color = ccc4f(1, 1, 1, 100);
    
    // Set up rectangle
    CGPoint x = ccp(0, 0 + Y_OFF_SET);
    CGPoint y = ccp(WIDTH_GAME, HEIGHT_GAME);
    
    // Draw rectangle
    ccDrawSolidRect(x, y, color);
    
    // Draw lines
    ccDrawColor4B(0, 0, 0, 100);
    for (int row; row < HEIGHT_GAME; row += CELL_WIDTH) {
        
        CGPoint c = ccp(0, row + Y_OFF_SET);
        CGPoint d = ccp(WIDTH_GAME, row + Y_OFF_SET);
        
        ccDrawLine(c, d);
        
    }
    
    for (int col; col <= WIDTH_GAME; col += CELL_WIDTH) {
        
        CGPoint c = ccp(col + Y_OFF_SET, 0);
        CGPoint d = ccp(col + Y_OFF_SET, HEIGHT_GAME);
        
        ccDrawLine(c, d);
        
    }
    
    for (int row = 0; row < NUM_ROWS; row++) {
    
        for (int col = 0; col < NUM_COLUMNS; col++) {
        
            // [myArray objectAtIndex:index]; //'index' here is an int
            // int x = [myNSNumber integerValue];
            // NSMutableArray* array = [numNeighbors objectAtIndex:firstIndex];
            // [array replaceObjectAtIndex:secondIndex withObject:[NSNumber numberWithInt:myNumber]];
            
            NSNumber* num = [[grid objectAtIndex:row] objectAtIndex:col] ;
            
            if ([num integerValue] == 1) {
                
                // Set up rectangle
                CGPoint x = ccp(col * CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET);
                CGPoint y = ccp(col * CELL_WIDTH + CELL_WIDTH, row * CELL_WIDTH + Y_OFF_SET + CELL_WIDTH);
                
                ccColor4F color = ccc4f(0.5, 0.0, 1.0, 1.0);
                
                // Draw rectangle
                ccDrawSolidRect(x, y, color);
            
            }
        
        }
    
    }
    
    // Draw button
    ccColor4F startButtonColor = ccc4f(0.5, 0.0, 1.0, 1.0);
    ccDrawSolidRect(ccp(WIDTH_WINDOW / 2, HEIGHT_GAME + Y_OFF_SET), ccp(WIDTH_WINDOW, HEIGHT_WINDOW + Y_OFF_SET), startButtonColor);

    ccColor4F clearButtonColor = ccc4f(0.2, 0.0, 1.0, 1.0);
    ccDrawSolidRect(ccp(0, HEIGHT_GAME + Y_OFF_SET), ccp(WIDTH_WINDOW / 2, HEIGHT_WINDOW + Y_OFF_SET), clearButtonColor);
    
}


@end
