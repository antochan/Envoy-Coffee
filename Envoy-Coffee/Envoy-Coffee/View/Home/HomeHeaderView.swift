//
//  HomeHeaderView.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeHeaderView: UIView {
    private enum Constants {
        static let title = "Envoy Coffee"
        static let filterImage = #imageLiteral(resourceName: "levels")
    }
    
    private let homeTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.mainBold(size: 30)
        label.text = Constants.title
        return label
    }()
    
    private let homeSubtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.main(size: 15)
        label.textColor = .darkGray
        return label
    }()
    
    let sortButton: CircularImageButton = {
        let sortButton = CircularImageButton()
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        sortButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        let imageButtonVM = CircularImageButton.ViewModel(image: Constants.filterImage)
        sortButton.apply(viewModel: imageButtonVM)
        return sortButton
    }()
    
    private let searchQueryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.main(size: 12)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func applyHeader(locationName: String, totalResults: Int, loadedResults: Int) {
        homeSubtitleLabel.text = locationName
        let loadedResultsValue = loadedResults > totalResults ? totalResults : loadedResults
        searchQueryLabel.text = "Showing \(loadedResultsValue) out of \(totalResults) Coffee shops"
    }
}

private extension HomeHeaderView {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubviews(homeTitleLabel, homeSubtitleLabel, searchQueryLabel, sortButton)
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            homeTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Spacing.sixteen),
            homeTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            homeSubtitleLabel.topAnchor.constraint(equalTo: homeTitleLabel.bottomAnchor, constant: Spacing.four),
            homeSubtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            
            sortButton.centerYAnchor.constraint(equalTo: homeTitleLabel.centerYAnchor),
            sortButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            
            searchQueryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.eight),
            searchQueryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen)
        ])
    }
}
