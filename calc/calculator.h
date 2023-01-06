//
//  calculator.h
//  calc
//
//  Created by Ayodeji Ayodele on 4/04/2017.
//  Copyright © 2017 UTS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "expressionResult.h"

@interface calculator : NSObject


+(float) addWithA: (float)a andB: (float)b;
+(float) subtractWithA: (float)a andB: (float)b;
+(float) multiplyWithA: (float)a andB: (float)b;
+(float) divideWithA: (float)a andB: (float)b;
+(NSInteger) remainderWithA: (NSInteger)a andB: (NSInteger)b;
+(expressionResult*) evaluate: (NSArray*) arguments;
+(BOOL) foundFloat: (NSArray*) expression;

@end
