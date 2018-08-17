//
//  ViewController.m
//  GeneratePersonLogo
//
//  Created by Jiaozl 2018 on 2018/8/17.
//  Copyright © 2018年 Jiaozl. All rights reserved.
//

/*
 
 产生一个专属logo
 
 self.logotitle = @"\nADreamClusive"; 为logo中显示的文字
 
 通过[attrStr insertAttributedString:attribute1 atIndex:0];控制图片显示的位置
 
 */


#import "ViewController.h"

@interface ViewController ()


@property(nonatomic, nonnull, copy) NSString *logotitle;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.logotitle = @"\nADreamClusive";
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    label.layer.borderWidth = 2.0;
    label.layer.borderColor = UIColor.lightGrayColor.CGColor;
    label.attributedText = [self generatePersonLogo:self.logotitle];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:label];
    label.center = self.view.center;
}


- (NSAttributedString *)generatePersonLogo:(NSString *)str {
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    // 设置段落样式
    NSMutableParagraphStyle * mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
    //    mParagraphStyle.headIndent = 30; // 除了首行,全部缩进
    //    mParagraphStyle.firstLineHeadIndent = 10; // 首行缩进
    //    mParagraphStyle.lineSpacing = 20; // 行间距
    [attrStr addAttribute:NSParagraphStyleAttributeName value:mParagraphStyle range:NSMakeRange(0, str.length)];
    
    /// 属性字典
    NSDictionary * attris;
    
    for (int i=0; i<str.length; i++) {
        
        // 随机颜色值
        NSUInteger randR = arc4random()%255;
        NSUInteger randG = (arc4random()%255);
        NSUInteger randB = (arc4random()%255);
        UIColor *randColor = [UIColor colorWithRed:randR/255.0 green:randG%255/255.0 blue:randB/255.0 alpha:1.0];
        
        // 设置前景色、文字间隔
        //        [attrStr addAttribute:NSForegroundColorAttributeName value:randColor range:NSMakeRange(i, 1)];
        //        [attrStr addAttribute:NSKernAttributeName value:@2 range:NSMakeRange(i, 1)];
        //        // 设置笔画的颜色和宽度（与前景色冲突NSForegroundColorAttributeName）
        //        [attrStr addAttribute:NSStrokeColorAttributeName value:randColor range:NSMakeRange(i, 1)];
        //        [attrStr addAttribute:NSStrokeWidthAttributeName value:@(8.0) range:NSMakeRange(i, 1)];
        // 阴影
        NSShadow * shadow = [[NSShadow alloc] init];
        shadow.shadowBlurRadius = 2; // 模糊度
        shadow.shadowColor = randColor; // 阴影颜色
        shadow.shadowOffset = CGSizeMake(2, 2); // 阴影偏移
        //        [attrStr addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(i, 1)];
        //        // 设置字体压缩、拉伸（正拉伸 负压缩）
        //        [attrStr addAttribute:NSExpansionAttributeName
        //                           value:@0.5
        //                           range:NSMakeRange(i, 1)];
        
        
        // 将以上属性加入属性字典统一设置
        attris = @{NSForegroundColorAttributeName:randColor,
                   NSBackgroundColorAttributeName:[UIColor clearColor],
                   NSFontAttributeName:[UIFont boldSystemFontOfSize:22],
                   NSKernAttributeName:@2,
                   NSStrokeColorAttributeName:randColor,
                   NSStrokeWidthAttributeName:@8.0,
                   NSShadowAttributeName:shadow,
                   NSExpansionAttributeName:@0.5
                   };
        [attrStr setAttributes:attris range:NSMakeRange(i, 1)];
        
        NSLog(@"%ld, %ld, %ld %@", randR, randG, randB, randColor);
    }
    // 计算属性字符串的宽度，为了设置图片的size使用
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attris context:nil];
    
    /// 初始化一个图文对象
    NSTextAttachment * attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"123"]; // 设置图片
    attachment.bounds = CGRectMake(0, 0, rect.size.width*0.8, rect.size.width*0.8); // 设置图片大小为文字宽度的 80%
    // 初始化一个NSAttributedString对象用于获取图文对象
    NSAttributedString * attribute1 = [NSAttributedString attributedStringWithAttachment:attachment];
    // 将新的NSAttibutedString对象插入旧的对象中
    [attrStr insertAttributedString:attribute1 atIndex:0];
    
    return attrStr;
}

@end
