//
//  TweetCell.swift
//  Twitter
//
//  Created by Aldo Almeida on 2/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var handle: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    var favorited:Bool=false
    var tweetId:Int = -1
    var isRe:Bool=false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func likeTweet(_ sender: Any) {
        let tobeFav = !favorited
        if(tobeFav){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.favoritedTweet(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.favoritedTweet(false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        }
    }
    @IBAction func retweetClick(_ sender: Any) {
        let isReTweeted = !isRe
        if(isReTweeted){
            TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
                self.setreTweeted(true)
            }, failure: { (error) in
                print("Error in retweeting \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unreTweet(tweetId: tweetId, success: {
                self.setreTweeted(false)
            }, failure: { (error) in
                print("Error in un-retweeting \(error)")
            })
        }
        
    }
    
    func setreTweeted(_ isreTweeted:Bool){
        if(isreTweeted){
            retweetButton.setImage(UIImage(named:"retweet-icon-green"), for: UIControl.State.normal)
            //retweetButton.isEnabled=false
        }
        else{
            retweetButton.setImage(UIImage(named:"retweet-icon"), for: UIControl.State.normal)
            //retweetButton.isEnabled=true
        }
        
    }
    
    func favoritedTweet(_ isFavorited:Bool){
        favorited=isFavorited
        if(favorited){
            likeButton.setImage(UIImage(named:"favor-icon-1"), for: UIControl
                .State.normal)
        }
        else{
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl
            .State.normal)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
