//
//  TPSelectedStringController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/19.
//

#import "TPSelectedStringController.h"
#import "Masonry.h"

@interface TPSelectedStringController () <UITextViewDelegate>

@end

@implementation TPSelectedStringController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc] init];
    textView.delegate = self;
    textView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@(100));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSRange range = textView.selectedRange;
    if (range.length == 0) { return; }
    
    NSString *selectedText = [textView.text substringWithRange:range];
    NSString *upString = [selectedText uppercaseString];
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:upString];
    textView.text = newString;
}

@end
