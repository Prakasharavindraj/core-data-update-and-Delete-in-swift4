
import UIKit
import CoreData

class ViewController: UIViewController,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var reglist: [NSManagedObject] = []
    
    @IBOutlet weak var TblView: UITableView!
    
    @IBAction func addBtn(_ sender: Any)
    {
        performSegue(withIdentifier: "segue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.TblView.reloadData()
        return 125
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
      
        return reglist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let list = reglist[indexPath.row]  //new
        
        cell.namelbl.text = list.value(forKeyPath: "name") as? String
        cell.mobilelbl.text = list.value(forKeyPath: "mobile") as? String
        self.TblView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.delete   /*for delete*/
        {
            let context = forContext()
            context.delete(reglist[indexPath.row] as NSManagedObject)
            do {
                try context.save()
                tableView.reloadData()
            } catch {
                print(error)
            }
        }
         self.TblView.reloadData()
    }
    
    func forContext() -> NSManagedObjectContext
    {
        let delegate = UIApplication.shared.delegate as!AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    override func viewDidLoad() {
        let contexts = forContext()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Details")
        do{
            reglist = try contexts.fetch(fetch) as! [NSManagedObject]
        }catch let error as NSError{
            print("error, \(error)")
            self.TblView.reloadData()
        }
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

