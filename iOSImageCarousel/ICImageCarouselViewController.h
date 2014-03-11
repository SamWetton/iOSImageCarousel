//
//  ICImageCarouselViewController.h
//  iOSImageCarousel
//
//  Created by Sam on 28/02/2014.
//  Copyright (c) 2014 SamWetton. All rights reserved.
//

//_______________________________________________________________________________________________________________Headers
//======================================================================================================================
#import <UIKit/UIKit.h>

//_____________________________________________________________________________________________________________Interface
//======================================================================================================================
@interface ICImageCarouselViewController : UIViewController <UIScrollViewDelegate>

//===== Properties =====//
@property (nonatomic, assign) NSInteger sideMargin;
@property (nonatomic, assign) NSInteger topBottomMargin;
@property (nonatomic, assign) float nextPreviousOverlap;
@property (nonatomic, assign) UIViewContentMode imageContentMode;


//===== Core =====//
+(ICImageCarouselViewController *)imageCarouselViewControllerWithImages:(NSArray *)imagesArray
                                                                   view:(UIView *)view
                                                            pageControl:(UIPageControl *)pageControl;

@end
