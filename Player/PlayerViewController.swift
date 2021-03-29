//
//  PlayerViewController.swift
//  Player
//
//  Created by user193665 on 3/24/21.
//

import UIKit
import AVFoundation //for Audio

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    var player: AVAudioPlayer?
    
    // User Interface elements
       private let albumImageView: UIImageView = {
           let imageView = UIImageView()
           imageView.contentMode = .scaleAspectFill
           return imageView
       }()

       private let songNameLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.numberOfLines = 0
           return label
       }()

       private let artistNameLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.numberOfLines = 0
           return label
       }()

       private let albumNameLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.numberOfLines = 0 
           return label
       }()
        
    
    let playPauseButton = UIButton()

    @IBOutlet var viewHolder: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            if viewHolder.subviews.count == 0 {
                main()
            }
    }
    
    // Главная функция, которая вызывается каждый раз при нажатии на трек
    func main() {
        // set up player
        let song = songs[position]

        let urlString = Bundle.main.path(forResource: song.track, ofType: "mp3")

        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)

            guard let urlString = urlString else {
                print("Url is nil!")
                return
            }

            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)

            guard let player = player else {
                print("Player is nil!")
                return
            }
            player.volume = 0.5
            player.play()
            
            

        }
        catch {
            print("Error!")
        }
        
        // Интерфейс каждого трека
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: viewHolder.frame.size.width-20,
                                      height: viewHolder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.image)
        
        viewHolder.addSubview(albumImageView)


        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10,
                                     width: viewHolder.frame.size.width-20,
                                     height: 50)
        
        albumNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10 + 30,
                                     width: viewHolder.frame.size.width-20,
                                     height: 50)
        
        artistNameLabel.frame = CGRect(x: 10,
                                       y: albumImageView.frame.size.height + 10 + 60,
                                       width: viewHolder.frame.size.width-20,
                                       height: 50)
        

        songNameLabel.text = song.name
        albumNameLabel.text = song.album
        artistNameLabel.text = song.artist


        viewHolder.addSubview(songNameLabel)
        viewHolder.addSubview(albumNameLabel)
        viewHolder.addSubview(artistNameLabel)

        
        
        // Кнопки
        let previousButton = UIButton()
        let nextButton = UIButton()
        let rewindButton = UIButton()
        let fastButton = UIButton()
        
        
        
        // Расположение кнопок
        let yPosition = artistNameLabel.frame.origin.y + 70
        let size: CGFloat = 50

        playPauseButton.frame = CGRect(x: (viewHolder.frame.size.width - size) / 2.0,
                                       y: yPosition,
                                       width: size,
                                       height: size)
        
        previousButton.frame = CGRect(x: 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        nextButton.frame = CGRect(x: viewHolder.frame.size.width - size - 20,
                                  y: yPosition,
                                  width: size,
                                  height: size)
        
        rewindButton.frame = CGRect(x: 100,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        fastButton.frame = CGRect(x: viewHolder.frame.size.width - size - 100,
                                  y: yPosition,
                                  width: size,
                                  height: size)

        
        
        // Действия кнопок
        playPauseButton.addTarget(self, action: #selector(didTapPlayPauseButton), for: .touchUpInside)
        previousButton.addTarget(self, action: #selector(didTapPreviousButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        rewindButton.addTarget(self, action: #selector(didTapRewindButton), for: .touchUpInside)
        fastButton.addTarget(self, action: #selector(didTapFastButton), for: .touchUpInside)
                
        // Стили кнопок
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        previousButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        rewindButton.setBackgroundImage(UIImage(systemName: "gobackward.15"), for: .normal)
        fastButton.setBackgroundImage(UIImage(systemName: "goforward.15"), for: .normal)

        playPauseButton.tintColor = .systemPink
        previousButton.tintColor = .systemPink
        nextButton.tintColor = .systemPink
        rewindButton.tintColor = .systemPink
        fastButton.tintColor = .systemPink

        viewHolder.addSubview(playPauseButton)
        viewHolder.addSubview(previousButton)
        viewHolder.addSubview(nextButton)
        viewHolder.addSubview(rewindButton)
        viewHolder.addSubview(fastButton)
        
        
        // Слайдер
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: viewHolder.frame.size.height-60,
                                            width: viewHolder.frame.size.width-40,
                                            height: 50))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlider(_:)), for: .valueChanged)
        viewHolder.addSubview(slider)
    }
    
    // Предыдущий трек
    @objc func didTapPreviousButton() {
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in viewHolder.subviews {
                subview.removeFromSuperview()
            }
            main()
        }
    }

    // Следующий трек
    @objc func didTapNextButton() {
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in viewHolder.subviews {
                subview.removeFromSuperview()
            }
            main()
        }
    }
    
    //
    @objc func didTapRewindButton() {
        var time: TimeInterval = player!.currentTime
        time -= 15.0
        print(time)
        
        if time >= 15 {
            player?.currentTime = time
        }
        
        
    }
    
    //
    @objc func didTapFastButton() {
        var time: TimeInterval = player!.currentTime
        time += 15.0
        print(time)
        
        if time <= player!.duration - 15{
            player?.currentTime = time
        }

    }
    
    
    
    // Пауза или продолжить
    @objc func didTapPlayPauseButton() {
        if player?.isPlaying == true {

            player?.pause()
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    // Перемещение слайдера
    @objc func didSlider(_ slider: UISlider) {
        let value = slider.value
        player?.volume = value
    }

    // Закрытие окна трека
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
}
