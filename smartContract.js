var url = "http://rinkeby.caralabs.me:18575";
var provider = new ethers.providers.JsonRpcProvider(url);
var locador = new ethers.Wallet(accounts.personas[0].privatekey, provider);
var locatario = new ethers.Wallet(accounts.personas[1].privatekey, provider);
var contractAddress = '0xc4301d608a0dfde53d9bdb996185bf24d205f4f0';
var contract = new ethers.Contract(contractAddress, abi, provider);
var contractWithSigner = contract.connect(locatario);

function getLocatario() {
    $("#locatario").html("connecting to blockchain...");
    contractWithSigner.getLocatario()
        .then((result) => {
            locatario = result;
            $("#locatario").html("<strong>" + locatario + "</strong>");
        });
}

function getLocador() {
    $("#locador").html("connecting to blockchain...");
    contract.locador()
        .then((result) => {
            locador = result;
            $("#locador").html("<strong>" + locador + "</strong>");
        });
}

function getValorAluguel() {
    $("#_valorAluguel").html("connecting to blockchain...");
    contract.valorAluguel()
        .then((result) => {
            valorAluguel = result;
            $("#valorAluguel").html("<strong>" + valorAluguel + "</strong>");
        });
}

/*reajuste do aluguel*/

function ajusteAluguel(taxa) {
    var taxa = $('$taxa').val();
    $("#ajusteAluguel").html("calculando...");
    contract.ajusteAluguel('Aluguel ajustado')
        .then((tx) => {
            console.log(tx);
            tx.wait()
                .then((result) => {
                    console.log(result);
                    if (result) {
                        aluguelReajustado();
                    }
                });
        });
}
