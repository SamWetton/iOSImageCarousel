//
//  ICViewController.h
//  iOSImageCarousel
//
//  Created by Sam on 28/02/2014.
//  Copyright (c) 2014 SamWetton. All rights reserved.
//

//_______________________________________________________________________________________________________________Headers
//======================================================================================================================
#import <UIKit/UIKit.h>
@class ICImageCarouselViewController;

//_____________________________________________________________________________________________________________Interface
//======================================================================================================================
@interface ICViewController : UIViewController

//===== Properties =====//
@property (nonatomic, strong, readonly) ICImageCarouselViewController *carouselController;

//===== IBOutlets =====//
@property (nonatomic, assign) IBOutlet UIView *carouselView;
@property (nonatomic, assign) IBOutlet UIPageControl *pageControl;

@property (nonatomic, assign) IBOutlet UIStepper *sideStepper;
@property (nonatomic, assign) IBOutlet UILabel *sideLabel;

@property (nonatomic, assign) IBOutlet UIStepper *topBottomStepper;
@property (nonatomic, assign) IBOutlet UILabel *topBottomLabel;

@property (nonatomic, assign) IBOutlet UIStepper *overlapStepper;
@property (nonatomic, assign) IBOutlet UILabel *overlapLabel;

//===== IBActions =====//
-(IBAction)stepper:(id)sender;


@end
