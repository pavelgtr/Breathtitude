import SwiftUI
import AVFoundation

struct PlayerView: View {
    let meditation: String
    @State private var isPlaying = false
    @State private var player: AVAudioPlayer?

    var body: some View {
        VStack {
            Text(meditation)
                .font(.headline)
                .padding()
            
            HStack {
                Button(action: rewind) {
                    Image(systemName: "gobackward.30")
                        .font(.system(size: 30))
                }
                
                Button(action: playPause) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .font(.system(size: 75))
                }
                
                Button(action: forward) {
                    Image(systemName: "goforward.30")
                        .font(.system(size: 30))
                }
            }
        }
        .onAppear {
            setupPlayer()
        }
    }
    
    private func setupPlayer() {
        // Check if the meditation file exists in the bundle
        if let url = Bundle.main.url(forResource: meditation, withExtension: "mp3") {
            print("Audio file found at \(url)")
            
            do {
                // Configure AVAudioSession
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                print("AVAudioSession configured successfully")

                // Initialize the AVAudioPlayer
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                print("AVAudioPlayer initialized successfully")
            } catch {
                // Log any errors during player initialization
                print("Error initializing player: \(error)")
            }
        } else {
            // Log if the audio file is not found
            print("Audio file not found")
        }
    }

    private func playPause() {
        guard let player = player else { return }
        
        if player.isPlaying {
            player.pause()
        } else {
            print("play button works!")
            player.play()
        }
        isPlaying.toggle()
    }

    private func rewind() {
        guard let player = player else { return }
        
        player.currentTime = max(player.currentTime - 30, 0)
    }

    private func forward() {
        guard let player = player else { return }
        
        player.currentTime = min(player.currentTime + 30, player.duration)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(meditation: "Wim Hof Breathing")
    }
}
