# AutoMakefile
🚀 Welcome to my AutoMakefile repository!

## About

AutoMakefile is a bash script that automatically creates a Makefile for C projects (especially 42 projects)..

## My Implementation

- **AutoMakefile.sh**: Bash script for create Makefile.
- **config_file**: all is in the name.


## How to Use

1. **Clone Repo**:
   ```powershell
     git clone git@github.com:maxenceguy/AutoMakefile.git
   ```

2. **According Access right**;
    ```powershell
     chmod +x AutoMakefile.sh
    ```
3. **Run**
   After Configuring conig_file (see below), run like this :
    ```powershell
     ./AutoMakefile config_file
    ```

## Configure config_file
  For all the variables, write after ';'.
  - **1st line**: write all .c files, without the folder_name/, even if they are in different folders. (ex: file.c)
  - **PROJECT_DIR**:  go in your project folder and copy your pwd. (ex: /home/name/Document/projet)
  - **SOURCES_DIRS**:  all folders with .c. (ex: ., src/, other2/)
  - **HEADERS_DIR**:  folder with .h files. (ex: ., include/)
  - **LIBS_DIR**:  folder with your library. (ex: ., lib/)
  - **NAME**:  binary name. 
  - **DISPLAY**:  title to display.
  For others variables, you can change them, but they're already there by default.

## Make Arguments
  make followed by :
  - **archive** : archives your actual repo in tar.gz file, in folder backup.
  - **revert** : recreate the project from the last backup.
  - **num** : print the current version number.
  - **delete** : delete last backup.

## Author
  - **Name:** mguy

Feel free to reach out if you have any questions or suggestions!

Happy coding! 🚀
