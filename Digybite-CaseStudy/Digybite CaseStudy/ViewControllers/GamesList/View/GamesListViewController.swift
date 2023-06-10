//
//  GamesListViewController.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 01/06/2023.
//

import UIKit
import SkeletonView

class GamesListViewController: UIViewController {
    
    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    weak var delegate: GameListDelegate?
    var configurator = GamesListConfiguratorImplementation()
    var presenter: GamesListPresenter?
    
    let refreshControl = UIRefreshControl()
    var isFav = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurator.configure(GamesListViewController: self)
        presenter?.viewDidLoad()
        initView()
    }
    
    func initView() {
        self.title = "Game App"
        registerCell()
        refreshController()
        
        let resetButton = UIBarButtonItem(image: UIImage(named: "reset"), style: .plain, target: self, action: #selector(resetBtnPressed)
        )
        self.navigationItem.rightBarButtonItem = resetButton
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        searchTextField.clearButtonMode = .whileEditing
    }
    
    func registerCell() {
        self.gameTableView.register(UINib(nibName: GameTVCell.cellName, bundle: nil), forCellReuseIdentifier: GameTVCell.cellIdentifier)
    }
    
    func refreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        gameTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        presenter?.refreshGamesList()
    }
    
    @objc func resetBtnPressed() {
        //TODO: add reset for opened colors
        presenter?.removeAllGames()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let searchString = textField.text, searchString.count >= 3 {
            presenter?.setSearchVal(searchString)
            presenter?.viewDidLoad()
        }
    }
    
}

//MARK: TableView
extension GamesListViewController: UITableViewDataSource, UITableViewDelegate {
   
    func insertNewRows(at indexPaths: [IndexPath]) {
        gameTableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
            if indexPath.row == lastRowIndex {
                presenter?.loadMore()
            }
        }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (presenter?.numberOfRow() == 0) ? 10:presenter?.numberOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GameTVCell.cellIdentifier, for: indexPath) as? GameTVCell {
            cell.showSkeleton()
            if presenter?.numberOfRow() != 0 {
                cell.hideSkeletonView()
                cell.delegate = self
                presenter?.configure(cell: cell, forRow: indexPath.row)
            }
            return cell
        }else{
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? GameTVCell {
            cell.isOpened(isOpened: true)
        }

        delegate?.didSelectGame(id: presenter?.selectedId(id: indexPath.row) ?? 1, isFav: isFav)
    }
    
}

protocol GameListDelegate: AnyObject {
    func didSelectGame(id: Int, isFav: Bool)
}

extension GamesListViewController: GamesListView {
    func showLoader() {
        self.gameTableView.showAnimatedSkeleton()
    }
    
    func hideLoader() {
        self.gameTableView.hideSkeleton()
    }
    
    func showAPIErrorAlert(error: CustomError) {
        self.networkFailureResponse(error: error)
        refreshControl.endRefreshing()
        presenter?.loadGamesListFromLocalStorage()
    }
    
    func fetchDataSucessfull() {
        self.gameTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func loadMoreSpinner() {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: gameTableView.bounds.width, height: CGFloat(44))
        
        self.gameTableView.tableFooterView = spinner
        self.gameTableView.tableFooterView?.isHidden = false
    }
    
    func loadmoreHideSpinner() {
        self.gameTableView.tableFooterView?.isHidden = true
    }
}

extension GamesListViewController: GameTVCellDelegate {
    func didTapFavButton(for game: Game) {
        if game.isFavorite ?? false {
            self.isFav = false
            presenter?.removeFavGames(for: game)
        } else {
            self.isFav = true
            presenter?.saveFavGame(for: game)
        }
    }
}

extension GamesListViewController: UITextFieldDelegate {
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        presenter?.setSearchVal("")
        presenter?.viewDidLoad()
        return true
    }
}
