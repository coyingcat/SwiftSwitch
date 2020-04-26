


## 博客[解决 TableView 上的控件 UISlider 的手势冲突](https://zhuanlan.zhihu.com/p/136416804)


<hr>


# SwiftSwitch， 我做了一些 DIY ，与简化


copied from gontovnik/DGRunkeeperSwitch



# SwiftSwitch , RunkeeperSwitch
design switch control (two part segment control) developed in Swift 5.0

![Preview 1](https://raw.githubusercontent.com/gontovnik/DGRunkeeperSwitch/master/DGRunkeeperSwitch.png)
![Preview 2](https://raw.githubusercontent.com/gontovnik/DGRunkeeperSwitch/master/DGRunkeeperSwitch.gif)


## Demo

Open and run the DGRunkeeperSwitchExample project in Xcode to see Switch in action.

## Installation

### Manual

All you need to do is drop DGRunkeeperSwitch.swift file into your project



## Example usage
### Using DGRunkeeperSwitch as a titleView
``` swift
let runkeeperSwitch = DGRunkeeperSwitch(titles: ["Feed", "Leaderboard"])
runkeeperSwitch.backgroundColor = UIColor(red: 229.0/255.0, green: 163.0/255.0, blue: 48.0/255.0, alpha: 1.0)
runkeeperSwitch.selectedBackgroundColor = .white
runkeeperSwitch.titleColor = .white
runkeeperSwitch.selectedTitleColor = UIColor(red: 255.0/255.0, green: 196.0/255.0, blue: 92.0/255.0, alpha: 1.0)
runkeeperSwitch.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
runkeeperSwitch.frame = CGRect(x: 30.0, y: 40.0, width: 200.0, height: 30.0)
runkeeperSwitch.addTarget(self, action: #selector(ViewController.switchValueDidChange(sender:)), for: .valueChanged)
navigationItem.titleView = runkeeperSwitch
```

### Using as a stand alone control
``` swift
let runkeeperSwitch2 = DGRunkeeperSwitch()
runkeeperSwitch2.titles = ["Daily", "Weekly", "Monthly", "Yearly"]
runkeeperSwitch2.backgroundColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
runkeeperSwitch2.selectedBackgroundColor = .white
runkeeperSwitch2.titleColor = .white
runkeeperSwitch2.selectedTitleColor = UIColor(red: 239.0/255.0, green: 95.0/255.0, blue: 49.0/255.0, alpha: 1.0)
runkeeperSwitch2.titleFont = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
runkeeperSwitch2.frame = CGRect(x: 50.0, y: 20.0, width: view.bounds.width - 100.0, height: 30.0)
runkeeperSwitch2.autoresizingMask = [.flexibleWidth] // This is needed if you want the control to resize
view.addSubview(runkeeperSwitch2)
```



<hr>


Thanks 

@gontovnik/DGRunkeeperSwitch

@https://github.com/gontovnik/DGRunkeeperSwitch/pull/48/files