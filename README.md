# Metsense_Bulk_Download

This is a script to download, decompress and concatinate the log files generated by the UKCRIC MetSense Wind Sensor.

To run the script simply download the contents of this repository, move to the folder containing the script, run:

```
chmod +x metsence_20Hz_bulk_download.sh
```

and the run the script.

```
./metsence_20Hz_bulk_download.sh
```

You will be asked to provide the access credentials for the MetSense web archive. If you have not been given these please contact Sam Gunner who can provide some.

Due to the the firewall operated by the University of Bristol, files can only be downloaded from within campus or via a VPN.

The files to download are given in:

```
files_to_download.txt
```

There are currenlt 195 files, which when uncompressed are 500MB each... simply remove files from that list file if you do not want them to be included.
