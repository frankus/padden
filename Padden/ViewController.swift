//
//  ViewController.swift
//  Padden
//
//  Created by Frank Schmitt on 2015-05-12.
//  Copyright (c) 2015 Frank Schmitt. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var alphaSlider: UISlider!
	@IBOutlet weak var trackingModeControl: UISegmentedControl!
    var overlay: ImageOverlay!
    var overlayRenderer: OverlayRenderer!
    var locationManager: CLLocationManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.overlay = ImageOverlay(coordinate: CLLocationCoordinate2D(latitude: 48.6985, longitude: -122.4469), scale: 11.85, rotation: 0, image: UIImage(named: "Padden")!)
        self.overlayRenderer = OverlayRenderer(overlay: self.overlay)
        self.overlayRenderer.alpha = CGFloat(self.alphaSlider.value)
        
        self.mapView.addOverlay(self.overlay)
        self.mapView.region = MKCoordinateRegion(center: self.overlay.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        
        self.locationManager = CLLocationManager()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        self.locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            self.mapView.showsUserLocation = true
        }
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        return self.overlayRenderer
    }
    
    @IBAction func setAlpha(sender: UISlider) {
        self.overlayRenderer.alpha = CGFloat(sender.value)
    }
	
	@IBAction func changeTrackingMode(sender: UISegmentedControl) {
		let modes: [MKUserTrackingMode] = [ .None, .Follow, .FollowWithHeading ]
		
		self.mapView.setUserTrackingMode(modes[sender.selectedSegmentIndex], animated: true)
	}
}

