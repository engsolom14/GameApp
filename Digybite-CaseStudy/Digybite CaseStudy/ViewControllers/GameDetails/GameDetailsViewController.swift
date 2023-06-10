//
//  GameDetailsViewController.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 10/06/2023.
//

import UIKit

class GameDetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descTextView: UITextView!
    @IBOutlet weak var descriptionTVHeight: NSLayoutConstraint!
    @IBOutlet weak var linkBtnOutlet: UIButton!
    
    var configurator = GameDetailsConfiguratorImplementation()
    var presenter: GameDetailsPresenter?

    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //configurator.configure(GameDetailsViewController: self)
        presenter?.viewDidLoad()
                
    }

    @IBAction func linkBtnPressed(_ sender: UIButton) {
        if let url = URL(string: url ?? "") {
            UIApplication.shared.open(url)
        }

    }
    
    @IBAction func readMoreBtnPressed(_ sender: UIButton) {
        descriptionTVHeight.constant = descTextView.contentSize.height
        descTextView.gestureRecognizers?.removeAll()
    }
    
}

extension GameDetailsViewController: GameDetailsView {
    func setTitle(isFav: Bool) {
        if isFav {
            self.title = "Favorited"
        } else {
            self.title = "Not Favorited"
        }

    }
    
    func updateData(game: GameDetails) {
        self.titleLbl.text = game.name
        self.descTextView.text = game.description
        self.url = game.url
        if url == "" {
            linkBtnOutlet.isHidden = true
        } else {
            linkBtnOutlet.isHidden = false
        }
    }
    
    
    func showLoader() {
        print("SHOW LOADER")
        view.showAnimatedSkeleton()
    }
    
    func hideLoader() {
        print("Hide LOADER")
        view.hideSkeleton()
    }
    
    func showAPIErrorAlert(error: CustomError) {
        print("ERROR API")
        self.networkFailureResponse(error: error)
    }
    
    func fetchDataSucessfull() {
        
    }

}
