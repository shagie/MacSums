//
//  AppControl.m
//
//  Created by Michael on 3/6/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import "AppControl.h"
#import "SumsUtil.h"
#import "MustCombs.h"

#include "Logs.h"

@implementation AppControl

-(id)init
{
	notsArray = [[My09Set alloc] init];
	mustrArray = [[My09Set alloc] init];
	mustbArray = [[My09Set alloc] init];
	mustgArray = [[My09Set alloc] init];
	numsol = 0;
	sumcount = 3;
	numcount = 2;
	values	= [[NSPointerArray alloc] init];
	
	updateLock = [[NSLock alloc] init];
	
	DLog(@"nots  : %@",[notsArray toDBGString]);
	DLog(@"mustr : %@",[mustrArray toDBGString]);
	DLog(@"mustg : %@",[mustgArray toDBGString]);
	DLog(@"mustb : %@",[mustbArray toDBGString]);
	
	[self updateDataSet];
	return self;
}

-(void)awakeFromNib
{
	[mustb setHidden:YES];
	//[mustbText setHidden:YES];
}

-(void)dealloc
{
	NSLog(@"free called");
	
	[notsArray release];
	[mustbArray release];
	[mustrArray	release];
	[mustgArray	release];
	[values release];
	[updateLock release];
	
	//free(bolds);
	
	[super dealloc];
}

-(IBAction)changeSumLabel:(id)sender
{
	sumcount = [sumSlider intValue];
	[sumLabel setStringValue: [NSString stringWithFormat: @"%d",sumcount]];
	[self updateDataSet];
}

-(IBAction)changeNumLabel:(id)sender
{
	numcount = [numSlider intValue];
	[numLabel setStringValue: [NSString stringWithFormat: @"%d",numcount]];
	
	int sumMax = [SumsUtil maxSum:numcount];
	int sumMin = [SumsUtil minSum:numcount];
	int sumDelta = sumMax - sumMin + 1;
	
	[sumSlider setMaxValue: sumMax];
	[sumSlider setMinValue: sumMin];
	[sumSlider setNumberOfTickMarks: sumDelta];
	if(sumcount < sumMin)
	{
		[sumSlider setIntValue: sumMin];
		sumcount = sumMin;
		[sumLabel setStringValue: [NSString stringWithFormat: @"%d",sumMin]];
	}
	
	if(sumcount > sumMax)
	{
		[sumSlider setIntValue: sumMax];
		sumcount = sumMax;
		[sumLabel setStringValue: [NSString stringWithFormat: @"%d",sumMax]];
	}
	
	if(numcount == 2)
	{
		[mustbArray reset];
		[mustb setHidden:YES];
		//[mustbText setHidden:YES];
		//[mustbText setStringValue:@""];
		for(int i = 0; i < 9; i++)
		{
			[mustb setSelected:FALSE forSegment:i];
		}
	}
	else {
		[mustb setHidden:NO];
		//[mustbText setHidden:NO];
		//[mustbText setStringValue:@"Must B"];

	}

	
	[self updateDataSet];
}

-(IBAction)changeNots:(id)sender
{
	int selectedSegment = [sender selectedSegment];
	if(![notsArray isBitSet:selectedSegment])
	{
		[mustr setSelected:FALSE forSegment:selectedSegment];
		[mustrArray clearBit:selectedSegment];
		[mustg setSelected:FALSE forSegment:selectedSegment];
		[mustgArray clearBit:selectedSegment];
		[mustb setSelected:FALSE forSegment:selectedSegment];
		[mustbArray clearBit:selectedSegment];
	}
	
	[notsArray setBit: ![notsArray isBitSet:selectedSegment ] atIndex:selectedSegment];
	[mustr setEnabled: ![notsArray isBitSet:selectedSegment ] forSegment:selectedSegment];
	[mustg setEnabled: ![notsArray isBitSet:selectedSegment ] forSegment:selectedSegment];
	[mustb setEnabled: ![notsArray isBitSet:selectedSegment ] forSegment:selectedSegment];
	
	[self updateDataSet];
}

-(IBAction)changeMustR:(id)sender
{
	int selectedSegment = [sender selectedSegment];
	[mustrArray setBit: ![mustrArray isBitSet:selectedSegment] atIndex:selectedSegment];
		
	[self updateDataSet];
}

-(IBAction)changeMustG:(id)sender
{
	int selectedSegment = [sender selectedSegment];
	[mustgArray setBit: ![mustgArray isBitSet:selectedSegment] atIndex:selectedSegment];
		
	[self updateDataSet];
}

-(IBAction)changeMustB:(id)sender
{
	int selectedSegment = [sender selectedSegment];
	[mustbArray setBit: ![mustbArray isBitSet:selectedSegment] atIndex:selectedSegment];
	
	
	[self updateDataSet];
}

-(IBAction)doReset:(id)sender
{
	for(int i = 0; i < 9; i++)
	{
		[notsArray clearBit:i];
		
		[mustrArray clearBit:i];
		[mustgArray clearBit:i];
		[mustbArray clearBit:i];
		
		[nots	setSelected:FALSE	forSegment:i];
		[mustr	setEnabled:	TRUE	forSegment:i];
		[mustg	setEnabled: TRUE	forSegment:i];
		[mustb	setEnabled: TRUE	forSegment:i];
		[mustr	setSelected:FALSE	forSegment:i];
		[mustg	setSelected:FALSE	forSegment:i];
		[mustb	setSelected:FALSE	forSegment:i];
	}
	[self updateDataSet];
}

-(int)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return [values count];
}

