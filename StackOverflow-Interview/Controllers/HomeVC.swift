//
//  ViewController.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/16.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UISearchBarDelegate {

    //Initializers
    let stackOverFlowApiCalls = StackOverflowApiCalls()
    
    //UI Elements
    @IBOutlet weak var uiVIewError: UIView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var tvSearchresultTableView: UITableView!
    @IBOutlet weak var txfSearchBar: UISearchBar!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    //Variables
    private var searchResultItems: allSearchItems?
    var newPage = 2
    var searchInput : String = ""
    var lastSearchItem:searchSOInputObjectModel!
    
    //Constraints
    @IBOutlet weak var csUiViewErrorConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        prepareUI()
        searchForTopics(searchItem: "")
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
   func prepareUI(){
//        txfSearchBar.layer.borderWidth = 1.0
//        txfSearchBar.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
//        txfSearchBar.layer.cornerRadius = 10
//        txfSearchBar.searchTextField.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        csUiViewErrorConstraints.constant = 0
    }
    
    func searchForTopics(searchItem:String){
        //Make sure device has internet before making api call
        if !checkInterConnection() {
            displayErrorMessage(error: "Please check your internet connection")
            return
        }
        // dismiss any errors that was there before
        dismissErrorMessage()
        
        //show loading screen
        setLoadingIndicator()
        
        //Initialize Search Object
        lastSearchItem = searchSOInputObjectModel(title: searchItem, page: 1, pagesize: 15)
        
        //Make api call
        stackOverFlowApiCalls.fetchSearchResult(searchObjectModel: lastSearchItem) { (result) in
            switch(result){
            case let .success(searchResult):
                self.searchResultItems = searchResult
                DispatchQueue.main.async {
                    self.disableLoadingIndicator()
                    self.tvSearchresultTableView.reloadData()
                }
            case let .failure(failureResponse ):
                DispatchQueue.main.async {
                    self.disableLoadingIndicator()
                    switch failureResponse{
                    case .statusCode(.throttle_violation):
                        self.displayErrorMessage(error: "Oops too many attempts in such a short time, try again later")
                    default:
                        self.displayErrorMessage(error: "We did something wrong, please try again later")
                    }
                   
                }
                
            }
        }
        
    }
    
    func addMoreItemsToSearchList(page:Int){
        //Make sure device has internet before making api call
        if !checkInterConnection() {
            return
        }
        //Show loading screen
        setLoadingIndicator()
        //Initialize Search object
        lastSearchItem = searchSOInputObjectModel(title: searchInput, page: page, pagesize: 15)
        
        //Make Api Call
        stackOverFlowApiCalls.fetchSearchResult(searchObjectModel: lastSearchItem) { (result) in
            switch(result){
            case let .success(newSearchItems):
                DispatchQueue.main.async {
                    if newSearchItems.items.count > 0 {
                    self.disableLoadingIndicator()
                    self.searchResultItems?.items.append(contentsOf: newSearchItems.items)
                    self.tvSearchresultTableView.reloadData()
                    self.newPage = self.newPage + 1
                    }
                }
            case let .failure(error):
                print(error)
                self.disableLoadingIndicator()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchInput = searchBar.text ?? ""
        print("search bar clicked")
        searchForTopics(searchItem: searchInput)
        searchBar.resignFirstResponder()
    }
    
    func setLoadingIndicator(){
        loadingIndicator.isHidden = false;
        self.view.isUserInteractionEnabled = false;
    }
    
    func disableLoadingIndicator(){
        loadingIndicator.isHidden = true;
        self.view.isUserInteractionEnabled = true;
    }
    
    func displayErrorMessage(error:String){
        self.uiVIewError.isHidden = false;
        self.csUiViewErrorConstraints.constant = 100
        self.lblErrorMessage.text = error
        
    }
    
    func dismissErrorMessage(){
        self.csUiViewErrorConstraints.constant = 0
        self.uiVIewError.isHidden = true;
    }
}

extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("something")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "testStory") as! DetailVC
//        self.present(vc,animated: true)
        vc.searchResultItem = searchResultItems?.items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchResultItems?.items.count == 0{
            return 1
        }
        return searchResultItems?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if searchResultItems?.items != nil && (searchResultItems?.items.count)! > 0{
            let cell: tvcSoSearchResult = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! tvcSoSearchResult
            //Each Object
            let singleSearchResultItem:searchResultObjectModel = (searchResultItems?.items[indexPath.row])!

            //Set Items to Tableview
            cell.imgCheckMark.image = UIImage(named: "ic-check")
            cell.lblTitle.text = "Q: \(singleSearchResultItem.title)"
            cell.lblBody.attributedText = NSAttributedString(html:singleSearchResultItem.body,fontSize: 10)
            cell.lblDate.text = "\(convertIntDateToSearchResultDate(date: singleSearchResultItem.creation_date)) by \(singleSearchResultItem.owner?.display_name ?? "user_does_not_exist")"
            cell.lblAnswerCount.text = "\(singleSearchResultItem.answer_count) answers"
            cell.lblVoteCount.text = "\(singleSearchResultItem.score) votes"
            cell.lblViewsCount.text = "\(singleSearchResultItem.view_count) views"

             return cell
        }else{
            print("NO result i need to show another cell now")
            let errorCell = tableView.dequeueReusableCell(withIdentifier: "errorCell", for: indexPath)
            errorCell.textLabel?.text = "NO RESULT FOUND"
            return errorCell
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // UITableView only moves in one direction, y axis
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        if maximumOffset - currentOffset <= 5 {
                print("i went into this function for calling the api")
                addMoreItemsToSearchList(page: newPage)

        }
    }
}



