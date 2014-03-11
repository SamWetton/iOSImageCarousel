//
//  ICViewController.m
//  iOSImageCarousel
//
//  Created by Sam on 28/02/2014.
//  Copyright (c) 2014 SamWetton. All rights reserved.
//

//_______________________________________________________________________________________________________________Headers
//======================================================================================================================
#import "ICViewController.h"
#import "ICImageCarouselViewController.h"

//_____________________________________________________________________________________________________________Interface
//======================================================================================================================
@interface ICViewController ()

@property (nonatomic, strong) ICImageCarouselViewController *carouselController;

@end

//________________________________________________________________________________________________________Implementation
//======================================================================================================================
@implementation ICViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    // Create array of UIImages
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:8];
    for(int i = 1; i <= 8; i ++){
        NSString *name = [@"Img" stringByAppendingFormat:@"%d", i];
        [images addObject:[UIImage imageNamed:name]];
    }
    
    // Create carousel controllers
    self.carouselController = [ICImageCarouselViewController imageCarouselViewControllerWithImages:images
                                                                                               view:self.carouselView
                                                                                       pageControl:self.pageControl];
    
    self.sideStepper.value = self.carouselController.sideMargin;
    self.topBottomStepper.value = self.carouselController.topBottomMargin;
    self.overlapStepper.value = self.carouselController.nextPreviousOverlap;

    [self refreshSideLabel];
    [self refreshTopBottomLabel];
    [self refreshOverlapLabel];
    
}

//===== Private =====//
-(void)refreshSideLabel{
    self.sideLabel.text = [NSString stringWithFormat:@"%f", self.sideStepper.value];
}
-(void)refreshTopBottomLabel{
    self.topBottomLabel.text = [NSString stringWithFormat:@"%f", self.topBottomStepper.value];
}
-(void)refreshOverlapLabel{
    self.overlapLabel.text = [NSString stringWithFormat:@"%f", self.overlapStepper.value];
}

//===== IBActions =====//
-(IBAction)stepper:(id)sender{
    if(sender == self.sideStepper){
        self.carouselController.sideMargin = self.sideStepper.value;
        [self refreshSideLabel];
    }
    else if(sender == self.topBottomStepper){
        self.carouselController.topBottomMargin = self.topBottomStepper.value;
        [self refreshTopBottomLabel];
    }
    else if(sender == self.overlapStepper){
        self.carouselController.nextPreviousOverlap = self.overlapStepper.value;
        [self refreshOverlapLabel];
    }
    
}
@end
