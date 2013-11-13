//
//  SumsUtil.m
//  MacSums
//
//  Created by Michael on 3/6/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "SumsUtil.h"
#import "My09Set.h"

@implementation SumsUtil

+(int) factorial:(int)n
{
	if(n == 0) return 1;
	return n * [self factorial:n-1];
}

+(int) minSum:(int)n
{
	int s = 0;
	for(int i = 0; i <= n; i++)
	{
		s += i;
	}
	return s;
}

+(int) maxSum:(int)n
{
	int s = 0;
	for(int i = 10 - n; i <= 9; i++)
	{
		s += i;
	}
	return s;
}


// generates sets not preserving order
+(NSPointerArray*) newCombinationCount:(int)selectionCount taken:(int)takenTimes
{
	int n = selectionCount;
	int r = takenTimes;
	
	int nF = [self factorial:n];
	int rF = [self factorial:r];
	int nmrF = [self factorial:n - r];
	int tc = nF / (rF * nmrF);
	
	NSMutableArray *a = [[NSMutableArray alloc] initWithCapacity:r];
	NSPointerArray* c = [[NSPointerArray alloc] init];
	
	for(int i = 0; i < takenTimes; i++)
	{
		//a[i] = i;
		[a insertObject:[NSNumber numberWithInt:i] atIndex:i];
	}
	
	[c addPointer:[[[My09Set alloc] initWithNSArray:a] autorelease]];	// start with first array
	for(int t = 1; t < tc; t++)
	{
		int i = takenTimes - 1;
		
		while ([[a objectAtIndex:i]intValue] == selectionCount - takenTimes + i) {
			i--;
		}
		//while(a[i] == selectionCount - takenTimes + i) { i--; }
		
		
		[a replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:[[a objectAtIndex:i] intValue]+1]];
		//a[i] = a[i]+1;
		for(int j = i + 1; j < takenTimes; j++)
		{
			[a replaceObjectAtIndex:j withObject:[NSNumber numberWithInt:[[a objectAtIndex:i] intValue] + j - i]];
			//a[j] = a[i] + j - i;
		}
		[c addPointer:[[[My09Set alloc] initWithNSArray:a ] autorelease]];
	}
	[a release];
	return c;
}

+(id)alloc
{
	[NSException raise:@"Cannot be instantiated" format:@"Static class SumsUtil cannot be instantiated"];
	return nil;
}

@end
