# Manjaro-Utility
This repository contains shell-scripts and other usefull tools i created to help me with my daily life.

- [Bash](#bash)
  - [obsidian-synced](#obsidian-synced)  
  - [virtualcam](#virtualcam)
- [Python](#python)
  - [tui_engine](#tui_engine) 

## Bash

### obsidian-synced
This is a tool that automatically synchronizes my obsidian vaults with a private git repository.
Note, that the tool requires a ssh connection to git in order to function without forcing the user to enter 
a password every minute.

**Usage**
```bash
./obsidian-synced <target-directory>
```
*\<target-directory\>* has to be a git-repository in order for the script to successfully push any changes. 

### virtualcam
This is a script to create a virtual camera with v4l2loopback.
This camera will play back any video.
The video format should be **mp4**.
*Requires v4l2loopback and ffmpeg to be installed.*

**Usage**
```bash
./virtualcam -f <path to video> # start the application
./virtualcam.sh -h              # print help
```

--- 

## Python

### tui_engine
This file contains a short script for displaying menues on your console:
You can give it a title, information and some options and they will be displayed in boxes on your console.

**Usage**\
To use the engine, import the file and 
create an object of type *TuiEngine*:
```python
from tui_engine import TuiEngine
tui_obj = TuiEngine()
```

Call the following code to render your output:
```python
tui_obj.render("Title", 
               {"Information Name": "Information Body", ...}, 
               {"Option Name": function_pointer, ...})
```

Now you can select the next or previous options with:
```python
tui_obj.selection_down()
tui.obj.selection_up()
```

To execute the function at the selected index, use:
```python
tui_obj.execute_selected_item()
```
**Helpful**\
for working with the engine, changing selection with e.g. arrow keys might be a little
difficult to implement.
I recommand a library called *"pynput"*.
This library will read your keyboard input 
on a second thread, so your own application wont be bothered with waiting for the user to press a button.


