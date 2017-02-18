//
//  ViewController.m
//  Service_App
//
//  Created by Ocs Dev on 08/02/17.
//  Copyright © 2017 Ocs Dev. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MVPlaceSearchTextField.h"
#import "SAHomeTableViewCell.h"
#import "SAConfig.h"

@interface ViewController ()<PlaceSearchTextFieldDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>

{
    UIButton *search_button;
    UIButton *cancel_button;
    
    NSArray *locArray;
    NSString *locatedAt;
    NSString *locatedAt1;
    NSString *locatedAt2;

    int textfieldValue;
    UIView *typeLocView;
    UIButton *findLocButton;
}


@property (strong, nonatomic) IBOutlet GMSMapView *map_view;

@property (strong, nonatomic) IBOutlet MVPlaceSearchTextField *search_Field;

@property (strong, nonatomic) IBOutlet UIView *top_view;
@property (strong, nonatomic) IBOutlet UILabel *reqLocLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentAddressLab;
@property (strong, nonatomic) IBOutlet UIButton *menuButton;
- (IBAction)menuButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *searchButton;
- (IBAction)search_Button:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *table_View;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    
    _table_View.delegate = self;
    _table_View.dataSource = self;
    _table_View.scrollEnabled = NO;
    typeLocView.hidden =YES;
    _search_Field.delegate = self;
    
    [self textFont];
    
    locArray = [[NSArray alloc]initWithObjects:@"Guindy chennai Tamilnadu India",@"George Town chennai Tamilnadu India", nil];
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:13.0515
                                                            longitude:80.2498
                                                                 zoom:15];
   // GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _map_view.myLocationEnabled = YES;
    _map_view.camera =camera;
    
    //self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(13.0515, 80.2498);
    marker.title = @"Chennai";
    marker.snippet = @"India";
    marker.map = _map_view;
    
    
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocation *location = [[CLLocation alloc]initWithLatitude:13.0515 longitude:(80.2498)];
    
    //new:
    [ceo reverseGeocodeLocation:location
              completionHandler:^(NSArray *placemarks, NSError *error) {
                  CLPlacemark *placemark = [placemarks objectAtIndex:0];
                  if (placemark) {
                      
                      NSLog(@"placemark %@",placemark);
                      //        NSString *locatedAt = [[placemark.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "];
                      
                      locatedAt = placemark.subAdministrativeArea;
                      locatedAt1 = placemark.subLocality;
                      locatedAt2 = placemark.postalCode;
                      
                      NSLog(@"addressDictionary %@", placemark.addressDictionary);
                      NSLog(@"I am currently at %@,%@ %@",locatedAt1,locatedAt,locatedAt2);
                      _currentAddressLab.text = [NSString stringWithFormat:@"%@,%@,%@",locatedAt1,locatedAt,locatedAt2];
                  }
                  else {
                      NSLog(@"Could not locate");
                  }
              }
     ];

    
    //[_map_view addSubview:_top_view];
    
    //textfield:
    
    _search_Field.hidden =YES;
    _search_Field.placeSearchDelegate                 = self;
    _search_Field.strApiKey                           = @"AIzaSyCDi2dklT-95tEHqYoE7Tklwzn3eJP-MtM";
    _search_Field.superViewOfList                     = self.view;  // View, on which Autocompletion list should be appeared.
    _search_Field.autoCompleteShouldHideOnSelection   = YES;
    //_searchField.maximumNumberOfAutoCompleteRows     = 5;
    _search_Field.maximumNumberOfAutoCompleteRows     = 4;
    
    _search_Field.borderStyle = UITextBorderStyleNone;
    [_search_Field setNeedsDisplay];

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _search_Field.autoCompleteTableView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];
   }
- (void)textFieldDidChange:(NSNotification *)notification {
     _search_Field.autoCompleteTableView.hidden = NO;
    _table_View.hidden = YES;
  
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
 [self getLocationFromAddressString:_search_Field.text];
}


