import UIKit
import CoreLocation
import MapKit
import CoreData

class NewTrackingViewController: UIViewController {

    var seconds = 1
    var timer: Timer?
    
    
    var trails = [Trails]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // Coredata Context Layer
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    
    // MARK: - IBActions
    
    @IBAction func startPressed(_ sender: UIButton) {
        startTracking()
        print("start pressed!")
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "End tracking?",
                                                message: "Do you wish to end your tracking?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
            
            self.stopTracking()
            //self.saveTracking()
          //self.performSegue(withIdentifier: .details, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
          self.stopTracking()
          _ = self.navigationController?.popToRootViewController(animated: true)
        })

        present(alertController, animated: true)
        
        print("stop pressed!")
        
    }
    
    @IBAction func saveTextPressed(_ sender: UIButton) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New text", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newTrails = Trails(context: self.context)
            newTrails.title = textField.text!

            self.trails.append(newTrails)
            
            self.saveTrails()
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new text"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func saveTimePressed(_ sender: UIButton) {
        
        let newTrails = Trails(context: self.context)
       // newRun.distance = distance.value
        newTrails.duration = Int16(seconds)
        newTrails.timestamp = Date()
        newTrails.title = "New track added"
        
        self.trails.append(newTrails)
        
        self.saveTrails()
        
        //run = newRun
        print("saveTimePressed")
        print(newTrails)
    }
    
    
    

    // MARK: - Functions
    
    func saveTrails() {
         do {
            try context.save()
         } catch {
            print("Error saving context \(error)")
         }
    }
    
    
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
    
//    func saveTracking() {
//
//        do {
//           try context.save()
//        } catch {
//           print("Error saving context \(error)")
//        }
//
//        print("Tracking saved to CoreData.")
//    }
    


}

