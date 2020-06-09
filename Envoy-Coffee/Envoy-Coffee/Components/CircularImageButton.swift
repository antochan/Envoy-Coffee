//
//  CircularImageButton.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/8.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class CircularImageButton: UIView, Component {
    enum Constants {
        static let intrinsicDimension: CGFloat = 40
    }
    
    struct ViewModel {
        var image: UIImage
        let backgroundColor: UIColor = .white
    }
    
    public var actions: Actions?
    
    let circleView: RoundedShadowView = {
        let view = RoundedShadowView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var imageHeightConstraint: NSLayoutConstraint?
    var imageWidthConstraint: NSLayoutConstraint?
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: Constants.intrinsicDimension, height: Constants.intrinsicDimension)
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
        circleView.backgroundColor = viewModel.backgroundColor
        imageView.image = viewModel.image
    }
    
}

//MARK: - Private
private extension CircularImageButton {
    func commonInit() {
        configureSubviews()
        configureLayout()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        addGestureRecognizer(tap)
    }
    
    func configureSubviews() {
        addSubviews(circleView)
        circleView.addSubviews(imageView)
    }
    
    func configureLayout() {
        imageHeightConstraint?.isActive = true
        imageWidthConstraint?.isActive = true
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            circleView.widthAnchor.constraint(equalToConstant: Constants.intrinsicDimension),
            circleView.heightAnchor.constraint(equalToConstant: Constants.intrinsicDimension),
            
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        actions?(.buttonAction)
    }
}

//MARK: - Actionable
extension CircularImageButton: Actionable {
    public typealias Actions = (Action) -> Void
    
    public enum Action {
        case buttonAction
    }
}


