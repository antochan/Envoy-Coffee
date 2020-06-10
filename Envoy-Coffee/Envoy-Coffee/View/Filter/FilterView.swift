//
//  FilterView.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/9.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

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
        label.text = "Apply your filters here and explore more coffee shops :)"
        label.numberOfLines = 0
        return label
    }()
    
    let filterStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Spacing.twelve
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
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
        mainContentScrollView.addSubviews(filterTitleStack, filterStack)
        filterStack.addArrangedSubviews([filterTitleLabel, filterSubtitleLabel])
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            mainContentScrollView.topAnchor.constraint(equalTo: topAnchor),
            mainContentScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainContentScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainContentScrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            mainContentScrollView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
            
            cancelButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.thirtyTwo),
            cancelButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            filterTitleStack.topAnchor.constraint(equalTo: cancelButton.bottomAnchor, constant: Spacing.sixteen),
            filterTitleStack.centerXAnchor.constraint(equalTo: mainContentScrollView.centerXAnchor),
            filterTitleStack.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.9),
            
            filterStack.topAnchor.constraint(equalTo: filterTitleStack.bottomAnchor, constant: Spacing.thirtyTwo),
            filterStack.widthAnchor.constraint(equalTo: mainContentScrollView.widthAnchor, multiplier: 0.8),
            filterStack.centerXAnchor.constraint(equalTo: mainContentScrollView.centerXAnchor),
        ])
    }
}
