# SRActionSheet
**A brief style ActionSheet which is very similar to WeChat's ActionSheet.**

> **There are two styles for other action items:**    
> 1.Only title, default alignment is left.    
> 2.Title and image, default alignment is center.    
> You can custom alignment through otherActionItemAlignment property.

![image](./show1.jpg)
![image](./show2.jpg)    

![image](./show3.jpg)
![image](./show4.jpg)

### Usage

````objc
// Only Title 
// Alignment left.
SRActionSheet *actionSheet = [[SRActionSheet alloc] initWithTitle:@"分享"
                                                      cancelTitle:@"取消"
                                                 destructiveTitle:nil
                                                      otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                                         delegate:self];
actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentLeft;
[actionSheet show];         

// Alignment center which is default.
[SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
                                   cancelTitle:@"取消"
                              destructiveTitle:nil
                                   otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                   otherImages:nil
                              selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                  NSLog(@"%zd", index);
                              }];                         
````

````objc
// Title And Image  
// Alignment left which is default.
[SRActionSheet sr_showActionSheetViewWithTitle:@"分享"
                                   cancelTitle:@"取消"
                              destructiveTitle:nil
                                   otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                   otherImages:@[[UIImage imageNamed:@"share_wx_friend"],
                                                 [UIImage imageNamed:@"share_wx_pengyouquan"],
                                                 [UIImage imageNamed:@"share_qq_friend"],
                                                 [UIImage imageNamed:@"share_qq_kongjian"]]
                              selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger index) {
                                  NSLog(@"%zd", index);
                              }];

// Alignment center.     
SRActionSheet *actionSheet = [[SRActionSheet alloc] initWithTitle:@"分享"
                                                      cancelTitle:@"取消"
                                                 destructiveTitle:nil
                                                      otherTitles:@[@"微信好友", @"微信朋友圈", @"QQ", @"QQ空间"]
                                                      otherImages:@[[UIImage imageNamed:@"share_wx_friend"],
                                                                    [UIImage imageNamed:@"share_wx_pengyouquan"],
                                                                    [UIImage imageNamed:@"share_qq_friend"],
                                                                    [UIImage imageNamed:@"share_qq_kongjian"]]
                                                         delegate:self];
actionSheet.otherActionItemAlignment = SROtherActionItemAlignmentCenter;
[actionSheet show];
````

**If you have any question, please issue or contact me.**

**If you like it, please star me, thanks a lot.**

**Have Fun.**

