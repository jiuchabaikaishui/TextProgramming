//
//  TPKeyboardNotificationController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/21.
//

#import "TPKeyboardNotificationController.h"
#import "Masonry.h"

@interface TPKeyboardNotificationController () <UITextFieldDelegate>

@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UITextField *activeField;

@end

@implementation TPKeyboardNotificationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
    }];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeyDone;
    [scrollView addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(scrollView).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@(44));
    }];
    UIView *lastView = textField;

    for (NSInteger index = 0; index < 20; index++) {
        textField = [[UITextField alloc] init];
        textField.delegate = self;
        textField.borderStyle = UITextBorderStyleRoundedRect;
        [scrollView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastView.mas_bottom).offset(15);
            make.left.equalTo(self.view).offset(15);
            make.right.equalTo(self.view).offset(-15);
            make.height.equalTo(@(44));
        }];
        lastView = textField;
    }

    [self.view layoutIfNeeded];
    scrollView.contentSize = CGSizeMake(0, lastView.frame.origin.y + lastView.frame.size.height + 15);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWasShow:(NSNotification *)sender {
    CGRect kbFrame = [[sender.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
 
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbFrame.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect rect = self.view.frame;
    rect.size.height -= kbFrame.size.height;
    
    CGRect aRect = [self.scrollView convertRect:self.activeField.frame toView:self.view];
    aRect.origin.y += 15;
    if (!CGRectContainsRect(rect, aRect)) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.contentOffset.y + CGRectGetMaxY(aRect) - CGRectGetHeight(rect)) animated:YES];
    }
}
- (void)keyboardWasHide:(NSNotification *)sender {
    self.scrollView.contentInset = UIEdgeInsetsZero;
    self.scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.activeField = textField;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.activeField = nil;
}

@end
