//
//  ICImageCarouselViewController.m
//  iOSImageCarousel
//
//  Created by Sam on 28/02/2014.
//  Copyright (c) 2014 SamWetton. All rights reserved.
//

//_______________________________________________________________________________________________________________Headers
//======================================================================================================================
#import "ICImageCarouselViewController.h"

//_____________________________________________________________________________________________________________Interface
//======================================================================================================================
@interface ICImageCarouselViewController ()


// Model
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, strong) NSMutableArray *pageViews;

// View
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) UIPageControl *pageControl;

@end

//________________________________________________________________________________________________________Implementation
//======================================================================================================================
@implementation ICImageCarouselViewController

//===== Properties =====//
-(void)setSideMargin:(NSInteger)gapBetweenImages{
    _sideMargin = gapBetweenImages;
    [self refreshPageFrames];
}
-(void)setTopBottomMargin:(NSInteger)topBottomMargin{
    _topBottomMargin = topBottomMargin;
    [self refreshPageFrames];
}
-(void)setNextPreviousOverlap:(float)nextPreviousOverlap{
    _nextPreviousOverlap = nextPreviousOverlap;
    [self refreshScrollViewFrame];
    [self refreshPageFrames];
}
-(void)setImageContentMode:(UIViewContentMode)imageContentMode{
    _imageContentMode = imageContentMode;
}


//===== Core =====//
+(ICImageCarouselViewController *)imageCarouselViewControllerWithImages:(NSArray *)imagesArray
                                                                   view:(UIView *)view
                                                            pageControl:(UIPageControl *)pageControl{
    return [[ICImageCarouselViewController alloc] initWithImages:imagesArray
                                                            view:view
                                                     pageControl:pageControl];
}

-(id)initWithImages:(NSArray *)imagesArray view:(UIView *)view pageControl:(UIPageControl *)pageControl{
    self = [super init];
    if(self){
        
        // Default Values
        _sideMargin = 4;
        _topBottomMargin = 4;
        _nextPreviousOverlap = .2;
        _imageContentMode = UIViewContentModeScaleAspectFill;
        
        
        // Images and pageViews arrays
        self.images = imagesArray;
        self.pageViews = [NSMutableArray arrayWithCapacity:self.images.count];
        for(int i = 0; i < self.images.count; i++){
            [self.pageViews addObject:[NSNull null]];
        }
        
        // Views
        self.view = view;
        self.view.clipsToBounds = YES;
        
        // Scroll View
        [self setupScrollView];

        // Page Control
        self.pageControl = pageControl;
        self.pageControl.currentPage = 0;
        self.pageControl.numberOfPages = self.images.count;
        
        [self loadVisiblePages];
    }
    return self;
}
-(void)setupScrollView{
    
    // Create scrollView and setup parameters
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.clipsToBounds = NO;
    
    // Remove scrollers
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    // Set Frame and Contetnt Size
    [self refreshScrollViewFrame];
    
    // Add to view
    [self.view addSubview:self.scrollView];
    
}


//===== UIScrollView Delegate =====//
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self loadVisiblePages];
}

//===== Private =====//
-(void)loadVisiblePages{
    // First, determine which page is currently visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page = (NSInteger)floor((self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f));
    
    // Update the page control
    self.pageControl.currentPage = page;
    
    // Work out which pages you want to load
    NSInteger firstPage = page - 1;
    NSInteger lastPage = page + 1;
    
    // Purge anything before the first page
    for (NSInteger i=0; i<firstPage; i++) {
        [self purgePage:i];
    }
    
    // Load pages in our range
    for (NSInteger i=firstPage; i<=lastPage; i++) {
        [self loadPage:i];
    }
    
    // Purge anything after the last page
    for (NSInteger i=lastPage+1; i<self.images.count; i++) {
        [self purgePage:i];
    }
}
-(void)loadPage:(NSInteger)page{
    
    // Check page is in range, do nothing if it's not
    if (page < 0 || page >= self.images.count)
        return;
    
    
    // Create page, if it hasn't already been made.
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView == [NSNull null]) {

        // Create page view and add to scroll view
        UIImageView *newPageView = [[UIImageView alloc] initWithImage:[self.images objectAtIndex:page]];
        newPageView.frame = [self frameForPage:page];
        newPageView.clipsToBounds = YES;
        newPageView.contentMode = self.imageContentMode;
        [self.scrollView addSubview:newPageView];
        
        // Add to page view array
        [self.pageViews replaceObjectAtIndex:page withObject:newPageView];
    }
}
-(void)purgePage:(NSInteger)page {
    
    // Check page is in range, do nothing if it's not
    if (page < 0 || page >= self.images.count) {
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIView *pageView = [self.pageViews objectAtIndex:page];
    if ((NSNull*)pageView != [NSNull null]) {
        [pageView removeFromSuperview];
        [self.pageViews replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}

-(void)refreshScrollViewFrame{
    
    float w = (self.view.frame.size.width - 2 * self.sideMargin) /  (1.0 + 2*self.nextPreviousOverlap);
    float h = self.view.frame.size.height;
    
    float x = self.nextPreviousOverlap * w  + self.sideMargin;
    float y = 0;

    // Frame
    self.scrollView.frame = CGRectMake(x, y, w, h);

    // Content View
    self.scrollView.contentSize = CGSizeMake(w * self.images.count, h);
    
}

-(CGRect)frameForPage:(NSInteger)page{
    // Make image frame
    float x = self.scrollView.bounds.size.width * page + self.sideMargin;
    float y = self.topBottomMargin;
    float w = self.scrollView.bounds.size.width - self.sideMargin * 2;
    float h = self.scrollView.bounds.size.height - self.topBottomMargin * 2;
    
    return CGRectMake(x, y, w, h);
}
-(void)refreshPageFrames{
    for(NSInteger i = 0; i < self.pageViews.count; i++){
        UIView *pageView = [self.pageViews objectAtIndex:i];
        if ((NSNull*)pageView != [NSNull null]) {
            pageView.frame = [self frameForPage:i];
        }
    }
}
@end

