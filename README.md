README for STM8S
================

#### Creating a New Project

1. Create a new folder under STM8 - Use python script.py

``python script.py``

``Are you sure you want to create a folder with the name: project05-wattsjake? (y/n): y``

2. Create a new workspace in ST Visual Develop:  "Create workspace and project" >> OK
   * Copy the name of the folder in step 1 into the "Project name" field.

![alt text][workspace]

![alt text][new-workspace-name]

3. Create a new Project filename. (This should be more specific to what you will be programming.)
    * Select the project location under 'src' folder.
    * Toolchain: ST Assembler Linker
    * Leave toolchain root as default.

![alt text][new-project]

4. Select the MCU you will be programming.

![alt text][mcu-selection]

[workspace]: docs/screenshots/workspace.png
[mcu-selection]: docs/screenshots/mcu-selection.png
[new-workspace-name]: docs/screenshots/new-workspace-name.png
[new-project]: docs/screenshots/new-project.png
