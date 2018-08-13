//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mark Kinoshita on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var screen_nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        messageLabel.text = tweet.text
        usernameLabel.text = tweet.user.name
        screen_nameLabel.text = tweet.user.screenName
        dateLabel.text = tweet.createdAtString
                
        retweetCountLabel.text = String(tweet.retweetCount)
        favoriteCountLabel.text = String(tweet.favoriteCount)
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        profileImageView.af_setImage(withURL: tweet.user.profileImage!)
                
        if tweet.favorited! {
            favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
        }
        if tweet.retweeted {
            retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)

        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapRetweet(_ sender: Any) {
        if tweet.retweeted == false {
            tweet.retweeted = true
            tweet.retweetCount += 1
            retweetCountLabel.text = String(tweet.retweetCount)
            
            (sender as! UIButton).setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.retweeted = false
            tweet.retweetCount -= 1
            retweetCountLabel.text = String(tweet.retweetCount)
            
            (sender as! UIButton).setImage(UIImage(named: "retweet-icon.png"), for: UIControlState.normal)
            
            APIManager.shared.unRetweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }

    @IBAction func didTapLike(_ sender: Any) {
        if tweet.favorited! == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            favoriteCountLabel.text = String(tweet.favoriteCount)
            
            (sender as! UIButton).setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favorited = false
            tweet.favoriteCount -= 1
            favoriteCountLabel.text = String(tweet.favoriteCount)
            
            
            (sender as! UIButton).setImage(UIImage(named: "favor-icon.png"), for: UIControlState.normal)
            
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "replySegue" {
            print("About to reply")
            
            let replyViewController = segue.destination as! ReplyViewController
            replyViewController.tweet = tweet 
        }
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
