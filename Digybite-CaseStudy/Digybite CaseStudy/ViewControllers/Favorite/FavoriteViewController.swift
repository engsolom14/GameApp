//
//  FavoriteViewController.swift
//  Digybite CaseStudy
//
//  Created by Eslam on 01/06/2023.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var gameTableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    var configurator = FavoriteConfiguratorImplementation()
    var presenter: FavoritePresenter?
    weak var delegate: FavDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(FavoriteViewController: self)
        initView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
    }
    
    func initView() {
        self.title = "Favorited Games"
        registerCell()

    }
    
    func registerCell() {
        self.gameTableView.register(UINib(nibName: GameTVCell.cellName, bundle: nil), forCellReuseIdentifier: GameTVCell.cellIdentifier)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavoriteViewController: FavoriteView {
    func noData() {
        self.emptyView.isHidden = false
        self.gameTableView.isHidden = true
    }
    
    func loadDataSucessfull() {
        self.emptyView.isHidden = true
        self.gameTableView.isHidden = false
        self.gameTableView.reloadData()
    }

}

protocol FavDelegate: AnyObject {}

extension FavoriteViewController: UITableViewDataSource, UITableViewDelegate {
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRow() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: GameTVCell.cellIdentifier, for: indexPath) as? GameTVCell {
            cell.showSkeleton()
            if presenter?.numberOfRow() != 0 {
                cell.hideSkeletonView()
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
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.alertCallBack(title: "Alert", message: "Are you sure you want to delete?", img: "", confirm: "OK", cancel: "cancel", completion: { [weak self] _ in
                self!.presenter?.delete(index: indexPath.row)
                
            })
            
        }
        return [delete]
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            //self.presenter?.delete(index: indexPath.row)
//        }
//    }

    
}
