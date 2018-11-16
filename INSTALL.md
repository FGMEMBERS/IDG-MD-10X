# INSTALL
## Prerequisites
Have at least following versions installed:
* FlightGear 2018.1.0 or newer

Have a compatible revision of the [IDG-MD-11X](https://github.com/it0uchpods/IDG-MD-11X.git) installed (see "revision-md-11-min.txt")

## Install using ZIP Snapshot
[Download](https://github.com/it0uchpods/IDG-MD-10X/archive/master.zip) the zip file.  
Use your prefered archive utility to unzip the archive.
Move the unpacked directory to your aircraft directory. This can be FGData/Aircraft, or a custom directory you've specified.

Make sure you move the IDG-MD-10X folder into the same location as the IDG-MD-11X, or it will not work properly.

Rename the directory to `IDG-MD-10X`.
Make sure that the `IDG-MD-10X` directory does not contain another one (this can happen with WinRAR). If so, move the inner `IDG-MD-10X` directory outside.

To update, delete the `IDG-MD-10X` directory and install the latest version.

## Install using git
Change to the aircraft directory.
Clone the repository with `git clone https://github.com/it0uchpods/IDG-MD-10X.git`

To update just run `git pull` in the `IDG-MD-10X` directory.
