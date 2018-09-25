//
//  ViewController.m
//  StarT
//
//  Created by Tima on 25.09.2018.
//  Copyright © 2018 Timofey Gritkevich. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic) int contentHeight;
@property (nonatomic) NSArray *pictArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialSetup];
    [self startLoading];
}

- (void) initialSetup {
    self.contentHeight = 0;
    self.pictArray = @[@"https://mirpozitiva.ru/uploads/posts/2016-09/medium/1474011210_15.jpg",
                       @"https://st2.depositphotos.com/2627021/8153/i/450/depositphotos_81539246-stock-photo-fire-and-water-yin-yang.jpg",
                       @"https://vk.com/images/stickers/1/256b.png",
                       @"https://itc.ua/files/pics/2(698).jpg",
                       @"https://hsto.org/web/6dc/793/987/6dc793987e2a4fdeb27d8733aa2d8b5c.JPG",
                       @"https://img.joinfo.ua/i/2017/11/5a12977d34baf.jpg",
                       @"https://s1.1zoom.ru/prev2/542/Big_cats_Jaguars_Black_background_Snout_Whiskers_541938_253x225.jpg",
                       @"https://banana.by/uploads/thumbs/257/256952.jpg",
                       @"https://medialeaks.ru/wp-content/uploads/2017/10/catbread-03-600x400.jpg",
                       @"https://i.stack.imgur.com/whK34.jpg",
                       @"https://www.film.ru/sites/default/files/styles/epsa_1024x450/public/23780170-917709.jpg",
                       @"https://st.kp.yandex.net/images/film_iphone/iphone360_5932.jpg",
                       @"https://files.adme.ru/files/news/part_71/717460/preview-26015415-650x341-98-1477573911.jpg",
                       @"https://new-yorks.ru/wp-content/uploads/2012/11/%D0%A4%D0%BE%D1%82%D0%BE-%D0%9C%D0%B0%D0%BD%D1%85%D1%8D%D1%82%D1%82%D0%B5%D0%BD%D0%B0-%D0%B2-%D0%B2%D1%8B%D1%81%D0%BE%D0%BA%D0%BE%D0%BC-%D1%80%D0%B0%D0%B7%D1%80%D0%B5%D1%88%D0%B5%D0%BD%D0%B8%D0%B8.jpg",
                       @"https://api.culture.pl/sites/default/files/styles/1920_auto/public/field/wideo/w311.jpg?itok=_rxjb9vP",
                       @"https://api.culture.pl/sites/default/files/styles/1920_auto/public/field/wideo/w311.jpg?itok=_rxjb9vP",
                       @"https://rampaga.ru/_sf/58/23039362.jpg",
                       @"https://st2.depositphotos.com/1011081/9849/i/450/depositphotos_98493102-stock-photo-saturn-high-resolution-images-presents.jpg",
                       @"https://i.pinimg.com/originals/59/84/f5/5984f5792c17665bafff93157c6c5237.jpg",
                       @"https://az877327.vo.msecnd.net/~/media/images/products/options%20and%20accessories/options%20projectiondesign/en41%20standard%20zoom%20jpg.jpg?v=1&h=550&w=800&crop=1",
                       @"https://images.kz.prom.st/70794227_w640_h640_cid595597_pid49484047-d18db89b.jpg",
                       @"https://img13.joybuy.com/N0/s800x800_jfs/t3058/243/2973738946/75502/41d7026e/57ea09deNc6ab5d96.jpg.dpg",
                       @"https://img.freepik.com/free-photo/high-resolution-of-gray-marble_42044-2229.jpg?size=338&ext=jpg",
                       @"https://droidnews.ru/img/2016/april/peredovye_tehnologii_i_vysokoe_razreshenie_obzor_monitora_aoc_q2577pwq_1.jpg",
                       @"https://cs4.pikabu.ru/post_img/2015/09/07/11/1441654805_822158847.jpg",
                       @"https://st3.depositphotos.com/1011158/19177/i/1600/depositphotos_191777114-stock-photo-high-resolution-orthorectified-orthorectification-aerial.jpg",
                       @"https://www.ixbt.com/img/n1/news/2018/7/1/Samsungcentral.com_galaxys10render1_large.png",
                       @"https://st2.depositphotos.com/4142621/6582/i/950/depositphotos_65825369-stock-photo-high-resolution-panoramic-view-of.jpg",
                       @"https://images.ua.prom.st/1070203499_w640_h640_cid2860197_pid658026264-d516785e.jpg",
                       @"https://avatars.mds.yandex.net/get-pdb/477388/583830c6-e5b3-44d0-9130-76112b3b812b/s1200"];
}

- (void) startLoading {
    
    for (NSString *stringUrl in self.pictArray) {
        [[Manager shared] getImage:stringUrl completionBlock:^(NSData *image) {
            dispatch_sync(dispatch_get_main_queue(), ^{
               
                UIImageView *imageView = [[UIImageView  alloc] initWithFrame:CGRectMake(0, self.contentHeight, self.view.frame.size.width, 200)];
                imageView.image = [UIImage imageWithData:image];
                [imageView sizeToFit];
                
                if (imageView.frame.size.width > self.view.frame.size.width) {
                    CGFloat w = imageView.frame.size.width;
                    CGFloat h = imageView.frame.size.height;
                    CGFloat nh = self.view.frame.size.width*h/w;
                    
                    [imageView setFrame:CGRectMake(0, self.contentHeight, self.view.frame.size.width, nh)];
                    [imageView setContentMode:UIViewContentModeScaleAspectFit];
                };
                
                self.contentHeight = self.contentHeight + imageView.frame.size.height;
                [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.contentHeight)];
                [self.scrollView addSubview:imageView];
                
                if ([[self.scrollView subviews] count] == self.pictArray.count) {
                    [self showAlert];
                }
            });
            
        }];
    }
}

-(void) showAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Загрузка завершена" message:@"Загрузка успешно завершена" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alert animated:YES completion:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    
}


@end
