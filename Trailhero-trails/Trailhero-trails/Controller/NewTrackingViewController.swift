import UIKit
import CoreLocation
import MapKit
import CoreData

class NewTrackingViewController: UIViewController {

    var seconds = 1
    var timer: Timer?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // Coredata Context Layer
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    
    // MARK: - IBActions
    
    @IBAction func startPressed(_ sender: UIButton) {
        startTracking()
        print("start pressed!")
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        
        print("stop pressed!2")
        
        let alertController = UIAlertController(title: "End run?",
                                                message: "Do you wish to end your run?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
          self.stopTracking()
          self.saveTracking()
          //self.performSegue(withIdentifier: .details, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
          self.stopTracking()
          _ = self.navigationController?.popToRootViewController(animated: true)
        })

        present(alertController, animated: true)
        
    }
    

    // MARK: - Functions
    
    func startTracking() {
        seconds = 0
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            _ in self.eachSecond()
        }
        updateView()
//        stopButton.isHidden = true
    }
    
    func stopTracking() {
       
        timer?.invalidate()
        updateView()
        print("Tracking stopped.Invalidate")
        //startButton.isHidden = false
        // locationManager.stopUpdatingLocation()
    }
    
    func eachSecond() {
        seconds += 1
        updateView()
    }
    
    func eachSecondStop() {
        seconds = 0
        updateView()
    }
    
    func updateView() {
        let formattedTime = FormatDisplay.time(seconds)
        
        timeLabel.text = "Time: \(formattedTime)"
        
    }
    
    func saveTracking() {
        
        do {
           try context.save()
        } catch {
           print("Error saving context \(error)")
        }
        
        // self.tableView.reloadData()
        
        print("Tracking saved to CoreData.")
    }
    


}

