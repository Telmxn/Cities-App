//
//  CitiesViewModel.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import Foundation

class CitiesViewModel {
    
    private let coordinator: AppCoordinator
    
    private let cities: [CityModel] = [
        .init(image: .baku, name: "Baku", description: "Baku, the capital and commercial hub of Azerbaijan, is a low-lying city with coastline along the Caspian Sea. It's famed for its medieval walled old city, which contains the Palace of the Shirvanshahs, a vast royal complex, and the iconic stone Maiden Tower. Contemporary landmarks include the Zaha Hadid–designed Heydar Aliyev Center, and the Flame Towers, 3 pointed skyscrapers covered with LED screens.", mapLocation: .init(latitude: 40.40876936013685, longitude: 49.86753826687692)),
        .init(image: .shaki, name: "Shaki", description: "Shaki is a city in northwestern Azerbaijan, surrounded by the district of the same name. It is located in the southern part of the Greater Caucasus mountain range, 240 km from Baku. As of 2020, it has a population of 68,400.", mapLocation: .init(latitude: 41.19715447044796, longitude: 47.15564995465063)),
        .init(image: .ganja, name: "Ganja", description: "Ganja is a city in western Azerbaijan. In its east, the Nizami Ganjavi Mausoleum honors the revered 12th-century local poet. Not far from the center, the ancient city of Ganja is an archaeological site with the ruins of a walled fort. The Imamzade complex features religious buildings with ornate blue tile work. Other notable landmarks include the Juma Mosque, with its large dome and ornamental fountains.", mapLocation: .init(latitude: 40.68907510086168, longitude: 46.37244764508776))
    ]
    
    init(coordinator: AppCoordinator) {
        self.coordinator = coordinator
    }
    
    func fetchData() -> [CityModel] {
        return cities
    }
    
    func showOnMap(inputData: CityOnMapInputData) {
        coordinator.navigateToMap(inputData: inputData)
    }
}
