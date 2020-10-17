//
//  BreedsListVC.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/15/20.
//

import Foundation
import UIKit
import CoreData

class BreedsListVC: UIViewController {
    
    var container: NSPersistentContainer!
    var breeds: [Breed] = []
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: Overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func openSavedPhotos(_ sender: Any) {
        let savedPhotosVC = storyboard?.instantiateViewController(withIdentifier: "SavedPhotosView") as! SavedPhotosVC
        savedPhotosVC.container = container
        navigationController?.pushViewController(savedPhotosVC, animated: true)
    }
    
}

// ----------------------------------------------------------
// MARK: UITableViewDelegate protocol methods
extension BreedsListVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedsListViewTableCell", for: indexPath) as! BreedsListViewTableCell
        cell.label.text = breeds[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let breedDetailVC = storyboard?.instantiateViewController(identifier: "BreedDetailView") as! BreedDetailVC
        breedDetailVC.container = container
        breedDetailVC.breed = breeds[indexPath.row]
        navigationController?.pushViewController(breedDetailVC, animated: true)
    }
    
}

// -----------------------------------------------------------
// MARK: UITableViewDataSource protocol methods
extension BreedsListVC: UITableViewDataSource {
    
}

// -----------------------------------------------------------
// MARK: CatClient related methods
extension BreedsListVC {
    
    private func setupView() {
        activityIndicator.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        
        CatClient.getAllBreeds { (breeds, error) in
            if let breeds = breeds {
                self.breeds = breeds
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.tableView.reloadData()
                }
            } else {
                if let error = error {
                    self.activityIndicator.stopAnimating()
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
