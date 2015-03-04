//
//  MFMessageViewController.m
//  MFMessageViewController
//
//  Created by ShenzhenGuo on 13-10-17.
//  Copyright (c) 2013年 ShuzhenGuo. All rights reserved.
//

#import "MFMessageViewController.h"

@interface MFMessageViewController ()

@end

@implementation MFMessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(50, 50, 50, 50);
    
    [button setTitle:@"发短信" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}

- (void)sendMessage
{
    //第一种发送短信的方式,不可以设置短信内容
    //    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms:15101178825"]];
    //判断当前设备是否可以发送信息
    if ([MFMessageComposeViewController canSendText]) {
        
        //创建发送信息的类
        MFMessageComposeViewController *messageViewController = [[MFMessageComposeViewController alloc] init];
        //委托到本类
        messageViewController.messageComposeDelegate = self;
        //设置收件人, 需要一个数组, 可以群发短信
        messageViewController.recipients = @[@"15101178825"];
        //短信的内容
        messageViewController.body = @"我今天没吃早饭!";
        //打开短信视图控制器
        [self presentViewController:messageViewController animated:YES completion:nil];
    }else{
        NSLog(@"can not send text!");
    }
    
    
}

//发送信息的委托方法<MFMessgeComposeViewControllerDelegate>
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
            
            //在短信视图里面，点击取消按钮，触发的方法
        case MessageComposeResultCancelled:
        {
            NSLog(@"cancel");
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            //发送短信成功
        case MessageComposeResultSent:
        {
            NSLog(@"sent");
            //关闭短信视图控制器
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
            
            //发送短信失败
        case MessageComposeResultFailed:
        {
            NSLog(@"failed");
        }
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
