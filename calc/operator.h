//
//  operator.h
//  calc
//
//  Created by Ayodeji Ayodele on 8/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface operator : NSObject
    
@property (readonly) NSString *operatorName;
@property (readonly) NSInteger rank;

-(operator*) initWith: (NSString*)string;
+(NSArray*) getAvailableOperators;
-(BOOL) isHigherThan: (operator*)thisOperator;
-(BOOL) isLowerThan: (operator*)thisOperator;

@end
