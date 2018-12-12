
#import "PenetrationSegmentController.h"

@interface PenetrationSegmentController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView * scrollView;
@property(nonatomic,strong)UIButton * btn;
@property(nonatomic,strong)NSMutableArray * btns;
@property(nonatomic,strong)UIView * subview;
@property(nonatomic,strong)UIView * indicator;
@property(nonatomic,strong)UIColor * viewColor;
@end
// 状态栏(statusbar)
#define TOP_STATUS_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height

// 导航栏(navigationBar)
#define TOP_NAVGATIONBAR_HEIGHT self.navigationController.navigationBar.frame.size.height
// tabBar的高度
#define TABBAR_HEIGHT 49.0
// 底部宏
#define SafeAreaBottomHeight ([UIScreen mainScreen].bounds.size.height == 812.0 ? 34 : 0)
#define TITLESTATUSHEIGHT 50
@implementation PenetrationSegmentController
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.btns = [NSMutableArray array];
        _titleViewBackgroudColor = [UIColor whiteColor];
        _titleColor = [UIColor blackColor];
        _tinColor = [UIColor redColor];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setScroll];
    [self setTitleView];
    
    NSString* phoneVersion = [[UIDevice currentDevice] systemVersion];
    if ([phoneVersion intValue]>11) {
    self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
    self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(void)setScroll{
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.frame = self.view.bounds;
    self.scrollView.backgroundColor = [UIColor orangeColor];
    self.scrollView.contentSize = CGSizeMake(_titles.count*[UIScreen mainScreen].bounds.size.width, 0);
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
}
//设置标题栏
-(void)setTitleView{
    UIView * subview = [[UIView alloc]init];
    subview.frame = CGRectMake(0,  TOP_STATUS_HEIGHT+TOP_NAVGATIONBAR_HEIGHT, self.view.frame.size.width,TITLESTATUSHEIGHT);
    subview.backgroundColor = _titleViewBackgroudColor;
    _subview = subview;
    CGFloat width = self.view.frame.size.width*1.0/_titles.count;
    for (int i = 0; i<_titles.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag = i;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_tinColor forState:UIControlStateDisabled];
        btn.frame = CGRectMake(width* i, 0, width,TITLESTATUSHEIGHT-2);
        [subview addSubview:btn];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_btns addObject:btn];
        if (i==0) {
            [btn.titleLabel sizeToFit];
            _indicator = [[UIView alloc]init];
            _indicator.backgroundColor = _tinColor;
            [_subview addSubview:_indicator];
            CGRect frame = _indicator.frame;
            frame.origin.y = _subview.frame.size.height-2;
            frame.size.width = btn.titleLabel.frame.size.width;
            frame.size.height = 2;
            CGPoint point = _indicator.center;
            point.x = btn.frame.size.width*0.5;
            point.y = btn.frame.size.height-2;
            _indicator.frame = frame;
            _indicator.center = point;
        }
    }
    [self.view addSubview:subview];
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
}
-(void)setVcArray:(NSArray *)vcArray{
    _vcArray = vcArray;
    for (UIViewController * vc  in vcArray) {
        [self addChildViewController:vc];
    }
    for (int i = 0; i<self.childViewControllers.count; i++) {
        UIViewController * vc = self.childViewControllers[i];
        vc.view.frame = CGRectMake(i* self.view.frame.size.width, 0, _scrollView.frame.size.height, [UIScreen mainScreen].bounds.size.height);
        [self.scrollView addSubview:vc.view];
    }
}
-(void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
    for (UIButton * btn  in _btns) {
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
    }
}
-(void)setTinColor:(UIColor *)tinColor{
    _tinColor = tinColor;
    for (UIButton * btn  in _btns) {
        [btn setTitleColor:tinColor forState:UIControlStateDisabled];
    }
    _indicator.backgroundColor = tinColor;
}
-(void)setTitleViewBackgroudColor:(UIColor *)titleViewBackgroudColor{
    _titleViewBackgroudColor = titleViewBackgroudColor;
    _subview.backgroundColor = titleViewBackgroudColor;
}
-(void)click:(UIButton*)btn{
    self.btn.enabled = YES;
    self.btn = btn;
    btn.enabled = NO;
    
    CGPoint point = CGPointMake(btn.tag * self.view.frame.size.width, 0);
    self.scrollView.contentOffset = point;
   
    [UIView animateWithDuration:0.1 animations:^{
        [self.btn.titleLabel sizeToFit];
        CGRect frame = self.indicator.frame;
        frame.origin.y = self.subview.frame.size.height-2;
        frame.size.width = self.btn.titleLabel.frame.size.width;
        frame.size.height = 2;
        CGPoint point1 = self.indicator.center;
        point1.x = self.btn.frame.origin.x+self.btn.frame.size.width*0.5;
        point1.y = self.btn.frame.size.height-2;
        self.indicator.frame = frame;
        self.indicator.center = point1;
    }];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int i = (int)scrollView.contentOffset.x/self.view.frame.size.width;
    UIButton * btn =self.btns[i];
    [UIView animateWithDuration:0.1 animations:^{
        [btn.titleLabel sizeToFit];
        CGRect frame = self.indicator.frame;
        frame.origin.y = self.subview.frame.size.height-2;
        frame.size.width = btn.titleLabel.frame.size.width;
        frame.size.height = 2;
        CGPoint point1 = self.indicator.center;
        point1.x = btn.frame.origin.x+btn.frame.size.width*0.5;
        point1.y = btn.frame.size.height-2;
        self.indicator.frame = frame;
        self.indicator.center = point1;
    }];
}

@end
