//
//  BreedDetailVC.swift
//  TheCatApp
//
//  Created by Nathan Novacek on 10/15/20.
//

import Foundation
import UIKit
import CoreData

class BreedDetailVC: UIViewController {
    
    var container: NSPersistentContainer!
    var breed: Breed!
    var cleanedBreed = [Mirror.Child]()
    var descriptionAndTemperament = [Mirror.Child]()
    var excludedAttributes = [
        "id",
        "description",
        "temperament",
        "alt_names",
        "country_code",
        "country_codes",
        "experimental",
        "wikipedia_url",
        "cfa_url",
        "vcahospitcals_url",
        "vetstreet_url",
        "name"
    ]
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var noImagesLabel: UILabel!
    @IBOutlet weak var getNewImageButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        cleanBreedsList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let breedDescriptionAndTemperamentVC = segue.destination as? BreedDescriptionAndTemperamentVC {
            breedDescriptionAndTemperamentVC.descriptionAndTemperament = descriptionAndTemperament
        }
    }

    @IBAction func getNewImage(_ sender: Any) {
        imageView.image = nil
        getBreedImages()
    }
    
    @IBAction func saveCatImage(_ sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            if let imageData = imageView.image?.jpegData(compressionQuality: 1) {
                saveImageToCoreData(data: imageData)
                let alertController = UIAlertController(title: "SUCCESS", message: "Image has been saved", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "ERROR", message: "An error has occurred and the image could not be saved.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .cancel)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

}

// ---------------------------------------------------------
// MARK: UITableViewDelegate protocol methods
extension BreedDetailVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Breed Details"
    }
    
}

// ---------------------------------------------------------
// MARK: UITableViewDataSource protocol methods
extension BreedDetailVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cleanedBreed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BreedDetailTableCell", for: indexPath) as! BreedDetailTableCell
        if let label = cleanedBreed[indexPath.row].label {
            cell.attributeLabel.text = cleanAttributeLabel(label: label)
            if let stringValue = cleanedBreed[indexPath.row].value as? String {
                cell.valueLabel.text = stringValue
            } else if let intValue = cleanedBreed[indexPath.row].value as? Int {
                cell.valueLabel.text = String(intValue)
            } else {
                cell.valueLabel.text = "Unknown"
            }
        }
        return cell
    }

}

// ---------------------------------------------------------
// MARK: Custom methods
extension BreedDetailVC {
    
    private func setupView() {
        title = breed.name
        tableView.delegate = self
        tableView.dataSource = self
        imageView.isUserInteractionEnabled = true
        noImagesLabel.text = ""
        getBreedImages()
    }
    
    private func cleanBreedsList() {
        if let breed = breed {
            let mirror = Mirror(reflecting: breed)
            for child in mirror.children {
                if !excludedAttributes.contains(child.label!) {
                    cleanedBreed.append(child)
                } else if child.label! == "description" || child.label! == "temperament" {
                    descriptionAndTemperament.append(child)
                }
            }
        }
    }
    
    private func cleanAttributeLabel(label: String) -> String {
        let cleanLabel = label.replacingOccurrences(of: "_", with: " ")
        return cleanLabel.capitalized
    }
    
}

// --------------------------------------------------------------
// MARK: CatClient related methods
extension BreedDetailVC {
    
    private func getBreedImages() {
        activityIndicator.startAnimating()
        if let breedId = breed.id {
            CatClient.getImageByBreedId(breedId: breedId) { (image, error) in
                if let image = image {
                    for item in image {
                        if let urlString = item.url {
                            if let url = URL(string: urlString) {
                                self.downloadImage(url: url) { (data, error) in
                                    if let data = data {
                                        DispatchQueue.main.async {
                                            self.activityIndicator.stopAnimating()
                                            self.imageView.image = UIImage(data: data)
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    if let error = error {
                        self.activityIndicator.stopAnimating()
                        print(error.localizedDescription)
                    }
                }
            }
        } else {
            self.activityIndicator.stopAnimating()
            self.noImagesLabel.text = "No Images Found"
        }
    }
    
    private func downloadImage(url: URL, completionHandler: @escaping(Data?, Error?) -> Void) {
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                completionHandler(data, nil)
            } else {
                completionHandler(nil, error)
            }
        }
        task.resume()
    }
    
}

// ------------------------------------------------------
// MARK: CoreData related methods
extension BreedDetailVC {
    
    func saveImageToCoreData(data: Data) {
        let photo = Photo(context: container.viewContext)
        photo.imageData = data
        DispatchQueue.main.async {
            do {
                try self.container.viewContext.save()
            } catch {
                fatalError("An error occurred while trying to save a photo.")
            }
        }
    }
    
}
