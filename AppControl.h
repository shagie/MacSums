//
//  AppControl.h
//
//  Created by Michael on 3/6/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "My09Set.h"

@interface AppControl : NSObject {
	IBOutlet	NSTextField	*sumLabel;
	IBOutlet	NSTextField	*numLabel;
	IBOutlet	NSSlider	*sumSlider;
	IBOutlet	NSSlider	*numSlider;
	IBOutlet	NSTextField	*mustbText;
		
	IBOutlet	NSSegmentedControl	*nots;
	IBOutlet	NSSegmentedControl	*mustr;
	IBOutlet	NSSegmentedControl	*mustg;
	IBOutlet	NSSegmentedControl	*mustb;
	
	IBOutlet	NSTableView	*results;
	
	int sumcount;
	int numcount;
	My09Set *notsArray;
	My09Set *mustrArray;
	My09Set *mustgArray;
	My09Set *mustbArray;
	
	int numsol;
	NSPointerArray *values;
	
	//int *bolds;
	
	NSLock	*updateLock;
}

-(IBAction)changeSumLabel:(id)sender;
-(IBAction)changeNumLabel:(id)sender;

-(IBAction)changeNots:(id)sender;
-(IBAction)changeMustR:(id)sender;
-(IBAction)changeMustG:(id)sender;
-(IBAction)changeMustB:(id)sender;

-(IBAction)doReset:(id)sender;

-(id)init;
-(void)dealloc;

-(int)numberOfRowsInTableView:(NSTableView *)aTableView;
-(id)tableView:(NSTableView *)aTableView
		objectValueForTableColumn:(NSTableColumn *)aTableCol
		row:(int)rowIndex;

-(void)updateDataSet;

@end