-(id)tableView:(NSTableView *)aTableView
	objectValueForTableColumn:(NSTableColumn *)aTableCol
	row:(int)rowIndex
{
	My09Set *t = [values pointerAtIndex:rowIndex];
	NSString *s = [t toPrintString];
	NSMutableAttributedString *mas =  [[[NSMutableAttributedString alloc] initWithString:s] autorelease];
	/*
	 if([values count] > 1)
	{
		for(int i = 0; i < 9; i++)
		{
			if(bolds[i] == [values count])
			{
				[mas addAttribute:NSFontAttributeName
							value:[NSFont fontWithName:@"LucidaGrande-Bold" size:12.0]
							range:NSMakeRange(i, 1)];
			}
			else
			{
				[mas addAttribute:NSFontAttributeName
							value:[NSFont fontWithName:@"LucidaGrande" size:12.0]
							range:NSMakeRange(i, 1)];
			}
		}
	}
	 */
	
	[mas addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:[s rangeOfString:s]];
	return mas;
}

-(void)updateDataSet
{
	[updateLock lock];
	My09Set *t;
	
	values = [SumsUtil newCombinationCount:9 taken:numcount];
	// have all values, next remove any where the sum != sumcount
	for(int i = 0; i < [values count]; i++)
	{
		t = [values pointerAtIndex:i];
		if(([t sumArray] != sumcount) || [t intersects:notsArray])	// not sumcount match
		{
			[values replacePointerAtIndex:i withPointer:NULL];
		}
	}
	[values compact];
	// have removed all not sum values and all not intersections
	// filter musts
	int mc = 0;
	if([mustrArray getCount]) { mc |= 1; }	// MUST match below
	if([mustgArray getCount]) { mc |= 2; }
	if([mustbArray getCount]) { mc |= 4; }
	
	//NSLog(@"mc = %d",mc);
	
	if (mc)	// one of the filters was set - must filter.
	{
		int mgood = 0;	// matched filters.
		bool cgood = false;
		MustCombs *mcomb = [[MustCombs alloc] initWithCellCount:numcount];	
		// mcomb contains a list of must possibilties for N cells. 
				
		for(int i = 0; i < [values count]; i++)	// looping over all values
		{
			t = [values pointerAtIndex:i];	// t is a My09Set
#ifdef DEBUG
			DLog(@"Value: %@",[t toDBGString]);	// dbg
			if([mustrArray getCount] != 0) { DLog(@"R: %@",[mustrArray toDBGString]);}	// dbg
			if([mustgArray getCount] != 0) { DLog(@"G: %@",[mustgArray toDBGString]);}	// dbg
			if([mustbArray getCount] != 0) { DLog(@"B: %@",[mustbArray toDBGString]);}	// dbg
#endif

			cgood = false;
			for(int j = 0; j < [mcomb count]; j++)	// looping over combinations
			{
				NSArray *mustPosArray = [mcomb mustAt:j];	
				// mustPosArray is array of 3 integers indexing rgb against nthElement
				//NSLog(@"rgb: %d%d%d",[[mustPosArray objectAtIndex:0] intValue],[[mustPosArray objectAtIndex:1] intValue], [[mustPosArray objectAtIndex:2] intValue]);
				
				mgood = 0;
				for(int k = 0; k < numcount; k++)	// looping over cells
				{
					//NSLog(@"i: %d // j: %d // k: %d // t[k]: %d",i,j,k,[t nthElement:k]);
					//mustPosArray[n] -> kth cell for must[rgb]array to match against
					if([[mustPosArray objectAtIndex:0] intValue] != -1 &&	// not a special 2 case
					   [[mustPosArray objectAtIndex:0] intValue] == k &&	// is the cell we are intrested in
					   [mustrArray getCount])								// mustrArray has elements
					{
						if([mustrArray isBitSet:[t nthElement:k]])
						{
							mgood |= 1;
							//NSLog(@"R - YES");
						}
						else {
							//NSLog(@"R - nope");
						}

					}
					if([[mustPosArray objectAtIndex:1] intValue] != -1 && [[mustPosArray objectAtIndex:1] intValue] == k && [mustgArray getCount])
					{
						if([mustgArray isBitSet:[t nthElement:k]])
						{
							mgood |= 2;
							//NSLog(@"G - YES");
						}
						else {
							//NSLog(@"G - nope");
						}

					}
					if([[mustPosArray objectAtIndex:2] intValue] != -1 && [[mustPosArray objectAtIndex:2] intValue] == k && [mustbArray getCount])
					{
						if([mustbArray isBitSet:[t nthElement:k]])
						{
							mgood |= 4;
							//NSLog(@"B - YES");
						}
						else {
							//NSLog(@"B - nope");
						}
					}
					//NSLog(@"k = %d; mc = %d",k,mc);
				}
				//NSLog(@"mgood = %d; mc = %d",mgood,mc);
				if(mgood == mc) // if matched filters match the filters selected
				{
					cgood = true;
					//NSLog(@"cgood now true");
				} 
			}
			
			if(!cgood)
			{
				//NSLog(@"cgood false - replacing with null");
				[values replacePointerAtIndex:i withPointer:NULL];
			}
		}
		[mcomb dealloc];
		[values compact];
	}
	/*
	for(int i = 0; i < 9; i++) { bolds[i] = 0; }	// reset values
	for(int i = 0; i < [values count]; i++)
	{
		for(int j = 0; j < 9; j++)
		{
			My09Set *v = [values pointerAtIndex:i];
			if([v isBitSet:j])
			{
				bolds[j]++;
			}
		}
	}
	 */
	[updateLock unlock];
	[results reloadData];
}


@end
