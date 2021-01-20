//
//  DetailViewController.swift
//  BreakingBadCharacters
//
//  Created by Srujan on 12/01/21.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var occupationLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var seasonsLabel: UILabel!
    var character : BadCharacterElement?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        // Do any additional setup after loading the view.
    }
    
    func setUpUI(){
        if let char = character{
            self.title = char.name
            self.occupationLabel.text = char.occupation.joined(separator: ",")
            self.statusLabel.text = char.status.rawValue
            self.nickNameLabel.text = char.nickname
            if let appear = char.appearance{
                self.seasonsLabel.text = appear.map{"\($0)"}.joined(separator: ",")
                self.imageView.downloaded(from: char.img)
            }
        }
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
