//
//  SearchViewController.swift
//  SkiMountainFinder
//
//  Created by Peyton McKee on 12/8/21.
//

import UIKit

class SearchMountainViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var searchTextField: UITextField!
    
    static var searchText = ""
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        imageView.contentMode = .scaleToFill
        imageView.image = images.first
        animateImageView(imageView: imageView)
        // Do any additional setup after loading the view.
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = searchTextField.text
        {
            SearchMountainViewController.searchText = text
        }
        performSegue(withIdentifier: "fromMountainSearchController", sender: self)
        return true
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
