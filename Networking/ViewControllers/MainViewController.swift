//
//  MainViewController.swift
//  Networking
//
//  Created by Anikin Ilya on 22.09.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet var logoImage: UIImageView!
    
    //MARK: - Private Properties
    private let logoUrl = "https://media.cdn.adultswim.com/uploads/20210428/21428161947-rick-and-morty-logo-png.png"
    
    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchLogo()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCharacter" {
            guard let characterVC = segue.destination as? CharacterViewController else { return }
            characterVC.fetchCharacter()
        }
    }
    
    //MARK: - IBActions
    @IBAction func CharactersInfoButtonPressed() {
        performSegue(withIdentifier: "showCharacter", sender: nil)
    }
    
    private func fetchLogo() {
        NetworkManager.shared.fetchImage(from: logoUrl) {[weak self] result in
            switch result {
            case .success(let imageData):
                self?.logoImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
}
