//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation // MA - This is the Apple library that needs to be imported if you want to work with locations


class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    // the class 'WeatherViewController' needs to conform to 'CLLocationManagerDelegate' for this class to be able to handle Location related jobs.
    
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e72ca729af228beabd5d20e3b7749713"
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager() // creating an object of the class 'CLLocationManager'. This object has all the properties Apple has coded into the CLLocationManager Class.

    
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
        // This property ask the user for permission to use thier location.
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    
    
    
    //Write the didFailWithError method here:
    
    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
    
    
    
}


