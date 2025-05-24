//
//  CitiesViewController.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import UIKit

class CitiesViewController: UIViewController {
    
    private let viewModel: CitiesViewModel
    
    private var citiesVC: [BaseCityViewController] = []
    
    private var currentVCIndex = 0
    
    private lazy var pageViewController: UIPageViewController = {
        let viewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        viewController.setViewControllers([citiesVC[0]], direction: .forward, animated: true)
        viewController.dataSource = self
        viewController.delegate = self
        return viewController
    }()
    
    init(viewModel: CitiesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        viewModel.fetchData().forEach { city in
            let vc = BaseCityViewController(city: city, viewModel: viewModel)
            vc.subscribe(self)
            citiesVC.append(vc)
        }
        
        setupUI()
    }
    
    private func setupUI() {
        view.addSubview(pageViewController.view)
        addChild(pageViewController)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension CitiesViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if currentVCIndex != 0 {
            return citiesVC[currentVCIndex - 1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if currentVCIndex < citiesVC.count - 1 {
            return citiesVC[currentVCIndex + 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed,
              let viewController = (pageViewController.viewControllers?.first as? BaseCityViewController) else {
            return
        }
        if let index = citiesVC.firstIndex(of: viewController) {
            currentVCIndex = index
        }
    }
}

extension CitiesViewController: CityDelegate {
    func didTapCity(city: CityModel) {
        let index = citiesVC.firstIndex { cityVC in
            cityVC.city.name == city.name
        } ?? 0
        pageViewController.setViewControllers([citiesVC[index]], direction: index > currentVCIndex ? .forward : .reverse, animated: true)
        currentVCIndex = index
    }
}
