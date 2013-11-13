//
//  CalcComb.h
//  MacSums
//
//  Created by Michael on 3/12/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CombArray.h"


@interface CalcComb : NSObject {
	NSObject **data;
	int *sizes;
	int width;
}

-(id)initWithArray:(NSArray *) inbound;
-(void)dealloc;


-(int)count;	// how many possible combs
-(int)size;		// the size of each comb
-(CombArray*)getCombAt:(int)pos;


@end
