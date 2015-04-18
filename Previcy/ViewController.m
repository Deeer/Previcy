//
//  ViewController.m
//  Previcy
//
//  Created by Dee on 15/4/18.
//  Copyright (c) 2015年 zjsruxxxy7. All rights reserved.
//
#define kCenterPointX [UIScreen mainScreen].bounds.size.width / 2

#define kCenterPointY [UIScreen mainScreen].bounds.size.height / 2
#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
#include <MessageUI/MessageUI.h>
@interface ViewController ()<MFMessageComposeViewControllerDelegate>
//- (IBAction)webViewExist:(id)sender;
//@property (nonatomic,weak) IBOutlet UIWebView *webView;
//- (IBAction)webViewRemo:(id)sender;
@property (nonatomic,strong)UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [self configAuthBtn];
//    [self CheckWeather];
    
}
-(void)configAuthBtn{
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_btn setTitle:@"test TouchID" forState:UIControlStateNormal];
//    btn.layer setAnchorPoint:CGPointMake(.5,.5);
    [_btn setFrame:CGRectMake(60, 100, 200, 30)];
    _btn.backgroundColor =[UIColor grayColor];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(authBtnTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_btn];
    

}
-(void)authBtnTouch:(UIButton *)sender
{
    LAContext * context =[[LAContext alloc]init];
    context.localizedFallbackTitle  = @"";

    NSError *error =nil;
    NSString *reason =@"测试是否为本人";
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:reason reply:^(BOOL success, NSError *error) {
            if (success) {
                
                NSLog(@"success");
                [self CheckWeather];
                

            }else
            {
                NSLog(@"failed");
            }

        }];
        
    }
    
}

-(void)SendeMessage
{
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc]init];
    if ([MFMessageComposeViewController canSendText]) {
        controller.body = @"hello from Dee";
        controller.recipients =[NSArray arrayWithObjects:@"18067960446",nil];
        controller.messageComposeDelegate = self;
//        [self presentModalViewController:controller animated:YES];
        [self presentViewController:controller animated:YES completion:nil];
        
    }
    
}
-(void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)Tele
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:15757108205"]];//呼叫号码
}

-(void)openApp:(NSString *)urlstr
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlstr]];
}

//-(void)CheckWeather
//{
//    NSURL *url = [NSURL URLWithString:@"http://m.baidu.com"];
//    NSURLRequest *request =[NSURLRequest requestWithURL:url];
////    [self.webView setFrame:CGRectMake(100, 100, 100, 100)];
//    
//    [self.view  addSubview:self.webView];
//    NSLog(@"asd");
//    [self.webView loadRequest:request];
//}


//- (IBAction)webViewRemo:(id)sender {
//
//    [self.webView removeFromSuperview];
//    
//}

@end
