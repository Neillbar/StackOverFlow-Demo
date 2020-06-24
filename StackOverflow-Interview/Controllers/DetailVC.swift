//
//  DetailVC.swift
//  StackOverflow-Interview
//
//  Created by Neill Barnard on 2020/06/18.
//  Copyright © 2020 Neill Barnard. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {
    //Initializers
    let stackOverFlowApiCalls = StackOverflowApiCalls()
    //Var
    var searchResultItem: searchResultObjectModel!
    var allAnswers: allAnswersItems?
    var lastSelectedItem : AnswersInputParametersModel!
    var selectedItem = 0;
    
    //UI ELEMENTS
    @IBOutlet weak var tblCommentsTableView: UITableView!
    @IBOutlet weak var lblErrorMessage: UILabel!
    @IBOutlet weak var errorView: UIView!
    
    //Constraints
    @IBOutlet weak var errorMessageHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateUI()
    }
    
    func populateUI(){
        self.title = "More info"
        errorMessageHeight.constant = 0
        lastSelectedItem = AnswersInputParametersModel(questionId: searchResultItem.question_id, order: "desc", sort: "activity")
        fetchAllAnswers(answersInputParametersModel: lastSelectedItem)
    }
    
    @IBAction func errorRetryButtonWasPressed(_ sender: Any) {
        fetchAllAnswers(answersInputParametersModel: lastSelectedItem)
    }
    
    
    func fetchAllAnswers(answersInputParametersModel:AnswersInputParametersModel){
        if !checkInterConnection() {
            displayErrorMessage(error: "Please check your internet connection")
            return
        }
        dismissErrorMessage()
        stackOverFlowApiCalls.fetchAnswersForQuestion(answersInputParametersModel: answersInputParametersModel) { (result) in
            switch result {
            case let .failure(failure):
                DispatchQueue.main.async {
                    var err:String;
                    switch failure{
                    case let .internalError(error):
                        err = error
                    default:
                        err = "Something went wrong, please try again later"
                    }
                    self.displayErrorMessage(error: err)
                }
            case let .success(answers):
                DispatchQueue.main.async {
                    self.allAnswers = answers
                    self.tblCommentsTableView.reloadData()
                }
                
            }
        }
    }
    
    @objc func filterPressed(segment: UISegmentedControl){        
        if segment.selectedSegmentIndex == 0{
//            ACTIVE
            lastSelectedItem = AnswersInputParametersModel(questionId: searchResultItem.question_id, order: "desc", sort: "activity")
            fetchAllAnswers(answersInputParametersModel: lastSelectedItem)
        }
        if segment.selectedSegmentIndex == 1{
//            OLDEST
            lastSelectedItem = AnswersInputParametersModel(questionId: searchResultItem.question_id, order: "asc", sort: "creation")
            fetchAllAnswers(answersInputParametersModel: lastSelectedItem)
        }
        if segment.selectedSegmentIndex == 2{
//           VOTES
            lastSelectedItem = AnswersInputParametersModel(questionId: searchResultItem.question_id, order: "desc", sort: "votes")
            fetchAllAnswers(answersInputParametersModel: lastSelectedItem)
        }
        
        
    }
    
    func displayErrorMessage(error:String){
        errorView.isHidden = false
        errorMessageHeight.constant = 100
        lblErrorMessage.text = error
        
    }
    
    func dismissErrorMessage(){
        errorMessageHeight.constant = 0
        errorView.isHidden = true
    }
    
    
}

//Extension for tableview
extension DetailVC: UITableViewDelegate,UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allAnswers?.items != nil && allAnswers?.items.count ?? 0 > 0 {
            return (allAnswers?.items.count)! + 3
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cellTitle = tableView.dequeueReusableCell(withIdentifier: "cellTitle", for: indexPath) as! tvcDetailedContent
            cellTitle.lbltitle.text = searchResultItem.title
            cellTitle.lblAsked.text = "Asked \(convertIntToDate(timeInt: searchResultItem.creation_date).timeAgoDisplay())"
            cellTitle.lblAnswered.text = "Active \(convertIntToDate(timeInt: searchResultItem.last_activity_date).timeAgoDisplay())"
            cellTitle.lblViewed.text = searchResultItem.view_count == 1 ? "Viewed \(searchResultItem.view_count) time" : "Viewed \(searchResultItem.view_count) times"
            