-(void)viewDidAppear:(BOOL)animated{
    
    CGFloat TableviewmaxY = CGRectGetMaxY(_top_view.frame);
    
    
    //Optional Properties
    _search_Field.autoCompleteRegularFontName =  @"HelveticaNeue-Bold";
    _search_Field.autoCompleteBoldFontName = @"HelveticaNeue";
    _search_Field.autoCompleteTableCornerRadius=1.0;
    //_searchField.autoCompleteRowHeight=35;
    _search_Field.autoCompleteRowHeight=50;
    _search_Field.autoCompleteTableCellTextColor=[UIColor colorWithWhite:0.131 alpha:1.0];
    //_searchField.autoCompleteFontSize=14;
    _search_Field.autoCompleteFontSize=14;
    _search_Field.autoCompleteTableBorderWidth=0.0;
    _search_Field.autoCompleteTableCellTextColor = [UIColor lightGrayColor];
    _search_Field.showTextFieldDropShadowWhenAutoCompleteTableIsOpen=YES;
    _search_Field.autoCompleteShouldHideOnSelection=YES;
    _search_Field.autoCompleteShouldHideClosingKeyboard=YES;
    _search_Field.autoCompleteShouldSelectOnExactMatchAutomatically = YES;
    
    //_searchField.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_searchField.frame.size.width)*0.5, _searchField.frame.size.height+100.0, _searchField.frame.size.width, 200.0);
    _search_Field.autoCompleteTableFrame = CGRectMake((self.view.frame.size.width-_top_view.frame.size.width)*0.5, TableviewmaxY - 7, _top_view.frame.size.width, 200.0);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Place search Textfield Delegates

-(void)placeSearch:(MVPlaceSearchTextField*)textField ResponseForSelectedPlace:(GMSPlace*)responseDict{
    [self.view endEditing:YES];
    NSLog(@"SELECTED ADDRESS :%@",responseDict);
}

-(void)placeSearchWillShowResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearchWillHideResult:(MVPlaceSearchTextField*)textField{
    
}
-(void)placeSearch:(MVPlaceSearchTextField*)textField ResultCell:(UITableViewCell*)cell withPlaceObject:(PlaceObject*)placeObject atIndex:(NSInteger)index{
    //if(index%2==0){
    //  cell.contentView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
    // }else{
    //    cell.contentView.backgroundColor = [UIColor whiteColor];
    //}
    cell.contentView.backgroundColor = [UIColor whiteColor];
}


- (IBAction)menuButton:(id)sender {
}
- (IBAction)search_Button:(id)sender
{
     textfieldValue = 1;
    _table_View.scrollEnabled = YES;
    _table_View.hidden = NO;
    _search_Field.hidden =NO;
    _menuButton.hidden =YES;
    _reqLocLabel.hidden =YES;
    _currentAddressLab.hidden =YES;
    _searchButton.hidden =YES;
     _search_Field.autoCompleteTableView.hidden = NO;
   [_search_Field.autoCompleteTableView reloadData];
    
    CGFloat minX = CGRectGetMinX(_menuButton.frame);
    //CGFloat maxX = CGRectGetMaxX(_menuButton.frame);
    CGFloat minY =CGRectGetMinY(_menuButton.frame);
    
    search_button = [[UIButton alloc]initWithFrame:CGRectMake(minX, minY, _searchButton.frame.size.width, _searchButton.frame.size.height)];
    UIImage *btnImage = [UIImage imageNamed:@"search_icon"];
    [search_button setBackgroundImage:btnImage forState:UIControlStateNormal];
    [_top_view addSubview:search_button];
    
    CGFloat _searchButtonminX = CGRectGetMinX(_searchButton.frame);
    CGFloat _searchButtonminY =CGRectGetMinY(_searchButton.frame);
    
    cancel_button = [[UIButton alloc]initWithFrame:CGRectMake(_searchButtonminX, _searchButtonminY, _searchButton.frame.size.width, _searchButton.frame.size.height)];
    UIImage *btnImage1 = [UIImage imageNamed:@"search_close"];
    [cancel_button setBackgroundImage:btnImage1 forState:UIControlStateNormal];
    [cancel_button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [_top_view addSubview:cancel_button];
    [_table_View reloadData];
    
    _tableHeight.constant = 170 + 60;
    
}
-(void)locationSearch
{
    typeLocView.hidden = YES;
    _table_View.hidden = YES;
    
}
-(void)cancelAction
{
    search_button.hidden =YES;
    _search_Field.hidden =YES;
    cancel_button.hidden = YES;
    //    _tv.hidden =YES;
    typeLocView.hidden =YES;
    _table_View.hidden = NO;
    textfieldValue = 5;
    [_search_Field endEditing:YES];
    
    _tableHeight.constant = 170;
        //1st view:
    _menuButton.hidden =NO;
    _reqLocLabel.hidden =NO;
    _currentAddressLab.hidden =NO;
    _searchButton.hidden =NO;
    _search_Field.text = @"";
    
   _search_Field.autoCompleteTableView.hidden = YES;
    [_table_View reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

{
    if(section == 0)
    {
        return 1;
    }
    else{
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [_table_View setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    SAHomeTableViewCell *cell = [_table_View dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    if(indexPath.section==0)
    {
        UIImageView *imageCell = [[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 23, 23)];
        imageCell.image = [UIImage imageNamed:@"location_icon"];
        [cell addSubview:imageCell];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(40, 8, 300, 20)];
        label.text = @"Use my current location";
        label.font = [UIFont systemFontOfSize:[self cellLabel]];
        label.textColor = [UIColor darkGrayColor];
        [cell addSubview:label];
        
        
        
    }
    
    else if (indexPath.section==1)
    {
        if(indexPath.row == 1)
        {
            cell.preservesSuperviewLayoutMargins = false;
            cell.separatorInset = UIEdgeInsetsZero;
            cell.layoutMargins = UIEdgeInsetsZero;
        }
        
        cell.imageView.image =[UIImage imageNamed:@"recent_location_icon"];
        cell.textLabel.font = [UIFont systemFontOfSize:[self cellLabel]];
        cell.textLabel.text = [locArray objectAtIndex:indexPath.row];
        
        
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    if(section == 1)
    {
        return @"Recent Locations";
    }
    else{
        return @"";
    }
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1];
    
    v.textLabel.textColor = [UIColor grayColor];
    v.textLabel.font = [UIFont systemFontOfSize:[self cellLabel] weight:UIFontWeightRegular];
  //  v.textLabel.font = [UIFont systemFontOfSize:[self cellLabel]];
    CGRect headerFrame = v.frame;
    v.textLabel.frame = headerFrame;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if(indexPath.section == 1)
    {
        return 50.0;
    }
    else{
        return 40;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    int height;
    
    
   if(textfieldValue == 1 && section == 1)
   {
    height =  60;
   }
    else
    {
        height = 0;
    }
    return height;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"Type a Location and We'll find you";
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    view.tintColor = [UIColor whiteColor];

    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textAlignment = NSTextAlignmentCenter;
    [header.textLabel setTextColor:[UIColor blackColor]];
}

-(void)textFont
{
    if(IS_IPHONE5)
    {
        _reqLocLabel.font =  [UIFont systemFontOfSize:12];

        _currentAddressLab.font = [UIFont systemFontOfSize:12];
    }
    else if(IS_IPHONE6)
    {
        _reqLocLabel.font =  [UIFont systemFontOfSize:14];

         _currentAddressLab.font = [UIFont systemFontOfSize:14];
    }
    else if(IS_IPHONE6_Plus)
    {
        _reqLocLabel.font =  [UIFont systemFontOfSize:16];

        _currentAddressLab.font = [UIFont systemFontOfSize:16];
    }
    else
    {
        _reqLocLabel.font =  [UIFont systemFontOfSize:12];

        _currentAddressLab.font = [UIFont systemFontOfSize:12];
    }


}
-(CGFloat)cellLabel{
    CGFloat value;
    
    if(IS_IPHONE5)
    {
        value = 12;
        
    }
    else if(IS_IPHONE6)
    {
        value = 14;
        
    }
    else if(IS_IPHONE6_Plus)
    {
        value = 16;
        
    }
    else
    {
        value = 12;
        
    }
    return value;
    
}

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
   
    
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:center.latitude
                                                            longitude:center.longitude
                                                                 zoom:15];
    // GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _map_view.myLocationEnabled = YES;
    _map_view.camera =camera;
    
    //self.view = mapView;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(center.latitude, center.longitude);
    marker.title = @"Chennai";
    marker.snippet = @"India";
    marker.map = _map_view;
    
    GMSMutablePath *path = [GMSMutablePath path];
    [path addCoordinate:CLLocationCoordinate2DMake(@(13.0515).doubleValue,@(80.2498).doubleValue)];
    [path addCoordinate:CLLocationCoordinate2DMake(center.latitude, center.longitude)];
    
    GMSPolyline *rectangle = [GMSPolyline polylineWithPath:path];
    rectangle.strokeWidth = 2.f;
    rectangle.strokeColor = [UIColor redColor];
    rectangle.map = _map_view;
   // self.view=_map_view;
    
     return center;

}

@end
