//
//  FilterView.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

enum FilterTextfieldTags: Int {
    case clientID = 1
    case clientSecret = 2
}

class FilterView: UIView {
    let cancelButton: CircularImageButton = {
        let cancelButton = CircularImageButton()
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        let cancelVM = CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "cancel"))
        cancelButton.apply(viewModel: cancelVM)
        cancelButton.alpha = 0
        return cancelButton
    }()
    
    let mainContentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let filterTitleStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.eight
        return stackView
    }()
    
    private let filterTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.mainBold(size: 28)
        label.text = "Envoy Coffee Filters"
        label.numberOfLines = 1
        return label
    }()
    
    private let filterSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.mainBold(size: 14)
        label.textColor = .lightGray
        label.text = "Apply your filters here and explore more around the Envoy Office! :)"
        label.numberOfLines = 0
        return label
    }()
    
    private let filterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.sixty
        return stackView
    }()
    
    private let distanceMainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let distanceSliderTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.mainBold(size: 15)
        label.text = "Distance in meters"
        label.numberOfLines = 1
        return label
    }()
    
    let distanceSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 200
        slider.maximumValue = 1500
        slider.tintColor = .black
        return slider
    }()
    
    private let distanceSliderLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.main(size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let sectionMainStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let sectionCategoryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.mainBold(size: 15)
        label.text = "Filter categories by:"
        label.numberOfLines = 1
        return label
    }()
    
    private let sectionFilterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = Spacing.eight
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let coffeeSection: CircularImageButton = {
        let coffeeButton = CircularImageButton()
        coffeeButton.translatesAutoresizingMaskIntoConstraints = false
        let coffeeVM = CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "001-coffee"))
        coffeeButton.apply(viewModel: coffeeVM)
        return coffeeButton
    }()
    
    let foodSectionButton: CircularImageButton = {
        let foodButton = CircularImageButton()
        foodButton.translatesAutoresizingMaskIntoConstraints = false
        let foodVM = CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "002-cutlery"))
        foodButton.apply(viewModel: foodVM)
        return foodButton
    }()
    
    let shopsSectionButton: CircularImageButton = {
        let shopButton = CircularImageButton()
        shopButton.translatesAutoresizingMaskIntoConstraints = false
        let shopVM = CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "004-open"))
        shopButton.apply(viewModel: shopVM)
        return shopButton
    }()
    
    let artsSectionButton: CircularImageButton = {
        let artsButton = CircularImageButton()
        artsButton.translatesAutoresizingMaskIntoConstraints = false
        let artsVM = CircularImageButton.ViewModel(image: #imageLiteral(resourceName: "003-paint-palette"))
        artsButton.apply(viewModel: artsVM)
        return artsButton
    }()
    
    private let sectionFilterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.main(size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        return label
    }()
    
    private let debugKeyStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    private let debugTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.mainBold(size: 15)
        label.text = "Debug: Use your own Keys"
        label.numberOfLines = 0
        return label
    }()
    
    private let clientIdLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.main(size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.text = "Client Id:"
        return label
    }()
    
    let clientIdTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.main(size: 13)
        textField.tag = FilterTextfieldTags.clientID.rawValue
        return textField
    }()
    
    private let clientSecretLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.main(size: 12)
        label.textColor = .darkGray
        label.numberOfLines = 1
        label.text = "Client Secret:"
        return label
    }()
    
    let clientSecretTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.main(size: 13)
        textField.tag = FilterTextfieldTags.clientSecret.rawValue
        return textField
    }()
    
    private let buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    let resetToDefaultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset To Default", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.main(size: 13)
        return button
    }()
    
    let applyFilterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apply Filters", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.main(size: 13)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func applyFilterView(filterConfigs: FilterConfigurations) {
        distanceSlider.value = Float(filterConfigs.radius ?? 200)
        distanceSliderLabel.text = "\(filterConfigs.radius ?? 200) meters"
        sectionFilterLabel.text = "Selected Category: " + filterConfigs.sectionQuery
        
        clientIdTextField.text = filterConfigs.clientID
        clientSecretTextField.text = filterConfigs.clientSecret
    }
    
}

//MARK: Private
private extension FilterView {
    func commonInit() {
        backgroundColor = .white
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(mainContentScrollView, cancelButton)
        mainContentScrollView.addSubview(filterStack)
        
        filterStack.addArrangedSubviews([filterTitleStack, distanceMainStack, sectionMainStack, debugKeyStack, buttonStack])
        
        filterTitleStack.addArrangedSubviews([filterTitleLabel, filterSubtitleLabel])
        
        distanceMainStack.addArrangedSubviews([distanceSliderTitleLabel, distanceSlider, distanceSliderLabel])
        
        sectionMainStack.addArrangedSubviews([sectionCategoryTitleLabel, sectionFilterStack, sectionFilterLabel])
        sectionFilterStack.addArrangedSubviews([coffeeSection, foodSectionButton, shopsSectionButton, artsSectionButton])
        
        debugKeyStack.addArrangedSubviews([debugTitleLabel, clientIdLabel, clientIdTextField, clientSecretLabel, clientSecretTextField])
        
        buttonStack.addArrangedSubviews([resetToDefaultButton, applyFilterButton])
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            mainContentScrollView.topAnchor.constraint(equalTo: topAnchor),
            mainContentScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContentScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainContentScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            filterStack.topAnchor.constraint(equalTo: mainContentScrollView.topAnchor, constant: Spacing.sixty),
            filterStack.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.8),
            filterStack.centerXAnchor.constraint(equalTo: mainContentScrollView.centerXAnchor),
            filterStack.bottomAnchor.constraint(equalTo: mainContentScrollView.bottomAnchor, constant: -Spacing.thirtyTwo),
            
            resetToDefaultButton.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.8),
            resetToDefaultButton.heightAnchor.constraint(equalToConstant: 35),
            applyFilterButton.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.8),
            applyFilterButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}
