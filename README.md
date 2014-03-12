iOSImageCarousel
================

An Image Carousel for iOS


##Usage

Add the ICImageCarouselViewController.h and .m to your project.

Create an ICImageCarouselViewController object passing it in an arry of UIImages, an existing but empty UIView and and existing UIPageControl (optional).

Test it works :)

##Optional

Side/top/bottom margins can be set in pixels, default to 4px each. 

    myImageCarouselController.sideMargin = 8;
    myImageCarouselController.topBottomMargin = 20;
  
The amount of the next and previous image shown can be changed. Setting to 0 will show none of eithe next or previous, setting to 1 will show all of the both (so 3 whole images can be seen at once. default is .2

    myImageCarouselController.nextPreviousOverlap = .5;
  
