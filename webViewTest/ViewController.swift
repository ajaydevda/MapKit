//
//  ViewController.swift
//  webViewTest
//
//  Created by C711091 on 26/12/19.
//  Copyright © 2019 icici. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController{

    @IBOutlet weak var lat_Label: UILabel!
   
    @IBOutlet weak var log_label: UILabel!
    
    @IBOutlet weak var mapview: MKMapView!
    
    
    // set initial location in Honolulu
    let regionRadius: CLLocationDistance = 1000

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // set initial location in Honolulu
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)

        mapview.delegate = self
        centerMapOnLocation(location: initialLocation)
        
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapview.setRegion(coordinateRegion, animated: true)
        
        
        let artwork = Artwork(title: "King David Kalakaua",
                              locationName: "Waikiki Gateway Park",
                              discipline: "Sculpture",
                              coordinate: location.coordinate)
        mapview.addAnnotation(artwork)
        
        
    }


}
extension ViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
