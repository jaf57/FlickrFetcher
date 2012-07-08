//
//  ViewController.m
//  FlickrFetcher
//
//  Created by Joseph Fischetti on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopPlacesViewController.h"
#import "FlickrFetcher.h"
#import "TopPlacePhotoListViewController.h"

@interface TopPlacesViewController() <TopPlacePhotoListViewControllerDelagate>

@end

@implementation TopPlacesViewController
@synthesize topPlaces = _topPlaces;
@synthesize photoList = _photoList;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(void) setPhotoList:(NSArray *)photoList
{
    _photoList = photoList;
    
}

- (void) setTopPlaces:(NSArray *)topPlaces
{
    _topPlaces = [topPlaces sortedArrayUsingComparator: ^NSComparisonResult(id obj1, id obj2){
        return [[obj1 objectForKey:@"_content"] compare:[obj2 objectForKey:@"_content"]];
    }];
    [self.tableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"View Top Place Photos"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        self.photoList = [FlickrFetcher photosInPlace:[self.topPlaces objectAtIndex:indexPath.row] maxResults:50];
        NSString *title = [[self.topPlaces objectAtIndex:indexPath.row] objectForKey:@"_content"];
        [segue.destinationViewController setPlaceTitle:title];
        [segue.destinationViewController setPhotoList: self.photoList];
        [segue.destinationViewController setDelegate:self];
       
    }
}

-(NSArray *)getPhotoList: (TopPlacePhotoListViewController *) sender;
{
    return self.photoList;
}

#pragma mark - UITableView data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.topPlaces.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"top place";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    id place = [self.topPlaces objectAtIndex:indexPath.row];
    // place is a dictionary with strings as keys - _content contains the description
    int indexOfComma = [[place objectForKey:@"_content"] rangeOfString:@","].location;
    cell.textLabel.text = [[place objectForKey:@"_content"] substringToIndex:indexOfComma];
    cell.detailTextLabel.text = [[place objectForKey:@"_content"] substringFromIndex:indexOfComma+ 1];
    
    return cell;
}


#pragma mark - UITableView delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Top 100 Places";
	// Do any additional setup after loading the view, typically from a nib.
    NSArray *topPlaces = [FlickrFetcher topPlaces];
    self.topPlaces = topPlaces;
    for(NSString *s in topPlaces)
    {
        //NSLog(@"top place: %@", s);
    }
    NSLog(@"Count is %@", [NSString stringWithFormat:@"%d", [topPlaces count]]);
    //NSArray *photos = [FlickrFetcher photosInPlace:[topPlaces objectAtIndex:0] maxResults:2];
    //NSLog(@"Photo[0]: %@", [photos objectAtIndex:0]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


@end
