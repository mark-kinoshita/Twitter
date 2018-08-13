//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var likedCountLabel: UILabel!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            usernameLabel.text = tweet.user.name
            screenNameLabel.text = tweet.user.screenName
            dateLabel.text = tweet.createdAtString
            
            retweetCountLabel.text = String(tweet.retweetCount)
            likedCountLabel.text = String(tweet.favoriteCount)
            
            profileImageView.af_setImage(withURL: tweet.user.profileImage!)
            
            if tweet.favorited! {
                favoriteButton.setImage(UIImage(named: "favor-icon-red.png"), for: UIControlState.normal)
            }
            if tweet.retweeted {
                retweetButton.setImage(UIImage(named: "retweet-icon-green.png"), for: UIControlState.normal)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        // Initialization code
        
    }
    @IBAction func didTapLike(_ sender: Any) {
        
        if tweet.favorited! == false {
            tweet.favorited = true
            tweet.favoriteCount += 1
            likedCountLabel.text = String(tweet.favoriteCount)
            
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
            likedCountLabel.text = String(tweet.favoriteCount)

            
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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
}
