//
//  TPSimpleTextInputController.m
//  TextProgramming
//
//  Created by QSP on 2022/12/5.
//

#import "TPSimpleTextInputController.h"
#import "TPSimpleTextInputView.h"
#import "Masonry.h"

@interface TPSimpleTextInputController ()

@property (weak, nonatomic) TPSimpleTextInputView *inputView;

@end

@implementation TPSimpleTextInputController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    TPSimpleTextInputView *inputView = [[TPSimpleTextInputView alloc] init];
    [self.view addSubview:inputView];
    self.inputView = inputView;
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view.mas_safeAreaLayoutGuide);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [inputView addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.inputView.isFirstResponder) {
        
    } else {
        [self.inputView becomeFirstResponder];
    }
}

@end
