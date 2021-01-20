//
//  ViewController.swift
//  BreakingBadCharacters
//
//  Created by Srujan on 12/01/21.
//

import UIKit

class BadCharactersViewController: UIViewController{
    //line.horizontal.3.decrease.circle and line.horizontal.3.decrease.circle.fill
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterCountLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    var viewModel = BadCharactersViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showLoader()
        viewModel.getData{
            self.hideLoader()
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func filterSeasons(_ sender: UIButton) {
        self.filterButton.isSelected = !sender.isSelected
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetails"{
            let details = segue.destination as! DetailViewController
            if let char : BadCharacterElement = sender as? BadCharacterElement{
                details.character = char
            }
        }
    }
}


extension BadCharactersViewController : UITextFieldDelegate{
    fileprivate func updateFilterCounnt() {
        if viewModel.selectedSeasons.count > 0{
            self.filterCountLabel.isHidden = false
            self.filterCountLabel.text = "\(viewModel.selectedSeasons.count)"
        }
        else{
            self.filterCountLabel.isHidden = true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            viewModel.applyFilter(text: updatedText){
                updateFilterCounnt()
                tableView.reloadData()
            }
        }
        return true
    }
    
    private func textFieldDidEndEditing(textField: UITextField) {
        viewModel.searchText = textField.text
    }
}

extension BadCharactersViewController : UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            if filterButton.isSelected{
                return viewModel.seasonFilters.count
            }
            return 0
        }
        else {
            return viewModel.filteredBadCharacters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSelectionTableViewCell") as! FilterSelectionTableViewCell
            cell.setUpUI(name: "Season \(viewModel.seasonFilters[indexPath.row])")
            cell.accessoryType = .none
            if viewModel.selectedSeasons.contains(viewModel.seasonFilters[indexPath.row]){
                cell.accessoryType = .checkmark
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BadCharcaterTableViewCell") as! BadCharcaterTableViewCell
            cell.setUpUI(badCharacter: viewModel.filteredBadCharacters[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if filterButton.isSelected{
            if section == 0{
                return 40
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if filterButton.isSelected{
            if section == 0{
                let cell = tableView.dequeueReusableCell(withIdentifier: "FilterHeader")
                return cell
            }
        }
        return UIView.init()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
            if viewModel.selectedSeasons.contains(viewModel.seasonFilters[indexPath.row]){
                viewModel.selectedSeasons.remove(at:viewModel.selectedSeasons.firstIndex(of: viewModel.seasonFilters[indexPath.row])!)
            }
            else{
                viewModel.selectedSeasons.append(viewModel.seasonFilters[indexPath.row])
            }
            updateFilterCounnt()
            viewModel.applyFilter(text:searchTextField.text){
                tableView.reloadData()
            }
        }
        else{
            self.performSegue(withIdentifier: "showDetails", sender: viewModel.filteredBadCharacters[indexPath.row])
        }
    }
}

extension BadCharactersViewController {
    func showLoader(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect.init(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoader(){
        dismiss(animated: false, completion: nil)
    }
}
