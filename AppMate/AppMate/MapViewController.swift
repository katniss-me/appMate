//
//  MapViewController.swift
//  AppMate
//
//  Created by HanYoungsoo on 2017. 3. 14..
//  Copyright © 2017년 YoungsooHan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController, CLLocationManagerDelegate,GMSMapViewDelegate, UISearchBarDelegate,LocateOnTheMap,GMSAutocompleteFetcherDelegate {
    @IBOutlet weak var googleMap: GMSMapView!
    
    
    let imgData:Data = UIImagePNGRepresentation(UIImage(named:"flag")!)!
    var preferedLocation : CustomPinImage?
    var pincount : Int = 0
    var locationManager = CLLocationManager()
    var didFindMyLocation = false
    let initialLocation : ProfileView = ProfileView(imgString: "bogum.jpg", user_id: "heyman333")
    var initialMarker : GMSMarker!
    
    /* 주소검색 변수 */
    var searchResultController: SearchResultsController!
    var resultsArray = [String]()
    var gmsFetcher: GMSAutocompleteFetcher!


    override func viewDidLoad() {
        super.viewDidLoad()
        preferedLocation = CustomPinImage(data: imgData, id: "heyman333")
        locationManager.delegate = self
        googleMap.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchResultController = SearchResultsController()
        searchResultController.delegate = self
        gmsFetcher = GMSAutocompleteFetcher()
        gmsFetcher.delegate = self
        
    }
    
    
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        print("위치변경!")
        if initialMarker != nil {
            initialMarker.map = nil
        }
        
        //랜덤 위치 재설정
        let myReLocation : CLLocation = CLLocation(latitude: (locations.last?.coordinate.latitude)!+0.01, longitude: (locations.last?.coordinate.longitude)!+0.02)
        
        let camera = GMSCameraPosition.camera(withLatitude: myReLocation.coordinate.latitude,
                                              longitude:myReLocation.coordinate.longitude, zoom:11)
        googleMap.camera = camera
        
        initialMarker = GMSMarker(position: myReLocation.coordinate)
        initialMarker.iconView = initialLocation
        initialMarker.appearAnimation = kGMSMarkerAnimationPop
        initialMarker.snippet = "ME"
        initialMarker.map = googleMap
        locationManager.stopUpdatingLocation()
        
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        switch status {
        case CLAuthorizationStatus.authorizedWhenInUse:
            googleMap.isMyLocationEnabled = true
            locationManager.startUpdatingLocation()
        default:
            print("사용자가 동의하지 않았을때 처리")
        }
    }
    
    public func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool{
        if marker.snippet == "ME" {
            print(initialLocation.user_id)
        }
        else if marker.title == "Address"{
            print((preferedLocation?.user_id)!)
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
            marker.icon = preferedLocation
            marker.appearAnimation = kGMSMarkerAnimationPop
            marker.snippet = "prefered"
            marker.map = googleMap
        }
        else{
            print("3개 모두 찍었습니다.")
        }
        
        pincount += 1
        
    }

    /* 주소 검색 */
    @IBAction func searchWithAddress(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: searchResultController)
        
        searchController.searchBar.delegate = self
        
        
        
        self.present(searchController, animated:true, completion: nil)
        
    }
    
    /**
     * Called when an autocomplete request returns an error.
     * @param error the error that was received.
     */
    public func didFailAutocompleteWithError(_ error: Error) {
        //        resultText?.text = error.localizedDescription
    }
    
    /**
     * Called when autocomplete predictions are available.
     * @param predictions an array of GMSAutocompletePrediction objects.
     */
    public func didAutocomplete(with predictions: [GMSAutocompletePrediction]) {
        //self.resultsArray.count + 1
        
        for prediction in predictions {
            
            if let prediction = prediction as GMSAutocompletePrediction!{
                self.resultsArray.append(prediction.attributedFullText.string)
            }
        }
        self.searchResultController.reloadDataWithArray(self.resultsArray)
        //   self.searchResultsTable.reloadDataWithArray(self.resultsArray)
        print(resultsArray)
    }
    
    /**
     Locate map with longitude and longitude after search location on UISearchBar
     
     - parameter lon:   longitude location
     - parameter lat:   latitude location
     - parameter title: title of address location
     */
    func locateWithLongitude(_ lon: Double, andLatitude lat: Double, andTitle title: String) {
        
        DispatchQueue.main.async { () -> Void in
            
            let imgData:Data = UIImagePNGRepresentation(UIImage(named:"flag")!)!
            
            let position = CLLocationCoordinate2DMake(lat, lon)
            let marker = GMSMarker(position: position)
            let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lon, zoom: 10)
            self.googleMap.camera = camera
            marker.icon = CustomPinImage(data: imgData, id: "heyman333")
            marker.title = "Address"
            marker.snippet = "\(title)"
            marker.map = self.googleMap
            self.googleMap.selectedMarker = marker
            
        }
        
    }
    
    /**
     Searchbar when text change
     
     - parameter searchBar:  searchbar UI
     - parameter searchText: searchtext description
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //        let placeClient = GMSPlacesClient()
        //
        //
        //        placeClient.autocompleteQuery(searchText, bounds: nil, filter: nil)  {(results, error: Error?) -> Void in
        //           // NSError myerr = Error;
        //            print("Error @%",Error.self)
        //
        //            self.resultsArray.removeAll()
        //            if results == nil {
        //                return
        //            }
        //
        //            for result in results! {
        //                if let result = result as? GMSAutocompletePrediction {
        //                    self.resultsArray.append(result.attributedFullText.string)
        //                }
        //            }
        //
        //            self.searchResultController.reloadDataWithArray(self.resultsArray)
        //
        //        }
        
        
        self.resultsArray.removeAll()
        gmsFetcher?.sourceTextHasChanged(searchText)
        
        
    }

    
}
