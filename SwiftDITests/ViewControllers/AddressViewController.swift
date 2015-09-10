//
//  AddressViewController.swift
//  SwiftDITests
//
//  Created by Olivier Halligon on 10/09/2015.
//  Copyright © 2015 AliSoftware. All rights reserved.
//

import UIKit

import CoreLocation
import AddressBook
import MapKit

class MapPOI : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

class AddressViewController : UIViewController, MKMapViewDelegate {
    // MARK: Outlets
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    // MARK: - Properties
    var viewModel: AddressViewModel! {
        didSet {
            update()
        }
    }
    let geocoder = CLGeocoder()
    
    // MARK: - Initialization
    
    static func instance(viewModel vm: AddressViewModel) -> AddressViewController {
        let vc = UIStoryboard.Scene.Main.mapViewController()
        vc.viewModel = vm
        return vc
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        update()
    }

    func update() {
        guard isViewLoaded() else { return }
        cityLabel.text = viewModel.city
        countryLabel.text = viewModel.country
        
        let addrDict: [NSObject: AnyObject] = [
            kABPersonAddressCityKey: viewModel.city,
            kABPersonAddressCountryKey: viewModel.country
        ]
        geocoder.geocodeAddressDictionary(addrDict) { [weak self] (placemarks, error) -> Void in
            guard let pms = placemarks,
                pm = pms.first,
                loc = pm.location
                else { return }
            let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
            let region = MKCoordinateRegion(center: loc.coordinate, span: span)
            self?.mapView.setRegion(region, animated: true)
            self?.mapView.addAnnotation(MapPOI(coordinate: loc.coordinate))
        }
    }
}
