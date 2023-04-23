//
//  TPCopyCutPasteController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/22.
//

#import "TPCopyCutPasteController.h"
#import "Masonry.h"
#import "UIKitExtension.h"

NSString *const TPPasteboardTypeString = @"TPPasteboardTypeString";

@implementation TPButton
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    UITouch *theTouch = [touches anyObject];
    if ([theTouch tapCount] == 2) {
        [self becomeFirstResponder];
        UIMenuItem *menuItem = [[UIMenuItem alloc] initWithTitle:@"Change Color" action:@selector(changeColor:)];
        UIMenuController *menuCont = [UIMenuController sharedMenuController];
        [menuCont setTargetRect:self.frame inView:self.superview];
        menuCont.arrowDirection = UIMenuControllerArrowLeft;
        menuCont.menuItems = [NSArray arrayWithObject:menuItem];
        [menuCont setMenuVisible:YES animated:YES];
    }
}
- (BOOL)canBecomeFirstResponder { return YES; }

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(changeColor:)) {
        return YES;
    } else if (action == @selector(cut:) || action == @selector(copy:)) {
        return self.currentTitle.length > 0 && self.currentBackgroundImage;
    } else if (action == @selector(paste:)) {
        UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
        
        NSData *data = [gpBoard dataForPasteboardType:TPPasteboardTypeString];
        if (data) return YES;
    }
    
    return NO;
}
- (void)copy:(id)sender {
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    
    NSDictionary *dic = @{
        @"image": [UIImagePNGRepresentation(self.currentBackgroundImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength],
        @"title": self.currentTitle
    };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingFragmentsAllowed error:nil];
    [gpBoard setData:data forPasteboardType:TPPasteboardTypeString];
}
- (void)cut:(id)sender {
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    
    NSDictionary *dic = @{
        @"image": [UIImagePNGRepresentation(self.currentBackgroundImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength],
        @"title": self.currentTitle
    };
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingFragmentsAllowed error:nil];
    [gpBoard setData:data forPasteboardType:TPPasteboardTypeString];
    
    [self setTitle:nil forState:UIControlStateNormal];
    [self setBackgroundImage:nil forState:UIControlStateNormal];
}
- (void)paste:(id)sender {
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    
    NSData *data = [gpBoard dataForPasteboardType:TPPasteboardTypeString];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if (dic) {
        NSString *base64 = dic[@"image"];
        NSData *data = [[NSData alloc] initWithBase64EncodedString:base64 options:NSDataBase64DecodingIgnoreUnknownCharacters];
        [self setBackgroundImage:[UIImage resizableImage:[UIImage imageWithData:data]] forState:UIControlStateNormal];
        [self setTitle:dic[@"title"] forState:UIControlStateNormal];
    }
}
- (void)changeColor:(id)sender {
    if ([self.backgroundColor isEqual:[UIColor purpleColor]]) {
        self.backgroundColor = [UIColor redColor];
    } else {
        self.backgroundColor = [UIColor purpleColor];
    }
    [self setNeedsDisplay];
}

@end

@implementation TPCopyCutPasteView

- (NSData *)selectionData {
    NSString *selection = [self textInRange:self.selectedTextRange];
    
    return [selection dataUsingEncoding:NSUTF8StringEncoding];
}
- (void)copy:(id)sender {
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    
    NSLog(@"%@", gpBoard.items);
    NSLog(@"%@", gpBoard.strings);
    NSLog(@"%@", gpBoard.images);

    [gpBoard setString:[self textInRange:self.selectedTextRange]];
    
    NSLog(@"%@", gpBoard.items);
    NSLog(@"%@", gpBoard.strings);
    NSLog(@"%@", gpBoard.images);
}
- (void)cut:(id)sender {
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    
    NSLog(@"%@", gpBoard.items);
    NSLog(@"%@", gpBoard.strings);
    NSLog(@"%@", gpBoard.images);
    
    [gpBoard setString:[self textInRange:self.selectedTextRange]];
    
    NSLog(@"%@", gpBoard.items);
    NSLog(@"%@", gpBoard.strings);
    NSLog(@"%@", gpBoard.images);
    
    [self replaceRange:self.selectedTextRange withText:@""];
}
- (void)paste:(id)sender {
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    NSLog(@"%@", gpBoard.items);
    NSLog(@"%@", gpBoard.strings);
    NSLog(@"%@", gpBoard.images);
    
    if (gpBoard.string) {
        [self replaceRange:self.selectedTextRange withText:gpBoard.string];
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(paste:)) {
        UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
        return gpBoard.string.length > 0;
    } else if (action == @selector(cut:) || action == @selector(copy:)) {
        return [self textInRange:self.selectedTextRange].length > 0;
    } else {
        return [super canPerformAction:action withSender:sender];
    }
}

@end

@interface TPCopyCutPasteController () <UITextFieldDelegate>

@property (weak, nonatomic) UIButton *button1;
@property (weak, nonatomic) UIButton *button2;

@end

@implementation TPCopyCutPasteController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    TPCopyCutPasteView *textField = [[TPCopyCutPasteView alloc] init];
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.returnKeyType = UIReturnKeyDone;
    [self.view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuide).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.equalTo(@(44));
    }];
    
    TPButton *button1 = [TPButton buttonWithType:UIButtonTypeCustom];
    [button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [button1 setBackgroundColor:[UIColor redColor]];
    [UIImage imageWithColor:[UIColor orangeColor] size:CGSizeMake(30, 30) cornerRadius:5 completion:^(UIImage * _Nonnull image) {
        [button1 setBackgroundImage:[UIImage resizableImage:image] forState:UIControlStateNormal];
    }];
    [button1 setTitle:@"button1" forState:UIControlStateNormal];
    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(15);
        make.top.equalTo(textField.mas_bottom).offset(15);
        make.width.height.equalTo(@(100));
    }];
    
    TPButton *button2 = [TPButton buttonWithType:UIButtonTypeCustom];
    [button2 setBackgroundColor:[UIColor redColor]];
    [button2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [UIImage imageWithColor:[UIColor purpleColor] size:CGSizeMake(30, 30) cornerRadius:5 completion:^(UIImage * _Nonnull image) {
        [button2 setBackgroundImage:[UIImage resizableImage:image] forState:UIControlStateNormal];
    }];
    [button2 setTitle:@"button2" forState:UIControlStateNormal];
    [self.view addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button1.mas_right).offset(15);
        make.top.equalTo(textField.mas_bottom).offset(15);
        make.width.height.equalTo(@(100));
    }];
}

- (void)buttonAction:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return NO;
}
- (void)textFieldDidChangeSelection:(UITextField *)textField {
    
}

@end
