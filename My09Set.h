//
//  MyArray.h
//  MacSums
//
//  Created by Michael on 3/7/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface My09Set : NSObject {
	int		bitfield;
}

-(id)init;

-(id)initWith0IntArray:(int *)array andCount:(int) c;
-(id)initWithNSArray:(NSArray *)array;


-(void)setBit:(int)atIndex;
-(void)setBit:(BOOL)value atIndex:(int)index;
-(void)clearBit:(int)atIndex;
-(void)reset;
-(BOOL)isBitSet:(int)atIndex;
-(BOOL)intersects:(My09Set *)other;
-(int)getCount;

-(int)nthElement:(int)index;


-(int)sumArray;

-(NSString*)toDBGString;
-(NSString*)toBinaryString:(int)value;
-(NSString*)toPrintString;

@end
