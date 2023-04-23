//
//  ViewController.m
//  TextProgramming
//
//  Created by QSP on 2022/11/19.
//

#import "TPMainController.h"
#import "Masonry.h"

NSString *const TPTitleKey = @"TPTitleKey";
NSString *const TPControllerClassKey = @"TPControllerClassKey";
NSString *const TPControllerIdentifierKey = @"TPControllerIdentifierKey";

@interface TPMainController () <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic) NSArray *dataList;

@end

@implementation TPMainController

- (NSArray *)dataList {
    if (_dataList == nil) {
        _dataList = @[
            @{
                TPTitleKey: @"获取并改变所选中的字符串",
                TPControllerClassKey: @"TPSelectedStringController"
            },
            @{
                TPTitleKey: @"为Web视图配置键盘",
                TPControllerClassKey: @"TPWebViewKeyboardController"
            },
            @{
                TPTitleKey: @"处理键盘通知",
                TPControllerClassKey: @"TPKeyboardNotificationController"
            },
            @{
                TPTitleKey: @"复制、剪切、粘贴，管理编辑菜单",
                TPControllerClassKey: @"TPCopyCutPasteController"
            },
            @{
                TPTitleKey: @"自定义输入视图",
                TPControllerClassKey: @"TPInputViewController"
            },
            @{
                TPTitleKey: @"字体系列",
                TPControllerClassKey: @"TPFontFamilyController"
            },
            @{
                TPTitleKey: @"字体特征",
                TPControllerIdentifierKey: @"TPFontTraitController"
            },
            @{
                TPTitleKey: @"为单个文本流创建对象",
                TPControllerClassKey: @"TPSingleTextFlowController"
            },
            @{
                TPTitleKey: @"正则表达式",
                TPControllerIdentifierKey: @"TPRegularController"
            },
            @{
                TPTitleKey: @"简单文本输入",
                TPControllerClassKey: @"TPSimpleTextInputController"
            }
        ];
    }
    
    return _dataList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文本编程案例";
    
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSDictionary *data = [self.dataList objectAtIndex:indexPath.row];
    cell.textLabel.text = data[TPTitleKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.dataList objectAtIndex:indexPath.row];
    Class class = NSClassFromString(data[TPControllerClassKey]);
    if (class) {
        UIViewController *controller = [[class alloc] init];
        controller.title = data[TPTitleKey];
        [self.navigationController pushViewController:controller animated:YES];
    } else if (data[TPControllerIdentifierKey]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *controller = [sb instantiateViewControllerWithIdentifier:data[TPControllerIdentifierKey]];
        controller.title = data[TPTitleKey];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
