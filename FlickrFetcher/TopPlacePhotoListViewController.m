//
//  TopPlacePhotoListViewController.m
//  FlickrFetcher
//
//  Created by Joseph Fischetti on 3/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TopPlacePhotoListViewController.h"
#import "FlickrFetcher.h"
#import "DisplayPhotoViewController.h"

@implementation TopPlacePhotoListViewController
@synthesize photoList = _photoList;
@synthesize delegate = _delegate;
@synthesize placeTitle = _placeTitle;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) setPhotoList:(NSArray *)photoList
{
    _photoList = photoList;
    [self.tableView reloadData];
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Display Photo"])
    {
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        NSDictionary *photo = [self.photoList objectAtIndex:indexPath.row];
        NSURL *url = [FlickrFetcher urlForPhoto: photo format:FlickrPhotoFormatLarge];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        UIImage * img = [UIImage imageWithData:imgData];        
        [segue.destinationViewController setPhoto:img];
        [segue.destinationViewController setPhotoInfo:photo];
    }
}

/*
-(void) setDelegate:(id<TopPlacePhotoListViewControllerDelagate>)delegate
{
    _delegate = delegate;
    [self.tableView reloadData];
}
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = self.placeTitle;
	// Do any additional setup after loading the view, typically from a nib.
    //NSArray *topPlaces = [FlickrFetcher topPlaces];
    //self.photoList = [FlickrFetcher photosInPlace:[topPlaces objectAtIndex:0] maxResults:2];
    //NSLog(@"Photo[0]: %@", [photos objectAtIndex:0]);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.photoList.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"top place photos";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    id photo = [self.photoList objectAtIndex:indexPath.row]; //[self.delegate getPhotoList:self]
    NSString *title = [photo valueForKey:@"title"];
    NSString *subtitle = [photo valueForKeyPath:@"description._content"];
    if (![title isEqualToString:@""]) {
        cell.textLabel.text = title;
    }
    else
    {
        if (![subtitle isEqualToString:@""]) {
            cell.textLabel.text = subtitle;
        }
        else
        {
            cell.textLabel.text = @"Unknown";
        }
    }
    
    // only set subtitle if the title is set to the photos actual title
    if (![subtitle isEqualToString:@""] && ![title isEqualToString:@""]) {
        cell.detailTextLabel.text = subtitle;
    }
    else
    {
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
