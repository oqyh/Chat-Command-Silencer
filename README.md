# [ANY] Chat Command Silencer (1.0.3)
https://forums.alliedmods.net/showthread.php?t=342531

### Command Silencer ( ! / . ) + Force Lower Case Commands

![alt text](https://github.com/oqyh/Chat-Command-Silencer/blob/main/img/ex.png?raw=true)
![alt text](https://github.com/oqyh/Chat-Command-Silencer/blob/main/img/dot.png?raw=true)
![alt text](https://github.com/oqyh/Chat-Command-Silencer/blob/main/img/slash.png?raw=true)

## .:[ ConVars ]:.
```
// Enable Chat Command Silencer Plugin
// 1= Yes
// 0= No
cmd_slint_enable "1"

//==========================================================================================

// Make Chat Command Silencer For Admins Only
// 1= Yes ( Specific Flags cmd_slint_admin_flag )
// 0= No ( Everyone )
cmd_slint_admin "0"

// if cmd_slint_admin 1 which flags is it
cmd_slint_admin_flag "abcdefghijklmnoz"

// Force After Commands ( ! . / ) UPPERCASE To lowercase
// 1= Yes
// 0= No
cmd_slint_caps "0"

//==========================================================================================

// Silent Command Chat Begin With (!)
// 1= Yes
// 0= No
cmd_slint_exclamation "0"

// Silent Command Chat Begin With (.)
// 1= Yes
// 0= No
cmd_slint_dot "0"

// Silent Command Chat Begin With (/)
// 1= Yes
// 0= No
cmd_slint_slash "0"
```


## .:[ Change Log ]:.
```
(1.0.3)
- Fix Bug
- Added cmd_slint_admin Make Chat Command Silencer For Admins Only
- Added cmd_slint_admin_flag custom flags for cmd_slint_admin
- Added cmd_slint_caps Force UPPERCASE To lowercase after Commands ( ! . / )
- Fix Always lowercase 

(1.0.2)
- Fix Bug
- Added Space Silencer into commands

(1.0.1)
- Fix Bug
- Added Space cmd_slint_space

(1.0.0)
- Initial Release
```


## .:[ Donation ]:.

If this project help you reduce time to develop, you can give me a cup of coffee :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/oQYh)
