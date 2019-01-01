//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // MA - This is the Apple library that needs to be imported if you want to work with locations
import Alamofire // MA - This is for networking
import SwiftyJSON // MA - this is for parsing the data once recieved.

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    // the class 'WeatherViewController' needs to conform to 'CLLocationManagerDelegate' for this class to be able to handle Location related jobs.
    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    // may have to use this as weather_URL - http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=
    // or this api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}
    let APP_ID = "88aa3cd5518111ccdac03e4e90c06199"
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager() // creating an object of the class 'CLLocationManager'. This object has all the properties Apple has coded into the CLLocationManager Class.
    let weatherDataModel = WeatherDataModel() // creating an object, so the properties of this object can be updated from this ViewController class.

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        
        locationManager.delegate = self
        // We are setting the class 'WeatherViewController' (denoted here by the keyword self) as the delegate of the object 'locationManager' (which is of the class CLLocationManager). This has to be done so 'WeatherViewController can let the universe know its CLLocationManager handling capabilities
       
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        // This property set the accuracy of the location data. More accuracy = more battery
        
        locationManager.requestWhenInUseAuthorization()
        // This Method asks the user for permission to use thier location.
        
        locationManager.startUpdatingLocation()
        // This Method as its named, starts updating the location information. Two methods need to be written to determine what happens when this property has done its thing.
        // didUpdateLocations - this is when a location is updated
        // didFailWithError - this is when a there was an error when updating location.
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    
    func getWeatherData (url : String, parameters : [String : String]) { // This function is taking inputs from the didUpdateLocation method
        
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            
            // This is where the networking starts... The above line is to send to the URL, with .get method, the parameters i.e. the coordinates  and the APP_ID.
            // The URL and the Parameters have been passed in by the funciton.
            // The formatting of the code is dictated by Alamofire and is confusing. Just use this format and check it works before proceeding. It doesnt follow any formatting i am used to.
           
            response in  // Alamo fire formatting
            
            if response.result.isSuccess {   // This is checking to see if a successfull result was recieved.
                print("Success ! Got the weather data !")
                
                let weatherJSON : JSON = JSON(response.result.value!)  // this is the response from openWeatherMaps being put into a package.
                
                print(weatherJSON)
                
                self.updateWeatherData(json: weatherJSON)
                
                
            } else {                        // This is the error handling
                print(response.result.error!)
                self.cityLabel.text = "Connection issues :( "
            }
        }
        
    }
    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    
    func updateWeatherData (json : JSON){
        
        if let tempResult = json["main"]["temp"].double  // This is the way to parse the data receive in a JSON format.
        // if let used in the above line for error handling. In case of a nil result, the else part of the code will display 'Weather unavailable'
        
        {
        weatherDataModel.temperature = Int(tempResult - 273.15)
        weatherDataModel.city = json["name"].stringValue
        weatherDataModel.condition = json["weather"]["id"].intValue  // This will be used to determine what picture to use.
        weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
        // The above line of code, takes the value of the 'condition' in the weaatherDataModel.
        // plugs 'condition' into the function 'updateWeatherIcon' (which is also in the data model)
        // and 'returns' a string value, which will then be used to pick the correct picture.
        }
        else {
            cityLabel.text = "Weather Data Unavailable"
        }
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    // MA - the Below function is necessary to deal with what happens when locationManager.startUpdatingLocation generates a result
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLoc = locations[locations.count - 1] // this line pics the last, most accurate location, from the CLLocation array
        if userLoc.horizontalAccuracy > 0 { // this line to confirm location data is valid
            
            print("success, got location")
            locationManager.stopUpdatingLocation() // this method to stop updating the location (after we've got a valid value) as it is energy intensive.
            
            print("the latitude is :\(userLoc.coordinate.latitude), and the Latitude is : \(userLoc.coordinate.longitude)")
            // The above line prints the coordintates to the console
            // Check if this works !!
            
            
            
            // If we have successfully managed to obtain location data, we now need to package it and send it to the API so we can get the weather data.
            
            let latitude = String(userLoc.coordinate.latitude)
            let longitude = String(userLoc.coordinate.longitude)
            // The above constants are cast as Strings (originially integers) so that they can be sent to OpenWeatherMaps as inputs
            
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData (url : WEATHER_URL, parameters : params)
        }
    }
    
    
    //Write the didFailWithError method here:
    // MA - the Below function is necessary to deal with what happens when locationManager.startUpdatingLocation generates an error
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location unavailable"
    }
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


