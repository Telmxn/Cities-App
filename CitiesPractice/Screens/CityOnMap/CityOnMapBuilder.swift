//
//  CityOnMapBuilder.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import UIKit

class CityOnMapBuilder {
    private let inputData: CityOnMapInputData
    
    init(inputData: CityOnMapInputData) {
        self.inputData = inputData
    }
    
    func build() -> UIViewController {
        let viewModel = CityOnMapViewModel(inputData: inputData)
        let vc = CityOnMapViewController(viewModel: viewModel)
        return vc
    }
}
