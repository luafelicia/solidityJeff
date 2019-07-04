pragma solidity 0.5.9;

contract Aluguel {
    
    address payable public locador;
    address locatario;
    uint256 public valorAluguel;
    Imovel public apartamento;
    ReciboPagamento[] public pagamentos;
    mapping (uint => ReciboPagamento) public arquivo;
    
    struct Imovel {
        string cidade;
        uint numeroQuartos;
    }
    
    struct ReciboPagamento {
        uint256 data;
        uint256 valorRecebido;
    }
    
    function pagamentoAluguel() public payable returns (bool) {
        require(msg.sender == locatario, "Pagamento efetuado");
        require(msg.value == valorAluguel, "Valor está correto");
        ReciboPagamento memory recibo = ReciboPagamento(now, msg.value);
        pagamentos.push(recibo);
        locador.transfer(valorAluguel);
        arquivo[pagamentos.length] = recibo; 
        emit pagamentoEfetuado(valorAluguel);
        return true;
    }
    
    event aluguelReajustado (uint valorAluguel);
    event pagamentoEfetuado (uint valorAluguel);
    
    modifier somenteLocador() {
     require(msg.sender == locatario, "Somente o locador pode acessar");
     _;
    }
    
    constructor (address payable _locador, address _locatario, uint256 _valorAluguel) public {
        locador = _locador;
        locatario = _locatario;
        valorAluguel = _valorAluguel;
        apartamento = Imovel("São Paulo", 2);
         
    }
    
    function getLocatario() public somenteLocador view returns (address) {
        return locatario;
    } 
    
    function ajusteAluguel(uint256 igpm) public somenteLocador returns (uint256) {
        valorAluguel = valorAluguel+((valorAluguel*igpm)/100);
        emit aluguelReajustado (valorAluguel);
        return valorAluguel;
        
    }
   
}
