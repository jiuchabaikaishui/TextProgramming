//
//  TPSingleTextFlowController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/24.
//

#import "TPSingleTextFlowController.h"
#import "Masonry.h"

@interface TPSingleTextFlowController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation TPSingleTextFlowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"《少年歌行》" ofType:@"txt"];
    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];

    NSTextStorage* textStorage = [[NSTextStorage alloc] initWithString:string];
    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
    [textStorage addLayoutManager:layoutManager];
    NSTextContainer *container = [[NSTextContainer alloc] init];
    [layoutManager addTextContainer:container];
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.safeAreaLayoutGuide.layoutFrame textContainer:container];
    textView.editable = NO;
    [self.view addSubview:textView];
    
    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:string];
    
//    NSTextContainer *textContainerA = [[NSTextContainer alloc] init];
//    NSTextContainer *textContainerB = [[NSTextContainer alloc] init];
//    NSLayoutManager *layoutManager  = [[NSLayoutManager alloc] init];
//
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"《少年歌行》" ofType:@"txt"];
//    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//
//    NSTextStorage *textStorage = [[NSTextStorage alloc] init];
//
//    [layoutManager addTextContainer:textContainerA];
//    [layoutManager addTextContainer:textContainerB];
//    [textStorage addLayoutManager:layoutManager];
//
//    CGFloat W = [UIScreen mainScreen].bounds.size.width;
//    UITextView *textViewA = [[UITextView alloc] initWithFrame:CGRectMake(0, 100, W, 200) textContainer:textContainerA];
//    textViewA.backgroundColor = [UIColor lightGrayColor];
//    UITextView *textViewB = [[UITextView alloc] initWithFrame:CGRectMake(0, 316, W, 200) textContainer:textContainerB];
//    textViewB.backgroundColor = [UIColor lightGrayColor];
//
//    [self.view addSubview:textViewA];
//    [self.view addSubview:textViewB];
//    textViewA.scrollEnabled = NO;
//
//    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:string];
}

- (void)viewDidLayoutSubviews {
    
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"《少年歌行》" ofType:@"txt"];
//    NSString *string = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
//
//    NSTextStorage* textStorage = [[NSTextStorage alloc] initWithString:string];
//    NSLayoutManager *layoutManager = [[NSLayoutManager alloc] init];
//    [textStorage addLayoutManager:layoutManager];
//    NSTextContainer *container = [[NSTextContainer alloc] initWithSize:CGSizeMake(375, CGRectGetHeight(self.view.safeAreaLayoutGuide.layoutFrame))];
//    [layoutManager addTextContainer:container];
//    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.safeAreaLayoutGuide.layoutFrame textContainer:container];
//    textView.editable = NO;
//    [self.view addSubview:textView];
//
//    [textStorage replaceCharactersInRange:NSMakeRange(0, 0) withString:string];
}

@end
