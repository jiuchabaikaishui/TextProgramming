//
//  TPFontController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/24.
//

#import "TPFontFamilyController.h"
#import "Masonry.h"

@interface TPFontFamilyController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (copy, nonatomic) NSArray *dataList;

@end

@implementation TPFontFamilyController

- (NSArray *)dataList {
    if (_dataList == nil) {
        UIFontDescriptor *helveticaNeueFamily =
            [UIFontDescriptor fontDescriptorWithFontAttributes:
                @{ UIFontDescriptorFamilyAttribute: @"Helvetica Neue" }];
        _dataList =
            [helveticaNeueFamily matchingFontDescriptorsWithMandatoryKeys: nil];
    }
    
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    UIFontDescriptor *descriptor = [self.dataList objectAtIndex:indexPath.row];
    cell.textLabel.text = descriptor.postscriptName;
    cell.textLabel.font = [UIFont fontWithDescriptor:descriptor size:0];
    
    return cell;
}

@end
