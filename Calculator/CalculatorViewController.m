//
//  CalculatorViewController.m
//  Calculator
//
//  Created by Joaquin Windmuller on 12-06-28.
//  Copyright (c) 2012 Windmill IT. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property BOOL userIsInTheMiddleOfInsertingANumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userIsInTheMiddleOfInsertingANumber;
@synthesize brain = _brain;

- (CalculatorBrain *) brain
{
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if ([digit isEqualToString:@"."]) {
        if ([self.display.text rangeOfString:@"."].length != NSNotFound) {
            digit = self.userIsInTheMiddleOfInsertingANumber ? @"" : @"0.";
        }
    }
    if ([digit isEqualToString:@"π"]) {
        digit = @"3.14159";
        self.display.text = @"";
    }
    if (self.userIsInTheMiddleOfInsertingANumber) {
        self.display.text = [self.display.text stringByAppendingString:digit];
    } else {
        self.display.text = digit;
        self.userIsInTheMiddleOfInsertingANumber = YES;
    }
}
- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfInsertingANumber = NO;
}
- (IBAction)operationPressed:(UIButton *)sender {
    if (self.userIsInTheMiddleOfInsertingANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
@end
