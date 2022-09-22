//
//  CharacterViewController.swift
//  Networking
//
//  Created by Anikin Ilya on 22.09.2022.
//

import UIKit

class CharacterViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet var characterImageView: UIImageView!
    @IBOutlet var imageActivityIndiacator: UIActivityIndicatorView!
    @IBOutlet var characterInfoLabel: UILabel!
    
    //MARK: - Private Properties
    private var characterNumberCounter = 0
    private var character: Character?
    
    //MARK: - Override Methods
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageActivityIndiacator.startAnimating()
        
        updateView()
    }
    
    //MARK: - IBActions
    @IBAction func getNextCharacterButtonPressed() {
        fetchCharacter()
        updateView()
    }
    
    //MARK: - Private Methods
    private func updateView(){
        characterInfoLabel.text =
        """
            Name: \(character?.name ?? "unknown")
            Status: \(character?.status ?? "unknown")
            Species: \(character?.species ?? "unknown")
            Type: \(character?.type ?? "unknown")
            Gender: \(character?.gender ?? "unknown")
            Location: \(character?.location?.name ?? "unknown")
        """
        
        NetworkManager.shared.fetchImage(from: self.character?.image) {[weak self] result in
            switch result {
            case .success(let imageData):
                self?.characterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
            
            self?.imageActivityIndiacator.stopAnimating()
            self?.imageActivityIndiacator.isHidden = true
        }
    }
    
    private func getUrl() -> String {
        if characterNumberCounter > 300 {
            characterNumberCounter = 1
        } else {
            characterNumberCounter += 1
        }
        return "https://rickandmortyapi.com/api/character/\(characterNumberCounter)"
    }
}

//MARK: - Networking
extension CharacterViewController {
    func fetchCharacter() {
        let characterUrl = getUrl()
        
        NetworkManager.shared.fetchCharacter(from: characterUrl) { [weak self] result in
            switch result {
            case .success(let characterData):
                self?.character = characterData
            case .failure(let error):
                print(error)
                self?.failAlert()
            }
        }
        
    }
    
    private func failAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Failed",
                message: "You can see error in the Debug area",
                preferredStyle: .alert
            )
            
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
}
