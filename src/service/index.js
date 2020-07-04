const $ = document.querySelector.bind(document);
const url = 'https://brasil.io/api/dataset/covid19/caso_full/data?state=BA&city=';
const Initialurl = 'https://brasil.io/api/dataset/covid19/caso_full/data?state=BA&city=Santo+Amaro';
let mostCurrentData = {};

let covidEvolutionDate1 = [];
let covidEvolutionQtd1 = [];
let covidEvolutionDate2 = [];
let covidEvolutionQtd2 = [];
let clickOnSelect = 0;
//gráfico
let myBarChart;
//props do gráfico
let options;
let date;

const contaminados = document.querySelector("#contaminados-value");
const mortos = document.querySelector("#mortos-value");
const percentual = document.querySelector("#percentual-value");
const data = document.querySelector("#att-value");
var ctx = document.getElementById('myChart').getContext('2d');
const div = document.querySelector('#relatorio');


const select = document.querySelector(".cities");
let city = select.options[select.selectedIndex].value;




window.addEventListener('load', loadInitialResponse);
select.addEventListener('change', changeDataBySelect);

//Carregar os dados unicamente de Santo Amaro
async function loadInitialResponse() {

    await fetch(Initialurl).then((res) => {
        res.json().then((data) => {
            let result = data.results;

            getMostRecenteDataAsJson(result);
            getInitialDataAsArray(result);
        })
    }).catch((err) => {
        console.log(err);
    });

}



async function loadResponse() {

    await fetch(url + city).then((res) => {
        res.json().then((data) => {
            let result = data.results;

            getMostRecenteDataAsJson(result);
            getDataAsArray(result);
        })
    }).catch((err) => {
        console.log(err);
    });

}

function getMostRecenteDataAsJson(result) {
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

//Criar apenas uma vez o gráfico
function getInitialDataAsArray(result) {
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

function getDataAsArray(result) {
    result.forEach(item => {
        let split = item.date.split('-')
        covidEvolutionDate1.push(split[2] + '/' + split[1] + '/' + split[0]);
        covidEvolutionDate2.push(split[2] + '/' + split[1] + '/' + split[0]);
        covidEvolutionQtd1.push(item.last_available_confirmed)
        covidEvolutionQtd2.push(item.last_available_confirmed)
    });

    let reverseQtd = covidEvolutionQtd1.reverse();
    let reverseDate = covidEvolutionDate1.reverse();
    updateData(myBarChart, reverseDate, reverseQtd);
    console.log(myBarChart.data)
    generateRelatoryData(covidEvolutionDate2, covidEvolutionQtd2)
    return result
}




function createGraph(internCovidDatacg, internCovidAmountcg) {
    const reverseQtd = internCovidAmountcg.reverse();
    const reverseDate = internCovidDatacg.reverse();
    console.log(`print 1 ${reverseDate}`);

    date = {
        labels: reverseDate,
        datasets: [{
            label: 'Quantidade de  contaminados:',
            backgroundColor: "rgb(11,72,107)",
            data: reverseQtd,

        }]
    };

    options = {
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

    myBarChart = new Chart(ctx, {
        type: 'bar',
        data: date,
        options: options
    });






}

function generateRelatoryData(internCovidData, internCovidAmount) {
    let content = '<h1>Relatório:</h1>' +
        '<table >' +
        '<tr>' +
        '<th>Data</th>' +
        '<th>Contaminados</th>' +
        '</tr>';

    div.removeChild;

    for (let i = 0; i < internCovidData.length; i++) {
        content += '<tr>' +
            '<td>' + internCovidData[i] + '</td>' +
            '<td>' + internCovidAmount[i] + '</td>' +
            '</tr>'
    }

    content += '</table>';

    div.innerHTML = content;
}



function changeDataBySelect() {
    city = select.options[select.selectedIndex].value;
    countAndBlockSelect();
    mostCurrentData = {};
    covidEvolutionDate1 = [];
    covidEvolutionQtd1 = [];
    covidEvolutionDate2 = [];
    covidEvolutionQtd2 = [];

    loadResponse();
}

// Depois da interrogação precisa chamar
function countAndBlockSelect() {
    clickOnSelect === 6 ? showAlertAndResetClickCount() : clickOnSelect++;
}


function showAlertAndResetClickCount() {
    //Mostrar o alert e bloquear o dialog (nao faço ideia de como fazer isso, mas acredito que um disable deve funcionar)
    clickOnSelect = 0;
}


function updateData(chart, label, data) {
    chart.data.datasets[0].data = data;
    chart.data.labels = label;

    chart.update();

}