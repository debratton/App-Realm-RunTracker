//
//  BeginRunVC.swift
//  RunTracker
//
//  Created by David E Bratton on 6/6/19.
//  Copyright © 2019 David Bratton. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class BeginRunVC: LocationVC {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var lastRunCloseBtn: UIButton!
    @IBOutlet weak var lastRunView: UIView!
    @IBOutlet weak var lastRunStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthStatus()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        manager?.delegate = self
        mapView.delegate = self
        manager?.startUpdatingLocation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setupMapView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        manager?.stopUpdatingLocation()
    }
    
    func setupMapView() {
        if let overlay = addLastRunToMap() {
            if mapView.overlays.count > 0 {
                mapView.removeOverlays(mapView.overlays)
            }
            mapView.addOverlay(overlay)
            lastRunView.isHidden = false
            lastRunStackView.isHidden = false
            lastRunCloseBtn.isHidden = false
        } else {
            lastRunView.isHidden = true
            lastRunStackView.isHidden = true
            lastRunCloseBtn.isHidden = true
            centerMapOnUserLocation()
        }
    }
    
    func addLastRunToMap() -> MKPolyline? {
        guard let lastRun = Helper.loadRun()?.first else { return nil }
        paceLabel.text = lastRun.pace.formatTimeDurationToString()
        distanceLabel.text = "\(lastRun.distance.metersToMiles(places: 2)) mi"
        durationLabel.text = lastRun.duration.formatTimeDurationToString()
        
        var coordinate = [CLLocationCoordinate2D]()
        for location in lastRun.locations {
            print("Location: \(location)")
//            coordinate.append(CLLocationCoordinate2D(latitude: location.longitude, longitude: location.longitude))
            coordinate.append(CLLocationCoordinate2D(latitude: 37.33062991336227, longitude: -122.02977097437191))
            print("Last Run Latitude: \(location.latitude)")
            print("Last RUn Longitude: \(location.longitude)")
        }
        
        print(lastRun.locations.count)
        mapView.userTrackingMode = .none
        mapView.setRegion(centerMapOnPrevRoute(locations: lastRun.locations), animated: true)
        return MKPolyline(coordinates: coordinate, count: lastRun.locations.count)
    }
    
    func centerMapOnUserLocation() {
        mapView.userTrackingMode = .follow
        let coordinateRegion = MKCoordinateRegion(center: mapView.userLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordinateRegion, animated: true)
        let lat = coordinateRegion.center.latitude
        let lon = coordinateRegion.center.longitude
        print("Latitude: \(lat), Longitude: \(lon)")
    }
    
    func centerMapOnPrevRoute(locations: List<Location>) -> MKCoordinateRegion {
        guard let initialLoc = locations.first else { return MKCoordinateRegion() }
        var minLat = initialLoc.latitude
        var minLng = initialLoc.longitude
        var maxLat = minLat
        var maxLng = minLng
        
        for location in locations {
            minLat = min(minLat, location.latitude)
            minLng = min(minLng, location.longitude)
            maxLat = max(maxLat, location.latitude)
            maxLng = max(maxLng, location.longitude)
        }
        return MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: (minLat + maxLat) / 2, longitude: (minLng + maxLng) / 2), span: MKCoordinateSpan(latitudeDelta: (maxLat - minLat) * 1.4, longitudeDelta: (maxLng - minLng) * 1.4))
    }
    
    @IBAction func lastRunCloseBtnPressed(_ sender: UIButton) {
        lastRunView.isHidden = true
        lastRunStackView.isHidden = true
        lastRunCloseBtn.isHidden = true
        centerMapOnUserLocation()
    }
    

    @IBAction func locatonCenterBtnPressed(_ sender: UIButton) {
        centerMapOnUserLocation()
    }
}

extension BeginRunVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkLocationAuthStatus()
            mapView.showsUserLocation = true
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        renderer.lineWidth = 4
        return renderer
    }
}
