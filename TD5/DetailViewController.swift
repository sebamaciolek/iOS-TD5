//
//  DetailViewController.swift
//  TD5
//
//  Created by MACIOLEK Sebastian on 20/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import SDWebImage

class DetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var outletDetailMapView: MKMapView!
    @IBOutlet weak var outletImage: UIImageView!
    
    var locationManager = CLLocationManager()
    var myRoute : MKRoute!
    var currentLocation = CLLocationCoordinate2D()
    
    var titre = String()
    var phone = String()
    var image = String()
    var coordinate = CLLocationCoordinate2D()
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outletImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "wait"))
        self.navigationItem.title = titre
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        outletDetailMapView.showsUserLocation = true
        
        let depart = MKPointAnnotation()
        let destination = MKPointAnnotation()
        
        //Position de l'utilisateur
        depart.coordinate = (locationManager.location?.coordinate)!
        depart.title = "Ma position"
        outletDetailMapView.addAnnotation(depart)
        
        destination.coordinate = coordinate
        destination.title = titre
        outletDetailMapView.addAnnotation(destination)
        outletDetailMapView.centerCoordinate = destination.coordinate
        outletDetailMapView.delegate = self
        
        //Span of the map
        outletDetailMapView.setRegion(MKCoordinateRegionMake(destination.coordinate, MKCoordinateSpanMake(0.7,0.7)), animated: true)
        
        let directionsRequest = MKDirectionsRequest()
        let markTaipei = MKPlacemark(coordinate: CLLocationCoordinate2DMake(depart.coordinate.latitude, depart.coordinate.longitude), addressDictionary: nil)
        let markChungli = MKPlacemark(coordinate: CLLocationCoordinate2DMake(destination.coordinate.latitude, destination.coordinate.longitude), addressDictionary: nil)
        
        directionsRequest.source = MKMapItem(placemark: markChungli)
        directionsRequest.destination = MKMapItem(placemark: markTaipei)
        
        directionsRequest.transportType = MKDirectionsTransportType.automobile
        let directions = MKDirections(request: directionsRequest)
        
        directions.calculate(completionHandler: {
            response, error in
            
            if error == nil {
                self.myRoute = response!.routes[0] as MKRoute
                self.outletDetailMapView.add(self.myRoute.polyline)
            }
            
        })
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
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let myLineRenderer = MKPolylineRenderer(polyline: myRoute.polyline)
        myLineRenderer.strokeColor = UIColor.red
        myLineRenderer.lineWidth = 3
        return myLineRenderer
    }
    
    @IBAction func actionShare(_ sender: UIButton) {
        let linkShare = NSURL(string: url)
        var imageShare = UIImage()
        
        if let urlImage = URL(string: image){
            let data = try? Data(contentsOf: urlImage) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            imageShare = UIImage(data: data!)!
        }
        else{
            print("error not an URL")
        }
        
        let activityView = UIActivityViewController(activityItems: [titre, linkShare, imageShare], applicationActivities: nil)
        self.present(activityView, animated: true, completion: nil)
    }
    
    @IBAction func outletOpenMaps(_ sender: UIButton) {
        
        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate, regionDistance, regionDistance)
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = titre
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    @IBAction func actionCall(_ sender: UIButton) {
        let formatedNumber = phone.components(separatedBy: NSCharacterSet.decimalDigits.inverted).joined(separator: "")
        print("calling \(formatedNumber)")
        let phoneUrl = "tel://\(formatedNumber)"
        let url:URL = URL(string: phoneUrl)!
        UIApplication.shared.openURL(url)
    }
}
