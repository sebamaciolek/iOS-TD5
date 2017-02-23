//
//  MapViewController.swift
//  TD5
//
//  Created by MACIOLEK Sebastian on 20/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{

    @IBOutlet weak var outletMapView: MKMapView!{
        didSet{
            outletMapView.delegate = self
        }
    }

    
    var poiArray:[POI] = []
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for poi in poiArray{
            
            let location = CLLocationCoordinate2D(latitude: poi.latitude, longitude: poi.longitude)
            let pointAnnotation = MKPointAnnotation()
            pointAnnotation.coordinate = location
            pointAnnotation.title = poi.name
            
            let geoCoder = CLGeocoder()
            
            let newLocation = CLLocation(latitude: poi.latitude, longitude: poi.longitude)
            geoCoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemark, error) -> Void in
                
                if placemark!.count > 0 {
                    print(poi.latitude)
                    let thePlaceMark = placemark![0] as CLPlacemark
                    
                    
                    if let street = thePlaceMark.addressDictionary?["Street"]
                    {
                        pointAnnotation.subtitle = "\(street), \(thePlaceMark.locality!)"
                    }
                }
            })
        }
        
        // Centering the camera on Canne
        // Define fix location and span
        
        let spanLat:CLLocationDegrees = 0.05
        let spanLng:CLLocationDegrees = 0.05
        let latitude:CLLocationDegrees = 43.551534
        let longitude:CLLocationDegrees = 7.016659
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(spanLat, spanLng)
        let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region:MKCoordinateRegion = MKCoordinateRegionMake(location, span)

        outletMapView.setRegion(region, animated: true)

        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()

        
        outletMapView.showsUserLocation = true
        
        //let annotation = MKPointAnnotation()
        
        //annotation.coordinate = CLLocationCoordinate2D(latitude: 11.12, longitude: 12.11)
        //annotation.title = "nom"
        //annotation.subtitle = "adresse"
        
        //outletMapView.addAnnotation(annotation)
        
    }
        
    func outletMapView(outletMapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = outletMapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil{
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        annotationView?.leftCalloutAccessoryView = nil
        annotationView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.detailDisclosure)
        
        return annotationView
    }
    
    func outletMapView(outletMapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        if (control as? UIButton)?.buttonType == UIButtonType.detailDisclosure {
            outletMapView.deselectAnnotation(view.annotation, animated: false)
            performSegue(withIdentifier: "detailScene", sender: view)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
