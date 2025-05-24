//
//  BaseCityViewController.swift
//  CitiesPractice
//
//  Created by Telman Yusifov on 23.05.25.
//

import UIKit
import SnapKit

protocol CityDelegate {
    func didTapCity(city: CityModel)
}

class BaseCityViewController: UIViewController {
    
    private let viewModel: CitiesViewModel
    
    private var delegate: CityDelegate?
    
    let city: CityModel
    
    init(city: CityModel, viewModel: CitiesViewModel) {
        self.city = city
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 16
        view.contentMode = .scaleToFill
        view.image = city.image
        view.clipsToBounds = true
        return view
    }()
    
    private let textStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 16
        view.alignment = .center
        view.distribution = .fillProportionally
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        label.text = city.name
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        label.text = city.description
        return label
    }()
    
    private var buttonsStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fillEqually
        return view
    }()
    
    private lazy var showOnMapButton: UIButton = {
        let button = UIButton()
        button.setTitle("Show on Map", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(didTapShowOnMapButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var chooseCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("Choose city", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(didTapChooseCityButton), for: .touchUpInside)
        return button
    }()
    
    private let alert = UIAlertController(title: "Choose city", message: nil, preferredStyle: .actionSheet)
    
    func subscribe(_ delegate: CityDelegate) {
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
        
        
        viewModel.fetchData().forEach { city in
            let action = UIAlertAction(title: city.name, style: .default) { alertAction in
                self.delegate?.didTapCity(city: city)
            }
            alert.addAction(action)
        }
        alert.addAction(.init(title: "Close", style: .destructive))
    }
    
    private func setupUI() {
        view.addSubview(imageView)
        view.addSubview(textStackView)
        view.addSubview(buttonsStackView)
        [titleLabel, descriptionLabel].forEach(textStackView.addArrangedSubview)
        [showOnMapButton, chooseCityButton].forEach(buttonsStackView.addArrangedSubview)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.horizontalEdges.equalToSuperview().inset(24)
            make.height.equalTo(200)
        }
        
        textStackView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(textStackView.snp.bottom).offset(12)
            make.horizontalEdges.equalToSuperview().inset(24)
        }
        
        showOnMapButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    @objc
    private func didTapShowOnMapButton() {
        viewModel.showOnMap(inputData: .init(name: city.name, coordinates: city.mapLocation))
    }
    
    @objc
    private func didTapChooseCityButton() {
        self.present(alert, animated: true)
    }
}
