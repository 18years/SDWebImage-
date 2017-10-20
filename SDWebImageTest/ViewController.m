//
//  ViewController.m
//  SDWebImageTest
//
//  Created by 谢江涛 on 2017/10/19.
//  Copyright © 2017年 谢江涛. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    https://gss3.bdstatic.com/-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=3f8a9a0830292df597c3ab13840a3b5d/b999a9014c086e06b6f1606c08087bf40ad1cbb8.jpg
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:imageView];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"-Po3dSag_xI4khGkpoWK1HF6hhy/baike/w%3D268%3Bg%3D0/sign=3f8a9a0830292df597c3ab13840a3b5d/b999a9014c086e06b6f1606c08087bf40ad1cbb8.jpg"] placeholderImage:nil options:SDWebImageRefreshCached ];
    
    /**
     如果 Image 是不定时修改，只有在服务端修改 图片 后，才去刷新本地资源；
     这样需要使用修改 HttpHeader，设置last-modified-time，
     
     */
    [SDWebImageDownloader sharedDownloader].headersFilter = ^NSDictionary *(NSURL *url, NSDictionary *headers) {
        NSMutableDictionary *HTTPHeaders = [NSMutableDictionary dictionary];
#ifdef SD_WEBP
        HTTPHeaders = [@{@"Accept": @"image/webp,image/*;q=0.8"} mutableCopy];
#else
        HTTPHeaders = [@{@"Accept": @"image/*;q=0.8"} mutableCopy];
#endif
        [HTTPHeaders setObject:@"1323" forKey:@"last-modified-time"];
        /**  */
        return [HTTPHeaders copy];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
