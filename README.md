## Import Greg's cable map into json and beyond

1. Install a node ( use a node stable, aka 10.x releae )

    curl https://raw.githubusercontent.com/creationix/nvm/v0.7.0/install.sh | sh
    
2. System dependencies

    sudo apt-get install gdal-bin realpath

3. Node.js dependencies

    npm install

4. First convert the shp files into json files

    ./script/import.sh <name of the zipfile>

Imports the contents into `json` as GEOJson files.

The file `bin/generate-sql.js` currently is tested against the `Cables.json` file,
Landing_Stations does not work (yet) due to the hackish conversion to SQL geospatial queries.

_(This is a matter of hacking a bit more)_

To convert `Cables.json` into a set of SQL queries:

    ./bin/generate-sql.js json/Cables.json > cables.sql





