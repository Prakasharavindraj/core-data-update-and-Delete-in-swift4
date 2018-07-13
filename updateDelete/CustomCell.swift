
import UIKit

class CustomCell: UITableViewCell {
    @IBOutlet weak var namelbl: UILabel!
    @IBOutlet weak var mobilelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
