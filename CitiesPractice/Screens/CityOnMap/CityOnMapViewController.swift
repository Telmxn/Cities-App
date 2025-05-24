//
//  CityOnMapViewController.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import UIKit
import MapKit

class CityOnMapViewController: UIViewController {
    
    private let viewModel: CityOnMapViewModel
    
    private let mapView: MKMapView = {
        let view = MKMapView()
        
        return view
    }()
    
    init(viewModel: CityOnMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        let data = viewModel.fetchData()
        
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: data.coordinates, span: span)
        mapView.setRegion(region, animated: true)
        
        let pin = MKPointAnnotation()
        pin.coordinate = data.coordinates
        pin.title = data.name
        mapView.addAnnotation(pin)
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
