# SRActionSheet
**a brief style ActionSheet which is very similar to WeChat's ActionSheet.**

![image](https://raw.githubusercontent.com/guowilling/SRActionSheet/master/demoscreen.png)

## How to using

````objc

[SRActionSheet sr_showActionSheetViewWithTitle:@"This is show with BLOCK."
                             cancelButtonTitle:@"Cancle"
                        destructiveButtonTitle:@"OK"
                             otherButtonTitles:@[@"0", @"1", @"2"]
                              selectSheetBlock:^(SRActionSheet *actionSheetView, NSInteger actionIndex) {
                                 NSLog(@"%zd", actionIndex);
                             }];
````

## or

````objc
[SRActionSheet sr_showActionSheetViewWithTitle:@"This is show with DELEGATE."
                             cancelButtonTitle:@"Cancle"
                        destructiveButtonTitle:@"OK"
                             otherButtonTitles:@[@"0", @"1", @"2"]
                                      delegate:self];
                                      
- (void)actionSheet:(SRActionSheet *)actionSheet didSelectSheet:(NSInteger)index {
    
    NSLog(@"%zd", index);
}
````

**Have Fun.**