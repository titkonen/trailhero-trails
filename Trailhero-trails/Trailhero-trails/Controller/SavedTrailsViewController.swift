import UIKit
import CoreData

class SavedTrailsViewController: UITableViewController {

    var trails = [Trails]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext // Context Layer
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadTrails()
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the number of rows
        return trails.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SavedTrailsCell", for: indexPath)

        cell.textLabel?.text = trails[indexPath.row].title

        return cell
    }
 

    // MARK: - Add New text
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
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
    
    // MARK: - CRUD Functions
    
    func saveTrails() {
         
         do {
            try context.save()
         } catch {
            print("Error saving context \(error)")
         }
         tableView.reloadData()
    }
    
    func loadTrails() {
        
        let request : NSFetchRequest<Trails> = Trails.fetchRequest()
        
        do {
            trails = try context.fetch(request)
        } catch {
            print("Error Fetching data from context \(error)")
        }
        tableView.reloadData()
    }

    

   
}
