//
//  VenueTableComponent.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit
import Kingfisher
import Cosmos

class VenueTableComponent: UIView, Component, Reusable {
    struct ViewModel {
        let venueData: Venue
        let venueImageURL: String?
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
    
    private let starView: CosmosView = {
        let starView = CosmosView()
        starView.translatesAutoresizingMaskIntoConstraints = false
        starView.settings.fillMode = .full
        starView.settings.updateOnTouch = false
        starView.settings.starMargin = 2
        starView.settings.filledColor = .black
        starView.settings.emptyBorderColor = .darkGray
        starView.settings.filledBorderColor = .black
        starView.settings.starSize = 12
        starView.settings.textFont = UIFont.main(size: 12)
        starView.rating = 0
        return starView
    }()

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
        
        if let venueImageURL = viewModel.venueImageURL {
            guard venueImageURL != "" else { return }
            if let imageURL = URL(string: venueImageURL) {
                venueImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeholder"), options: [.transition(.fade(0.2))])
            }
        }
        
        if let rating = viewModel.venueData.rating, let totalSignals = viewModel.venueData.ratingSignals {
            starView.rating = rating
            starView.text = "(\(totalSignals))"
        } else {
            starView.rating = 0
            starView.text = "(No Reviews)"
        }
    }
    
    func prepareForReuse() {
        venueImageView.image = #imageLiteral(resourceName: "placeholder")
    }
}

private extension VenueTableComponent {
    func commonInit() {
        configureSubviews()
        configureLayout()
    }
    
    func configureSubviews() {
        addSubview(cardView)
        cardView.addSubviews(venueImageView, venueInfoStack, starView)
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
            venueInfoStack.topAnchor.constraint(equalTo: venueImageView.topAnchor, constant: Spacing.sixteen),
            
            starView.leadingAnchor.constraint(equalTo: venueImageView.trailingAnchor, constant: Spacing.sixteen),
            starView.bottomAnchor.constraint(equalTo: venueImageView.bottomAnchor, constant: -Spacing.sixteen)
        ])
    }
}
