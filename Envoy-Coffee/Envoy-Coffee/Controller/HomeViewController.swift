//
//  HomeViewController.swift
//  Envoy-Coffee
//
//  Created by Antonio Chan on 2020/6/7.
//  Copyright © 2020 Antonio Chan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    let homeView = HomeView()
    private var webService: WebService
    
    private var viewModel = HomeViewModel.defaultViewModel {
        didSet {
            print(viewModel)
        }
    }
    
    init(webService: WebService) {
        self.webService = webService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getVenueList()
    }
    
}

//MARK: - WebService
extension HomeViewController {
    private func getVenueList() {
        webService.fetchData(urlString: viewModel.requestURLString, objectType: VenueList.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let venueList):
                strongSelf.viewModel.venueList = venueList
            case .failure(let AppErrors):
                strongSelf.handleNetworkError(error: AppErrors)
            }
        }
    }
    
    func handleNetworkError(error: AppError) {
        switch error {
        case .networkError(let error):
            displayAlert(message: "\(error)")
        case .dataNotFound:
            displayAlert(message: "Data not found!")
        case .jsonParsingError(let error):
            displayAlert(message: "\(error)")
        case .invalidURL:
            displayAlert(message: "Invalid URL")
        }
    }
}
