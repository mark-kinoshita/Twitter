//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mario Martinez on 3/5/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit


protocol ComposeViewControllerDelegate: NSObjectProtocol {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var characterCountLabel: UILabel!
    weak var delegate: ComposeViewControllerDelegate?

    @IBOutlet weak var tweetText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tweetText.delegate = self
        tweetText.isEditable = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func didPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetText.text!) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // TODO: Check the proposed new text character count
        // Allow or disallow the new text
        
        // Set the max character limit
        let characterLimit = 140
        
        // Construct what the new text would be if we allowed the user's latest edit
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        
        // TODO: Update Character Count Label
        characterCountLabel.text = String(characterLimit - newText.characters.count)
        
        
        // The new text should be allowed? True/False
        return newText.characters.count < characterLimit
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
