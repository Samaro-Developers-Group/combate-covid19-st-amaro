const $ = document.querySelector.bind(document);
const url = 'https://brasil.io/api/dataset/covid19/caso_full/data?state=BA&city=Santo+Amaro';
let mostCurrentData = {};

let covidEvolutionDate1= [];
let covidEvolutionQtd1 = [];
let covidEvolutionDate2= [];
let covidEvolutionQtd2 = [];


const contaminados = document.querySelector("#contaminados-value");
const mortos = document.querySelector("#mortos-value");
const percentual = document.querySelector("#percentual-value");
const data = document.querySelector("#att-value");
var ctx = document.getElementById('myChart').getContext('2d');
const div = document.querySelector('#relatorio');


window.addEventListener('load', async () => {
    let response =
        await fetch(url).then((res) => {
            res.json().then((data) => {
                let result = data.results

                getMostRecenteDataAsJson(result)
                getDataAsArray(result)
            })
        }).catch((err) => {
            console.log(err);
        })
});


function getMostRecenteDataAsJson(result){
    mostCurrentData = {
        "date": result[0].date,
        "last_confirmed": result[0].last_available_confirmed,
        "new_confirmed": result[0].new_confirmed,
        "last_available_data": result[0].last_available_date,
        "last_available_death_rate": result[0].last_available_death_rate,
        "last_available_death": result[0].last_available_deaths,
    }
    contaminados.innerHTML = mostCurrentData.last_confirmed;
    mortos.innerHTML = mostCurrentData.last_available_death;
    percentual.innerHTML = mostCurrentData.last_available_death_rate + "%";

    let date = mostCurrentData.date.split('-');
    data.innerHTML = date[2] + "/" + date[1] + "/" + date[0];
    console.log(mostCurrentData)
    return mostCurrentData
}

function getDataAsArray(result){
    result.forEach(item => {
        let split = item.date.split('-')
        covidEvolutionDate1.push(split[2] + '/' + split[1] + '/' + split[0]);
        covidEvolutionDate2.push(split[2] + '/' + split[1] + '/' + split[0]);
        covidEvolutionQtd1.push(item.last_available_confirmed)
        covidEvolutionQtd2.push(item.last_available_confirmed)
    });

    createGraph(covidEvolutionDate1, covidEvolutionQtd1)
    generateRelatoryData(covidEvolutionDate2, covidEvolutionQtd2)
    return result
}




function createGraph(internCovidDatacg, internCovidAmountcg){
    const reverseQtd = internCovidAmountcg.reverse();
    const reverseDate = internCovidDatacg.reverse();

    console.log(`print 1 ${reverseDate}`)

    let date ={
        labels: reverseDate,
        datasets: [{
            label: 'Quantidade de  contaminados:',
            backgroundColor: "rgb(11,72,107)",
            data: reverseQtd,
           
        }]
    };
    
    let options = {
        maintainAspectRatio: false,
        scales: {
          yAxes: [{
            stacked: true,
            gridLines: {
              display: true,
              color: "rgb(11,72,107,0.2)"
            }
          }],
          xAxes: [{
            gridLines: {
              display: false
            }
          }]
        }
        
    }
    
    
    let myBarChart = new Chart(ctx, {
        type: 'bar',
        data: date,
        options: options
    });

}

function generateRelatoryData(internCovidData, internCovidAmount){


  let content = '<h1>Relatório:</h1>'
   + '<table >' 
      + '<tr>'
      + '<th>Data</th>'
      + '<th>Contaminados</th>' 
      +'</tr>';

  div.removeChild;

  for(let i =0; i<internCovidData.length; i++) {
      content += '<tr>' 
      +'<td>' + internCovidData[i] + '</td>'
      +'<td>' + internCovidAmount[i] + '</td>'
      + '</tr>'
  }

  content += '</table>';

  div.innerHTML = content;
}





