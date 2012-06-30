//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Joaquin Windmuller on 12-06-28.
//  Copyright (c) 2012 Windmill IT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorBrain : NSObject

- (void) pushOperand:(double)operand;
- (double) performOperation:(NSString *)operation;
- (void) amnesia;
@end
