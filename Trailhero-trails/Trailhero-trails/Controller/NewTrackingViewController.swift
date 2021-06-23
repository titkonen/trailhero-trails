import UIKit
import CoreLocation
import MapKit

class NewTrackingViewController: UIViewController {

    var seconds = 1
    var timer: Timer?
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBAction func startPressed(_ sender: UIButton) {
        startTracking()
        print("start pressed!")
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        
        print("stop pressed!")
        
//        let alertController = UIAlertController(title: "End run?",
//                                                message: "Do you wish to end your run?",
//                                                preferredStyle: .actionSheet)
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
//          self.stopTracking()
//          self.saveTracking()
//          //self.performSegue(withIdentifier: .details, sender: nil)
//        })
//        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
//          self.stopTracking()
//          _ = self.navigationController?.popToRootViewController(animated: true)
//        })
//
//        present(alertController, animated: true)
        
    }
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func startTracking() {
        seconds = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            _ in self.eachSecond()
        }
        updateView()
    }
    
    func stopTracking() {
//        startButton.isHidden = false
//        stopButton.isHidden = true
        
        // locationManager.stopUpdatingLocation()
    }
    
    func eachSecond() {
        seconds += 1
        updateView()
        
    }
    
    func updateView() {
        let formattedTime = FormatDisplay.time(seconds)
        
        timeLabel.text = "Time: \(formattedTime)"
        
    }
    
//    func saveTracking() {
//        print("Tracking saved.")
//    }
    


}

