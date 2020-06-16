const axios = require('axios').default;
const moment = require('moment')
const url = 'https://brasil.io/api/dataset/covid19/caso_full/data?state=BA&city=Santo+Amaro';
const dataPattern = 'DD/MM/YYYY';
let mostCurrentData = {};



axios.get(url)
    .then((res) => {
        if (res.status == 200) {
            const result = res.data.results
            let lastData = moment((result[0].date).toString(), "YYYY/MM/DD");
            let newData = lastData.format(dataPattern);

            mostCurrentData = {
                "date": newData,
                "last_confirmed": result[0].last_available_confirmed,
                "new_confirmed": result[0].new_confirmed,
                "last_available_data": result[0].last_available_date,
                "last_available_death_rate": result[0].last_available_death_rate,
                "last_available_death": result[0].last_available_deaths,
            }

            //console.log(`Casos totais em ${result[0].city}, dia ${newData}, equivalem a ${result[0].last_available_confirmed}`)
            result.forEach(item => {
                //console.log(item)
                //console.log(`${item.epidemiological_week},${item.date}, ${item.last_available_confirmed}`)  
            })

            console.log(mostCurrentData)
        }
    })
    .catch((err) => {
        console.log(err);
    })
