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
    private let homeHeaderView = HomeHeaderView()
    private var webService: WebService
    
    private var limit = 0 {
        didSet {
            getVenueList()
        }
    }
    
    private var viewModel = HomeViewModel.defaultViewModel {
        didSet {
            DispatchQueue.main.async {
                self.homeView.tableView.reloadData()
            }
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
        setupTableView()
        getVenueList()
    }
    
    func setupTableView() {
        homeView.tableView.register(ComponentTableViewCell<VenueTableComponent>.self, forCellReuseIdentifier: "VenueCell")
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
    }
}

//MARK: - TableView Datasource & Delegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        homeHeaderView.applyHeader(locationName: viewModel.venueList.response.headerFullLocation,
                                   totalResults: viewModel.venueList.response.totalResults,
                                   loadedResults: viewModel.limit)
        return homeHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.firstGroup.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VenueCell", for: indexPath) as! ComponentTableViewCell<VenueTableComponent>
        print(viewModel.venuePhotoImageURLs[safe: indexPath.row])
        let cellComponentVM = VenueTableComponent.ViewModel(venueData: viewModel.firstGroup[indexPath.row].venue, venueImageURL: viewModel.venuePhotoImageURLs[safe: indexPath.row] ?? "")
        let viewModel = ComponentTableViewCell<VenueTableComponent>.ViewModel(componentViewModel: cellComponentVM)
        cell.apply(viewModel: viewModel)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.estimatedRowHeight = 190
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard limit < viewModel.venueList.response.totalResults else { return }
        if indexPath.section == tableView.numberOfSections - 1 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            limit += 10
            viewModel.limit = limit
        }
    }
}

//MARK: - WebService
extension HomeViewController {
    private func getVenueList() {
        webService.fetchData(urlString: viewModel.mainRequestURL, objectType: VenueList.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let venueList):
                strongSelf.viewModel.venueList = venueList
                strongSelf.getVenuePhotos()
            case .failure(let AppErrors):
                strongSelf.handleNetworkError(error: AppErrors)
            }
        }
    }
    
    private func getVenuePhotos() {
        viewModel.venuIds.forEach {
            webService.fetchData(urlString: viewModel.photoRequestURL(venueId: $0), objectType: VenuePhotoResponse.self) { [weak self] result in
                guard let strongSelf = self else { return }
                switch result {
                case .success(let venuePhotoResponse):
                    strongSelf.viewModel.venuePhotoResponse.append(venuePhotoResponse)
                case .failure(let AppErrors):
                    strongSelf.handleNetworkError(error: AppErrors)
                }
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
