//
//  ViewController.swift
//  Player
//
//  Created by user193665 on 3/23/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var songs = [Song]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSongs()
        
        table.delegate = self
        table.dataSource = self
    }
    
    func configureSongs(){
        
        songs.append(Song(name: "Мастер и Маргарита",
                          artist: "Баста",
                          album: "Single track",
                          image: "img_1",
                          track: "track_1"))
        
        songs.append(Song(name: "Дайджест",
                          artist: "Bumble Beezy",
                          album: "Васаби 3",
                          image: "img_2",
                          track: "track_2"))
        
        songs.append(Song(name: "Последний билет",
                          artist: "Markul",
                          album: "Tranzit",
                          image: "img_3",
                          track: "track_3"))
        
        songs.append(Song(name: "Мой кайф",
                          artist: "Pharaoh",
                          album: "Phuneral",
                          image: "img_4",
                          track: "track_4"))
        
        songs.append(Song(name: "Чистый",
                          artist: "Scriptonite",
                          album: "Single track",
                          image: "img_5",
                          track: "track_5"))
        
        songs.append(Song(name: "Мастер и Маргарита",
                          artist: "Баста",
                          album: "Single track",
                          image: "img_1",
                          track: "track_1"))
        
        songs.append(Song(name: "Дайджест",
                          artist: "Bumble Beezy",
                          album: "Васаби 3",
                          image: "img_2",
                          track: "track_2"))
        
        songs.append(Song(name: "Последний билет",
                          artist: "Markul",
                          album: "Tranzit",
                          image: "img_3",
                          track: "track_3"))
        
        songs.append(Song(name: "Мой кайф",
                          artist: "Pharaoh",
                          album: "Phuneral",
                          image: "img_4",
                          track: "track_4"))
        
        songs.append(Song(name: "Чистый",
                          artist: "Scriptonite",
                          album: "Single track",
                          image: "img_5",
                          track: "track_5"))    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.album
        cell.accessoryType = .disclosureIndicator
        
        cell.imageView?.image = UIImage(named: song.image)
        cell.textLabel?.font = UIFont(name: "Bold", size: 20)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 16)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(identifier: "player") as? PlayerViewController else {
                    return
        }
                
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
        }
    
}

// Structure of each song
struct Song {
    let name: String
    let artist: String
    let album: String
    let image: String
    let track: String
    
}

