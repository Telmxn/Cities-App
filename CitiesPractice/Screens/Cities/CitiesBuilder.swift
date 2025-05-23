//
//  CitiesBuilder.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import UIKit

class CitiesBuilder {
    
    private let coordinator: AppCoordinator
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func build() -> UIViewController {
        let viewModel = CitiesViewModel(coordinator: coordinator)
        let vc = CitiesViewController(viewModel: viewModel)
        return vc
    }
}
