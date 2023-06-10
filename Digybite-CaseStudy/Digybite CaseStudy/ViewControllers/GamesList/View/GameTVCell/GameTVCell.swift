//
//  GameTVCell.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 02/06/2023.
//

import UIKit
//import Lottie

class GameTVCell: UITableViewCell {
    
    @IBOutlet weak var gameImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var genersLbl: UILabel!
    
    @IBOutlet weak var cellBGView: GradientView!
    @IBOutlet weak var favView: UIView!
    @IBOutlet weak var favBtn: UIButton!
    private var presenter: GamesListPresenter?
    
    static let cellName = "GameTVCell"
    static let cellIdentifier = "GameTVCell"
//    let animationView = AnimationView(name: "like")
    weak var delegate: GameTVCellDelegate?

    var animated = 0
    var game: Game?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.showAnimatedSkeleton()
    }
    
    func hideSkeletonView() {
//        isUserInteractionEnabled = true
        hideSkeleton()
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        if animated == 0 {
                self.favBtn.setImage(UIImage(named: "icon-heart"), for: .normal)
                self.animated = 1
                game?.isFavorite = false
            delegate?.didTapFavButton(for: game!)
            } else {
                self.animated = 0
                self.favBtn.setImage(UIImage(named: "icon-heart-unfill"), for: .normal)
                game?.isFavorite = true
                delegate?.didTapFavButton(for: game!)
            }
    }
}

protocol GameTVCellDelegate: AnyObject {
    func didTapFavButton(for game: Game)
}

extension GameTVCell: GamesListCellView {
    func isFavShown(isFav: Bool) {
        favView.isHidden = !isFav
    }
    
    func displayImage(image: String) {
        ImageShowing().showImage(imgURl:image , imgView: gameImg, avatar: "imageAvatar")
    }
    
    func displayName(name: String) {
        self.nameLbl.text = name
    }
    
    func displayGeners(name: String) {
        self.genersLbl.text = name
    }
    
    func isFav(isFav: Bool) {
        isFav ? self.favBtn.setImage(UIImage(named: "icon-heart"), for: .normal) : self.favBtn.setImage(UIImage(named: "icon-heart-unfill"), for: .normal)
    }
    
    func isOpened(isOpened: Bool) {
        if isOpened {
            self.cellBGView.startColor = #colorLiteral(red: 0.368627451, green: 0.6901960784, blue: 0.4274509804, alpha: 0.2609685431)
            self.cellBGView.endColor = #colorLiteral(red: 0.272586222, green: 0.6196078431, blue: 0.3176470588, alpha: 0.8154232202)
        } else {
            self.cellBGView.startColor = #colorLiteral(red: 1, green: 0.6901960784, blue: 0.4274509804, alpha: 0.2609685431)
            self.cellBGView.endColor = #colorLiteral(red: 0.9725490196, green: 0.6196078431, blue: 0.3176470588, alpha: 0.8154232202)
        }
        
    }
    
    func configure(game: Game) {
        self.game = game
    }
}
