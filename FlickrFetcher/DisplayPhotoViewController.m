//
//  DisplayPhotoViewController.m
//  FlickrFetcher
//
//  Created by Joseph Fischetti on 3/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DisplayPhotoViewController.h"

@interface DisplayPhotoViewController() <UIScrollViewDelegate>
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@end

@implementation DisplayPhotoViewController
@synthesize imageView = _imageView;
@synthesize photo = _photo;
@synthesize scrollView = _scrollView;
@synthesize photoInfo = _photoInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.imageView setImage:self.photo];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = self.imageView.image.size;
    self.imageView.frame = CGRectMake(0, 0, self.imageView.image.size.width, self.imageView.image.size.height);
   
    CGFloat width = self.imageView.image.size.width;
    CGFloat height = self.imageView.image.size.height;
    
    if (width < height) {
        [self.scrollView zoomToRect:CGRectMake(0, 0, width, width) animated:NO];
    }
    else
    {
        [self.scrollView zoomToRect:CGRectMake(0, 0, height, height) animated:NO];
    }
    
    
    self.title = [self.photoInfo objectForKey:@"title"];
}
#define RECENTPHOTOS_KEY @"PhotoListViewController.recentPhotos"
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *list = [[defaults objectForKey:RECENTPHOTOS_KEY] mutableCopy];
    if (!list) {
        list = [NSMutableArray array];
    }
    
    if (![self doesPhotoArray:list containPhoto:self.photoInfo]) {
        [list insertObject: self.photoInfo atIndex:0];
        if (list.count > 20) {
            [list removeLastObject];
        }
        [defaults setObject:list forKey:RECENTPHOTOS_KEY];
        [defaults synchronize];   
    }
}

-(BOOL) doesPhotoArray:(NSArray *) list containPhoto: (NSDictionary *) photo{

    for (NSDictionary * photoInfo in list) {
        if ([[photoInfo objectForKey:@"id"] isEqual:[photo objectForKey:@"id"]]) {
            return YES;
        }
    }
    return NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [self setImageView:nil];
    [self setScrollView:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
