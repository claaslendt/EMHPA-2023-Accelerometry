# Additional info

We used the [Axivity](https://axivity.com/) AX3/AX6 sensors with a sampling rate of 100Hz and a range of +/- 8g to sample the data. The sensors were placed midway between the hip and knee on the lateral side of the knee (either side) and attached directly to the skin.

The original data (.cwa-files) was downloaded from the sensors and processed using [OmGui software](https://github.com/digitalinteraction/openmovement/wiki/AX3-GUI). We used the integrated SVM-Calculator with an epoch length of 5 seconds, no filtering and truncating all negative values to zero. The processed data was exported in .csv format.

The R code will read the .csv files, filter out the respective time windows and do some basic data visualization and descriptive analysis.

NB: The names of the participants have been replaced with respective pseudonyms.
