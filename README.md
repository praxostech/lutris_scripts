# lutris_scripts
Collections of self written lutris install scripts

<br>

## Script documentation

<br>

### Spongebob Squarepants: The movie (PC)

This script is **only made and tested for the German retail Version!**   

The script looks for the "setup.exe" on a inserted disc.   
If Lutris does not find your disc, you can select the directory containing the "setup.exe" manually.   
Since the game´s setup is an "Installshield"-setup, I had to generate an "answer file" that the setup can use to obtain the desired settings.   
The script writes my previously generated answer file into the path "C:\setup.iss" in your wine prefix and finally references to it in an argument when running the setup executable.   

If you would like to generate a answer file youself, you can do this with the following command:

``` 
path\to\setup.exe /r
```

#### Overview - files

file | description
-|-
install_sbtmtg.yaml | The actual Lutris-installation-script
setup.iss | The raw Installshield answer file (not needed for the script); <br>just here to provide the raw answer file for those who are interested.