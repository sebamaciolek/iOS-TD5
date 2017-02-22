//
//  ViewController.swift
//  TD5
//
//  Created by MACIOLEK Sebastian on 20/02/2017.
//  Copyright © 2017 MACIOLEK Sebastian. All rights reserved.
//

import UIKit
import SWXMLHash

class ViewController: UIViewController, XMLParserDelegate {
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var parser = XMLParser()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        do{
            let url = URL(string: "http://dam.lanoosphere.com/poi.xml")
            let data = try Data(contentsOf: url!)
            let xml = SWXMLHash.parse(String(data: data, encoding: .utf8)!)
            // Do any additional setup after loading the view, typically from a nib.
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.activityIndicator.startAnimating()
            
            // Parsing the XML
            //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0).asynchronously(execute: {
            
            DispatchQueue.global().async {
                // qos' default value is ´DispatchQoS.QoSClass.default`
                for d in xml["Data"]["POI"] {
                    let poi = POI(id: Int((d.element?.attributes["id"])!)!,
                                  name:((d.element?.attributes["name"])!)!,
                                  image: (d.element?.attributes["image"])!,
                                  latitude: Double((d.element?.attributes["latitude"])!)!,
                                  longitude: Double((d.element?.attributes["longitude"])!)!,
                                  phone: (d.element?.attributes["phone"])!,
                                  mail: (d.element?.attributes["mail"])!,
                                  url: (d.element?.attributes["url"])!,
                                  description: (d.element?.attributes["description"])!)
                    print(poi)
                    // poiTabl.append(poi)
                }
                
                self.activityIndicator.stopAnimating()
                
            }
            
            // Wait during parsing
            sleep(4)
        }
        catch {
            print("error retrieving file")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}
