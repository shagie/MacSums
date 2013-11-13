//
//  SumsUtil.h
//  MacSums
//
//  Created by Michael on 3/6/10.
//  Copyright 2010 Michael Turner. All rights reserved.
//


@interface SumsUtil : NSObject

+(int) factorial:(int)n;
+(int) minSum:(int)n;
+(int) maxSum:(int)n;
+(NSPointerArray*) newCombinationCount:(int)selectionCount taken:(int)takenTimes;
+(id) alloc;
@end


