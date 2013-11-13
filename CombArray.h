//
//  CombArray.h
//  MacSums
//
//  Created by Michael on 3/13/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface CombArray : NSObject {
	int *data;
	int asize;
}

-(id)initWithArray:(int*)a size:(int)s;
-(void)dealloc;

-(bool)hasDup;
-(int*)getData;


@end
