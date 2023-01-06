//
//  main.m
//  calc
//

#import <Foundation/Foundation.h>
#import "calculator.h"
#import "expressionResult.h"

calculator *theCalc;

int main(int argc, char * argv[]) {
    @autoreleasepool {

        @try{
            
            NSArray *arguments = [[NSProcessInfo processInfo] arguments];
            NSArray *argumentsWithoutFirst = [[NSArray alloc] init];
            
            //Remove the first argument, which is invalid
            for(int i = 1; i< [arguments count]; i++)
                argumentsWithoutFirst = [argumentsWithoutFirst arrayByAddingObject:arguments[i]];
            
            expressionResult *result = [calculator evaluate:argumentsWithoutFirst];
            if (result != nil){
                if(![calculator foundFloat:argumentsWithoutFirst]) //If all inputs were integers
                    printf("%ld",(long)[result result]);
                else
                    printf("%0.1f",[result result]);
            }
            
        }
        @catch(NSException *exception)
        {
            NSLog(@"Catch - %@ : %@", [exception name], [exception reason]);
            exit(1);
        }
    
    }
    return 0;
}


