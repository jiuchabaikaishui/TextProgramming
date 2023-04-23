//
//  TPSimpleTextInputView.m
//  TextProgramming
//
//  Created by QSP on 2022/12/5.
//

#import "TPSimpleTextInputView.h"

@interface TPSimpleTextInputView () <UIKeyInput>

@property (strong, nonatomic) NSMutableString *textStore;

@end

@implementation TPSimpleTextInputView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor cyanColor];
    }
    
    return self;
}

- (NSMutableString *)textStore {
    if (_textStore == nil) {
        _textStore = [[NSMutableString alloc] init];
    }

    return _textStore;
}
- (UIColor *)color {
    if (_color == nil) {
        _color = [UIColor blackColor];
    }
    
    return _color;
}
- (UIFont *)font {
    if (_font == nil) {
        UIFontDescriptor *descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
        _font = [UIFont fontWithDescriptor:descriptor size:0];
    }
    
    return _font;
}

- (BOOL)hasText {
    if (self.textStore.length > 0) {
    return YES;
    }

    return NO;
}
- (void)insertText:(NSString *)text {
    [self.textStore appendString:text];
    
    [self setNeedsDisplay];
}
- (void)deleteBackward {
    NSRange range = NSMakeRange(self.textStore.length - 1, 1);
    [self.textStore deleteCharactersInRange:range];
    
    [self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (BOOL)canResignFirstResponder {
    return YES;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self.color set];
    [self.textStore drawInRect:rect withAttributes:@{NSFontAttributeName: self.font}];
}

@end
