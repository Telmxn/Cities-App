//
//  AppCoordinator.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CitiesBuilder(coordinator: self).build()
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func navigateToMap(inputData: CityOnMapInputData) {
        let vc = CityOnMapBuilder(inputData: inputData).build()
        navigationController.pushViewController(vc, animated: true)
    }
}
