//
//  VenueTableComponent.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class VenueTableComponent: UIView, Component, Reusable {
    struct ViewModel {
        let venueData: Venue
        let venueImageURL: String
    }
    
    private let cardView: RoundedShadowView = {
        let view = RoundedShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        return view
    }()
    
    private let venueImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "placeholder")
        return imageView
    }()
    
    private let venueInfoStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = Spacing.four
        return stackView
    }()
    
    private let venueNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.mainBold(size: 16)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let venueLocationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.main(size: 13)
        label.numberOfLines = 0
        return label
    }()
    
    private let venuePriceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.main(size: 12)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    private let venueDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.main(size: 12)
        label.numberOfLines = 1
        label.textColor = .lightGray
        return label
    }()
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width - Spacing.thirtyTwo, height: 190)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func apply(viewModel: ViewModel) {
        venueNameLabel.text = viewModel.venueData.name
        venueLocationLabel.text = viewModel.venueData.location?.formattedAddress?.first ?? "Location is unknown"
        if let currencyMessage = viewModel.venueData.price?.currency {
            venuePriceLabel.text = currencyMessage
        } else {
            venuePriceLabel.text = "No price range"
        }
        venueDistanceLabel.text = "\(viewModel.venueData.location?.distance ?? 0)m away"
    }
    
    func prepareForReuse() {
        // no-op
    }
}

private extension VenueTableComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(venueImageView, venueInfoStack)
        venueInfoStack.addArrangedSubviews([venueNameLabel, venueLocationLabel, venuePriceLabel, venueDistanceLabel])
    }
    
    func configureLayout() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: Spacing.sixteen),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Spacing.sixteen),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Spacing.sixteen),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Spacing.sixteen),
            
            venueImageView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: Spacing.eight),
            venueImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: Spacing.eight),
            venueImageView.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.375),
            venueImageView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -Spacing.eight),
            
            venueInfoStack.leadingAnchor.constraint(equalTo: venueImageView.trailingAnchor, constant: Spacing.sixteen),
            venueInfoStack.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -Spacing.sixteen),
            venueInfoStack.centerYAnchor.constraint(equalTo: cardView.centerYAnchor)
        ])
    }
}
