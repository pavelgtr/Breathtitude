//PlayerViewController.swift 

import UIKit

import AVFoundation


class PlayerViewController: UIViewController {

    //declare all properties
    
    var player: AVAudioPlayer!

    let myImage = UIImageView()
    let playButton = UIButton(type: .system)
    let rewindButton = UIButton(type: .system)
    let forwardButton = UIButton(type: .system)
    let titleLabel = UILabel()
    let meditateImage = UIImageView()
    var selectedButtonTitle = ""
    var selectedButtonBackgroundColor: UIColor?

    let allButtonsConfiguration = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
    let playButtonConfiguration = UIImage.SymbolConfiguration(pointSize: 75, weight: .bold, scale: .large)

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUIAppearance()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        setupConstraints()
    }

    //MARK: - Setup Subviews

    private func setupSubviews() {
        view.addSubview(myImage)
        myImage.addSubview(playButton)
        myImage.addSubview(rewindButton)
        myImage.addSubview(forwardButton)
        myImage.addSubview(titleLabel)
        myImage.addSubview(meditateImage)

        myImage.isUserInteractionEnabled = true

        meditateImage.image = UIImage(named: "cuteMeditation")
        meditateImage.tintColor = .blue

        titleLabel.textColor = UIColor(hex: 0x2e86de)

        // no auto layout

        myImage.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        rewindButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        meditateImage.translatesAutoresizingMaskIntoConstraints = false

        // adding images and configuration (sizes) to buttons

        playButton.setImage(UIImage(systemName: "playpause.circle.fill", withConfiguration: playButtonConfiguration), for: .normal)
        rewindButton.setImage(UIImage(systemName: "gobackward.30", withConfiguration: allButtonsConfiguration), for: .normal)
        forwardButton.setImage(UIImage(systemName: "goforward.30", withConfiguration: allButtonsConfiguration), for: .normal)

        // addTarget to buttons

        playButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        rewindButton.addTarget(self, action: #selector(rewindButtonPressed), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(fastForwardButtonPressed), for: .touchUpInside)

        titleLabel.text = selectedButtonTitle
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 30)
        titleLabel.adjustsFontSizeToFitWidth = true

        meditateImage.contentMode = .scaleAspectFit
    }

    //MARK: - Setup Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            myImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            myImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myImage.widthAnchor.constraint(equalTo: view.widthAnchor),
            myImage.heightAnchor.constraint(equalTo: view.heightAnchor),

            //titleLabel constrains
            titleLabel.centerYAnchor.constraint(equalTo: myImage.centerYAnchor, constant: -200),
            titleLabel.centerXAnchor.constraint(equalTo: myImage.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalToConstant: 300),
            titleLabel.heightAnchor.constraint(equalToConstant: 300),

            //play button constraints
            playButton.centerYAnchor.constraint(equalTo: myImage.centerYAnchor, constant: 75),
            playButton.centerXAnchor.constraint(equalTo: myImage.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 100),
            playButton.heightAnchor.constraint(equalToConstant: 100),
            
            //rewind button constraints
            rewindButton.centerYAnchor.constraint(equalTo: myImage.centerYAnchor, constant: 75),
            rewindButton.centerXAnchor.constraint(equalTo: myImage.centerXAnchor, constant: -120),
            rewindButton.widthAnchor.constraint(equalToConstant: 100),
            rewindButton.heightAnchor.constraint(equalToConstant: 100),

            //forward button constraints
            forwardButton.centerYAnchor.constraint(equalTo: myImage.centerYAnchor, constant: 75),
            forwardButton.centerXAnchor.constraint(equalTo: myImage.centerXAnchor, constant: 120),
            forwardButton.widthAnchor.constraint(equalToConstant: 100),
            forwardButton.heightAnchor.constraint(equalToConstant: 100),

            //meditateImage button constraints
            meditateImage.centerYAnchor.constraint(equalTo: myImage.centerYAnchor, constant: 275),
            meditateImage.centerXAnchor.constraint(equalTo: myImage.centerXAnchor, constant: -5),
            meditateImage.widthAnchor.constraint(equalToConstant: 80),
            meditateImage.heightAnchor.constraint(equalToConstant: 130),
        ])

        myImage.contentMode = .scaleAspectFill
    }

    //MARK: - Update UI Appearance

    private func updateUIAppearance() {
        updateBackgroundColor()
        updateButtonAndLabelColors()
        updateNavigationBarTintColor()
    }

    private func updateBackgroundColor() {
        if let bgColor = selectedButtonBackgroundColor {
            self.view.backgroundColor = bgColor
        } else {
            self.view.backgroundColor = UIColor(hex: 0x63cdda, alpha: 1)
        }
    }

    private func updateButtonAndLabelColors() {
        var buttonTintColor: UIColor
        var labelTextColor: UIColor

        if let bgColor = selectedButtonBackgroundColor {
            if bgColor == UIColor(hex: 0xA878EC) {
                buttonTintColor = UIColor(hex: 0xFDF4F5)
                labelTextColor = UIColor(hex: 0xFDF4F5)
            } else if bgColor == UIColor(hex: 0x19A7CE) {
                buttonTintColor = UIColor(hex: 0xF5F3C1)
                labelTextColor = UIColor(hex: 0xF5F3C1)
            } else {
                buttonTintColor = .white
                labelTextColor = .white
            }
        } else {
            buttonTintColor = .white
            labelTextColor = .white
        }

        titleLabel.textColor = labelTextColor
        playButton.tintColor = buttonTintColor
        rewindButton.tintColor = buttonTintColor
        forwardButton.tintColor = buttonTintColor
    }

    private func updateNavigationBarTintColor() {
        var navigationTintColor: UIColor

        if let bgColor = selectedButtonBackgroundColor {
            if bgColor == UIColor(hex: 0xA878EC) {
                navigationTintColor = UIColor(hex: 0xFDF4F5)
            } else if bgColor == UIColor(hex: 0x19A7CE) {
                navigationTintColor = UIColor(hex: 0xF5F3C1)
            } else {
                navigationTintColor = .white
            }
        } else {
            navigationTintColor = .white
        }

        navigationController?.navigationBar.tintColor = navigationTintColor
    }

    //MARK: - Play button

    @objc func playSound() {
        let url = Bundle.main.url(forResource: titleLabel.text, withExtension: "mp3")
        if let url = url {
            do {
                if player == nil {
                    // Player hasn't been created yet, create it and start playing
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
                    playButton.setImage(UIImage(systemName: "pause.circle.fill", withConfiguration: playButtonConfiguration), for: .normal)
                } else if player?.isPlaying == true {
                    // Player is playing, pause it
                    player?.pause()
                    playButton.setImage(UIImage(systemName: "playpause.circle.fill", withConfiguration: playButtonConfiguration), for: .normal)
                } else {
                    // Player is paused, resume playing
                    player?.play()
                    playButton.setImage(UIImage(systemName: "pause.circle.fill", withConfiguration: playButtonConfiguration), for: .normal)
                }
            } catch {
                print("Error playing the sound: \(error)")
            }
        }
    }
    
    //MARK: - Rewind button

       @objc func rewindButtonPressed() {
           guard let player = player else { return }

           let currentTime = player.currentTime
           let rewindInterval = TimeInterval(-30)
           let newTime = max(currentTime + rewindInterval, 0)

           player.currentTime = newTime
       }

       //MARK: - Fast Forward button

       @objc func fastForwardButtonPressed() {
           guard let player = player else { return }

           let currentTime = player.currentTime
           let forwardInterval = TimeInterval(30)
           let newTime = min(currentTime + forwardInterval, player.duration)

           player.currentTime = newTime
       }
    // MARK: - Deinit
       deinit {
           player?.stop()
       }
   }


