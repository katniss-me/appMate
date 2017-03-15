//
//  MapViewController.swift
//  AppMate
//
//  Created by HanYoungsoo on 2017. 3. 14..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import FacebookCore

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    @IBOutlet weak var googleMap: GMSMapView!
    var pincount : Int = 0
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    let initialLocation : ProfileView = ProfileView(imgString : "bogum.jpg", primary_ID:1111, isFlag: false)
    let preferedLocation : ProfileView = ProfileView(imgString : "flag", primary_ID:1111, isFlag: true)
    var initialMarker : GMSMarker!
    
    var facebookUserInfos:Dictionary<String,Any>?
    override func viewDidLoad() {
        super.viewDidLoad()
        facebookUserInfos = DataCenter.sharedInstance.logInUserInfo
        setExp()
        locationManager.delegate = self
        googleMap.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        print("위치변경!")
        if initialMarker != nil {
            initialMarker.map = nil
        }
        
        let myReLocation : CLLocation = CLLocation(latitude: (locations.last?.coordinate.latitude)!+0.01, longitude: (locations.last?.coordinate.longitude)!+0.02)
        
        let camera = GMSCameraPosition.camera(withLatitude: myReLocation.coordinate.latitude,
                                              longitude:myReLocation.coordinate.longitude, zoom:11)
        googleMap.camera = camera
        
        initialMarker = GMSMarker(position: myReLocation.coordinate)
        initialMarker.iconView = ProfileView(imgString: "bogum.jpg", primary_ID: 1111, isFlag: false)
        initialMarker.appearAnimation = kGMSMarkerAnimationPop
        initialMarker.snippet = "ME"
        initialMarker.map = googleMap
        locationManager.stopUpdatingLocation()
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        switch status {
        case CLAuthorizationStatus.authorizedWhenInUse:
            //            googleMap.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
        default:
            print("22211");
        }
    }
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool{
        if marker.snippet == "ME" {
            print( initialLocation.getUserInfo()!)
        }
        else if marker.snippet == "prefered"{
            print(preferedLocation.getUserInfo()!)
            marker.map = nil
            pincount -= 1
            
        }        
        return true
        
    }
    
    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D){
        
        if(pincount < 3){
            let  position = coordinate
            print([position.latitude],[position.longitude])
            let marker = GMSMarker(position: position)
            marker.iconView = ProfileView(imgString: "flag", primary_ID: 1111, isFlag: true)
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.snippet = "prefered"
            marker.map = googleMap
        }
        else{
            print("3개 다 찍었어!")
        }
        
        pincount += 1
        
        
    }
    func setExp(){
        var workExp = Array<Any>()
        workExp = facebookUserInfos!["work"] as! Array
        for index in 0...workExp.count-1 {
            
            if (workExp[index] as! NSDictionary).value(forKey:"employer") != nil
            {
                print((((workExp[index] as! NSDictionary).value(forKey:"employer")) as! NSDictionary).value(forKey: "name")!)
            }
            else
            {
                print("직장없음")
            }
            if (workExp[index] as! NSDictionary).value(forKey:"position") != nil
            {
                print((((workExp[index] as! NSDictionary).value(forKey:"position")) as! NSDictionary).value(forKey: "name")!)
            }
            if (workExp[index] as! NSDictionary).value(forKey:"start_date") != nil
            {
                print((workExp[index] as! NSDictionary).value(forKey:"start_date")!)
            }
            else{
                print("0000~")
            }
            
            if (workExp[index] as! NSDictionary).value(forKey:"end_date") != nil
            {
                print((workExp[index] as! NSDictionary).value(forKey:"end_date")!)
            }
            else{
                print("현재")
            }
        }
        
        
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
