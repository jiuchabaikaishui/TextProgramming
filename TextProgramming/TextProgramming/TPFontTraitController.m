//
//  TPFontTraitController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/24.
//

#import "TPFontTraitController.h"
#import <CoreText/CoreText.h>

@interface TPFontTraitController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation TPFontTraitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIFontDescriptor *descriptor = [UIFontDescriptor preferredFontDescriptorWithTextStyle:UIFontTextStyleBody];
    UIFont *font = [UIFont fontWithDescriptor:descriptor size:0];
    self.label.text = font.fontName;
    self.label.font = font;
    
    NSArray *timeFeatureSettings = @[
      @{
        UIFontFeatureTypeIdentifierKey: @(kNumberSpacingType),
        UIFontFeatureSelectorIdentifierKey: @(kProportionalNumbersSelector)
      },
      @{
        UIFontFeatureTypeIdentifierKey: @(kCharacterAlternativesType),
        UIFontFeatureSelectorIdentifierKey: @(2)
      }];
     
    UIFont *originalFont = [UIFont fontWithName: @"HelveticaNeue-Medium" size: 12.0];
    UIFontDescriptor *originalDescriptor = [originalFont fontDescriptor];
    UIFontDescriptor *timeDescriptor = [originalDescriptor
        fontDescriptorByAddingAttributes: @{
            UIFontDescriptorFeatureSettingsAttribute: timeFeatureSettings }];
    UIFont *timeFont = [UIFont fontWithDescriptor: timeDescriptor size: 12.0];
    self.label2.text = timeFont.fontName;
    self.label2.font = timeFont;
}
- (IBAction)button1Action:(UIButton *)sender {
    UIFontDescriptor *descriptor = [self.label.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitBold];
    self.label.font = [UIFont fontWithDescriptor:descriptor size:0];
}
- (IBAction)button2Action:(UIButton *)sender {
    UIFontDescriptor *descriptor = [self.label.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitItalic];
    self.label.font = [UIFont fontWithDescriptor:descriptor size:0];
}
- (IBAction)button3Action:(UIButton *)sender {
    UIFontDescriptor *descriptor = [self.label.font.fontDescriptor fontDescriptorWithSymbolicTraits:UIFontDescriptorTraitCondensed];
    self.label.font = [UIFont fontWithDescriptor:descriptor size:0];
}
- (IBAction)button4Acion:(UIButton *)sender {
    CFArrayRef fontFeatures = CTFontCopyFeatures((__bridge CTFontRef) self.label2.font);
    NSLog(@"properties = %@", fontFeatures);
}

@end
