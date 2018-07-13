

import UIKit
import CoreData

class LogInPage: UIViewController {
    var user: [NSManagedObject] = []
    var userArray = NSArray()
    
    @IBOutlet weak var nametxt: UITextField!
    @IBOutlet weak var mblnotxt: UITextField!
   
    func forContext() -> NSManagedObjectContext
    {
        let delegate = UIApplication.shared.delegate as!AppDelegate
        return delegate.persistentContainer.viewContext
    }
    
    func saveData()
    {
        let context = forContext()
        let entity = NSEntityDescription.entity(forEntityName: "Details", in: context)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        
        newUser.setValue(nametxt.text!, forKey: "name")
        newUser.setValue(mblnotxt.text!, forKey: "mobile")
        
        do{
            try context.save()
            user.append(newUser)
           
            
        }catch let error as NSError{
            print("error, \(error)")
        }
    }
    
    func fetchData()
    {
        let contexts = forContext()
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Details")
        do{
            userArray = try contexts.fetch(fetch) as NSArray

            showAlert(withTitleMessageAndAction: "Alert", message: "Added Succesfully!!", action: true)
            
            let newVC : ViewController = self.storyboard?.instantiateViewController(withIdentifier: "firstVC") as! ViewController
            self.present(newVC, animated: true, completion: nil)


        }catch let error as NSError{
            print("error, \(error)")
        }
    }
    func showAlert(withTitleMessageAndAction title:String, message:String , action: Bool){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        if action {
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action : UIAlertAction!) in
                self.navigationController?.popViewController(animated: true)
            }))
        } else{
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func addBttn(_ sender: Any) {
       
     if(nametxt.text == "")
     {showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter the Name", action: false)}
        
    if(mblnotxt.text == "")
     {showAlert(withTitleMessageAndAction: "Alert!", message: "Please enter the Mobile Number", action: false)}
        saveData()
        fetchData()
        
   }
    

}