            return cellTitle
        }else if indexPath.row == 1{
            let cellBody = tableView.dequeueReusableCell(withIdentifier: "cellContent", for: indexPath) as! tvcDetailedContent
            cellBody.lblBody.attributedText = NSAttributedString(html:searchResultItem.body,fontSize: 15)
            
            cellBody.lblDateQuestionWasAsked.text = "Asked \(convertIntToFullDateString(date: searchResultItem.creation_date))"
            
            if searchResultItem.owner?.profile_image != nil{
                cellBody.imgAuthorProfile.imageFromServerURL(urlString: searchResultItem.owner!.profile_image!, PlaceHolderImage: UIImage(named: "logo")!)
            }else{
                cellBody.imgAuthorProfile.image = UIImage(named: "logo")
            }
            
            cellBody.lblAuthor.text = searchResultItem.owner?.display_name
            cellBody.lblPoints.text = "\(searchResultItem.owner!.reputation ?? 0)"
            
            return cellBody
            
        }else if indexPath.row == 2 {
            let cellFilter = tableView.dequeueReusableCell(withIdentifier: "cellFilter", for: indexPath) as! tvcDetailedContent
            cellFilter.lblAnsweredTotal.text = "\(allAnswers?.items.count ?? 0) Answers"
            cellFilter.sgmFilter.addTarget(self, action: #selector(filterPressed), for: UIControl.Event.valueChanged)
            
            
            return cellFilter
        }else if indexPath.row >= 3{
            let cellComments = tableView.dequeueReusableCell(withIdentifier: "cellComments", for: indexPath) as! tvcAnswersCell
            cellComments.layer.borderColor = #colorLiteral(red: 0.5500000119, green: 0.5500000119, blue: 0.5500000119, alpha: 1)
            cellComments.layer.borderWidth = 1
            cellComments.lblTotalVotes.text = "\(allAnswers!.items[indexPath.row - 3].score) Votes"
            print(allAnswers!.items[indexPath.row - 3].is_accepted)
            if allAnswers!.items[indexPath.row - 3].is_accepted{
                cellComments.imgCheckMark.isHidden = false
                cellComments.imgCheckMark.image = UIImage(named: "ic-check")
            }else{
                cellComments.imgCheckMark.isHidden = true
            }
            
            cellComments.lblAnswer.attributedText = NSAttributedString(html:allAnswers!.items[indexPath.row - 3].body,fontSize: 10)
            cellComments.lblDatePosted.text = " Answered \(convertIntToFullDateString(date: allAnswers!.items[indexPath.row - 3].creation_date))"
            
            if allAnswers!.items[indexPath.row - 3].owner?.profile_image != nil {
                cellComments.imgAuthorProfileImage.imageFromServerURL(urlString: (allAnswers!.items[indexPath.row - 3].owner?.profile_image)!, PlaceHolderImage: UIImage(named: "logo")!)
            }else{
                cellComments.imgAuthorProfileImage.image = UIImage(named: "ic-check")
            }
            cellComments.lblReputation.text = "\(String(describing: allAnswers!.items[indexPath.row - 3].owner!.reputation ?? 0))"
            
            cellComments.lblAuthorName.text = allAnswers!.items[indexPath.row - 3].owner!.display_name
            
            
            return cellComments
            
        }else{
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}


//extension for collectionview

extension DetailVC: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResultItem.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collCell = collectionView.dequeueReusableCell(withReuseIdentifier: "clcTags", for: indexPath) as! cvcTags
        collCell.tagsButton.setTitle(searchResultItem.tags[indexPath.row], for: .normal)
        return collCell
    }
    
}


