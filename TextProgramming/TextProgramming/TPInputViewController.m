//
//  TPInputViewController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/23.
//

#import "TPInputViewController.h"
#import "Masonry.h"

@implementation TPKeyboardAccessoryView

- (BOOL)enableInputClicksWhenVisible {
    return YES;
}

@end

@interface TPInputViewController () <UITextFieldDelegate>

@property (weak, nonatomic) UITextField *textField;

@end

@implementation TPInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:textField];
    self.textField = textField;
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuide).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@(44));
    }];
}

- (UIView *)inputAccessoryView {
    CGRect accessFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    TPKeyboardAccessoryView *inputAccessoryView = [[TPKeyboardAccessoryView alloc] initWithFrame:accessFrame];
    inputAccessoryView.backgroundColor = [UIColor blueColor];
    UIButton *compButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    compButton.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 49);
    [compButton setTitle: @"Word Completions" forState:UIControlStateNormal];
    [compButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [compButton addTarget:self action:@selector(completeCurrentWord:)
        forControlEvents:UIControlEventTouchUpInside];
    [inputAccessoryView addSubview:compButton];
    return inputAccessoryView;
}

- (void)completeCurrentWord:(UIButton *)sender {
    [[UIDevice currentDevice] playInputClick];
    
    self.textField.text = [self.textField.text stringByAppendingString:sender.currentTitle];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}

@end
