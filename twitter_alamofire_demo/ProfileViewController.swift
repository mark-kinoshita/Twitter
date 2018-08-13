//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Mark Kinoshita on 3/9/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        bannerImageView.af_setImage(withURL: (User.current?.banner_url)!)
        profileImageView.af_setImage(withURL: (User.current?.profileImage)!)
        profileImageView.layer.cornerRadius = 60
        profileImageView.clipsToBounds = true
        nameLabel.text = User.current?.name
        screenNameLabel.text = User.current?.screenName
        descriptionLabel.text = User.current?.description
        followingCountLabel.text = String(describing: User.current!.following!)
        followersCountLabel.text = String(describing: User.current!.followers!)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
