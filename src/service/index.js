//const $ = document.querySelector.bind(document);
const url = 'https://brasil.io/api/dataset/covid19/caso_full/data?state=BA&city=Santo+Amaro';
let mostCurrentData = {};

window.addEventListener('load', async () => {
    let response =
        await fetch(url).then((res) => {
            res.json().then((data) => {
                let result = data.results
                mostCurrentData = {
                    "date": result[0].date,
                    "last_confirmed": result[0].last_available_confirmed,
                    "new_confirmed": result[0].new_confirmed,
                    "last_available_data": result[0].last_available_date,
                    "last_available_death_rate": result[0].last_available_death_rate,
                    "last_available_death": result[0].last_available_deaths,
                }
                testar(mostCurrentData)
                //testar(data.results)
                //console.log(data.results)
            })
        }).catch((err) => {
            console.log(err);
        })
});


function testar(varTeste){
   console.log(varTeste)
}
