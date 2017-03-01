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
    
    let locationManager = CLLocationManager()
    
    var titre = String()
    var phone = String()
    var image = String()
    var coordinate = CLLocationCoordinate2D()
    var url = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        outletImage.sd_setImage(with: URL(string: image), placeholderImage: UIImage(named: "wait"))
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
    
    @IBAction func actionShare(_ sender: UIButton) {
        let link = NSURL(string: url)
        let activityView = UIActivityViewController(activityItems: [titre, link], applicationActivities: nil)
        self.present(activityView, animated: true, completion: nil)
    }
    
    @IBAction func outletOpenMaps(_ sender: UIButton) {
        
        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinate, regionDistance, regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = titre
        mapItem.openInMaps(launchOptions: options)
    }
}
