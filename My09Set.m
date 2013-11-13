//
//  MyArray.m
//  MacSums
//
//  Created by Michael on 3/7/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "My09Set.h"

@implementation My09Set

-(id)init
{
	bitfield = 0;
	[super init];
	return self;
}

-(id)initWith0IntArray:(int *)array andCount:(int) c
{
	[self init];
	
	for(int i = 0; i < c; i++)
	{
		bitfield |= (1 << i);
	}
	return self;
}

-(id)initWithNSArray:(NSArray *)array
{
	[self init];
	for(int i = 0; i < [array count]; i++)
	{
		bitfield |= (1 << [[array objectAtIndex:i] intValue]);
	}
	return self;
}

-(void)setBit:(int)atIndex
{
	//NSLog(@"Setbit at %d called. bitfield = %d",atIndex,bitfield);
	bitfield |= (1 << atIndex);
	//NSLog(@"Setbit at %d done. bitfield = %d",atIndex,bitfield);
}


-(void)setBit:(BOOL)value atIndex:(int)index
{ 
	//NSLog(@"Setbit value at %d called. bitfield = %d",index,bitfield);

	if(value)
	{
		bitfield |= (1 << index);
	}
	else {
		bitfield &= ~(1 << index);
	}
	//NSLog(@"Setbit value at %d done. bitfield = %d",index,bitfield);

}

-(void)clearBit:(int)atIndex 
{
	bitfield &= ~(1 << atIndex);
}

-(void)reset
{
	bitfield = 0;
}

-(BOOL)isBitSet:(int)atIndex
{ 
	/*
	NSLog(@"isBitSet called with %d",atIndex);
	NSLog(@"isBitSet bitfield: %@",[self toBinaryString:bitfield]);
	NSLog(@"isBitSet andfield: %@",[self toBinaryString:(1 << atIndex)]);
	NSLog(@"isBitSet return: %d (%s)",
		  (bitfield & (1 << atIndex)),
		  ((bitfield & (1 << atIndex))?"true":"false")
		  );
	 */
	return ((bitfield & (1 << atIndex))?1:0);
}

-(int)nthElement:(int)index
{
	int s = 0;
	for(int i = 0; i < 9; i++)
	{
		if(bitfield & (1 << i))
		{
			if(s == index) { return i; }
			s++;
		}
	}
	return -1;
}

-(int)sumArray
{
	int s = 0;
	for(int i = 0; i < 9; i++)
	{
		if(bitfield & (1 << i)) { s += i+1; }
	}
	return s;
}

-(int)getCount
{
	int s = 0;
	for(int i = 0; i < 9; i++)
	{
		if(bitfield & (1 << i)) { s++; }
	}
	return s;
}

-(NSString*)toPrintString
{
	NSMutableString *a;
	a = [NSMutableString stringWithString:@""];
	for(int i = 0; i < 9; i++)
	{
		if(bitfield & (1 << i))
		{
			[a appendFormat:@"%d",i+1];
		}
		else {
			[a appendString:@"-"];
		}
		
	}
	return a;
}


-(NSString*)toDBGString
{
	NSMutableString *a;
	NSMutableString *d;
	a = [NSMutableString stringWithString:@""];
	d = [NSMutableString stringWithString:@" "];
	for(int i = 0; i < 9; i++)
	{
		if(bitfield & (1 << i))
		{
			[a appendString:@"1"];
			[d appendString: [NSString stringWithFormat:@"%d", i+1]];
		}
		else {
			[a appendString:@"0"];
		}
	}
	if([d isEqualToString:@" "])
	{
		[d appendString:@"-"];
	}
	[a appendString:d];
	return a;
}

-(NSString*)toBinaryString:(int)value
{
	NSMutableString *a;
	a = [NSMutableString stringWithString:@""];
	for(int i = 0; i < 9; i++)
	{
		if(value & (1 << i))
		{
			[a appendString:@"1"];
		}
		else {
			[a appendString:@"0"];
		}
	}
	return a;
}

-(BOOL)intersects:(My09Set *)other
{
	for(int i = 0; i < 9; i ++)
	{
		if([self isBitSet:i] && [other isBitSet:i]) { return YES; }
	}
	return NO;
}

@end
