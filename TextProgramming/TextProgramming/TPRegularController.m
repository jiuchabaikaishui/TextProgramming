//
//  TPRegularController.m
//  TextProgramming
//
//  Created by QSP on 2022/12/5.
//

#import "TPRegularController.h"

@interface TPRegularController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation TPRegularController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    NSString *regular = @"^1[3|4|5|7|8][0-9]\\d{8}$";
    NSRange range = [textField.text rangeOfString:regular options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return YES;
    }
    
    NSLog(@"请输入手机号码！");
    
    return NO;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

@end
