//
//  HomeTable.swift
//  Twitter
//
//  Created by Aldo Almeida on 2/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTable: UITableViewController {
    var tweetArray=[NSDictionary]()
    var numTweets : Int!
    let refresh=UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTweet()
        refresh.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl=refresh
    }
    
    @objc func loadTweet(){
        numTweets=20
        let url="https://api.twitter.com/1.1/statuses/home_timeline.json"
        let myParam=["count":numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myParam, success: { (tweets:[NSDictionary]) in
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            self.refresh.endRefreshing()
            
        }, failure: { (Error) in
            print("Error in retrieving tweets!")
        })
    }
    
    func loadMoreTweets(){
        let url="https://api.twitter.com/1.1/statuses/home_timeline.json"
        numTweets=numTweets+20
        let myParam=["count":numTweets]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: url, parameters: myParam, success: { (tweets:[NSDictionary]) in
            self.tweetArray.removeAll()
            
            for tweet in tweets{
                self.tweetArray.append(tweet)
            }
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Error in retrieving tweets!")
        })

        
    }


    @IBAction func onLogout(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row+1==tweetArray.count{
            loadMoreTweets()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tweetCell",for: indexPath) as! TweetCell
        let user=tweetArray[indexPath.row]["user"] as! NSDictionary
        cell.userLabel.text=user["name"] as? String
        cell.tweetContent.text=tweetArray[indexPath.row]["text"] as? String
        let imageURL=URL(string: (user["profile_image_url_https"] as? String)!)
        let data=try? Data(contentsOf: imageURL!)
        if let imageData=data{
            cell.picView.image=UIImage (data: imageData)
        }
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
