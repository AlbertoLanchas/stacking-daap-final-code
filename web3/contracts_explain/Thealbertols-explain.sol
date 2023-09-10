// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Thealbertols {
    string public name = "@albertols"; // Nombre del token
    string public symbol = "ALS";      // Símbolo del token
    string public standard = "albertols v.0.1"; // Estándar del token
    uint256 public totalSupply;         // Suministro total del token
    address public ownerOfContract;     // Dirección del propietario del contrato
    uint256 public _userId;             // Identificador de usuario

    uint256 constant initialSupply = 1000000 * (10**18); // Suministro inicial del token

    address[] public holderToken; // Almacena las direcciones de los titulares de tokens

    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    // Mapping que almacena información de los titulares de tokens
    mapping(address => TokenHolderInfo) public tokenHolderInfos;

    // Estructura para almacenar información de los titulares de tokens
    struct TokenHolderInfo {
        uint256 _tokenId;
        address _from;
        address _to;
        uint256 _totalToken;
        bool _tokenHolder;
    }

    // Mapping que almacena los saldos de las direcciones
    mapping(address => uint256) public balanceOf;

    // Mapping que almacena las aprobaciones para gastar tokens
    mapping(address => mapping(address => uint256)) public allowance;

    constructor() {
        ownerOfContract = msg.sender;
        balanceOf[msg.sender] = initialSupply;
        totalSupply = initialSupply;
    }

    function inc() internal {
        _userId++;
    }

    /**
     * @notice Transfiere tokens de la dirección de mensaje (remisero) a otra dirección.
     * @param _to La dirección de destino a la que se transfieren los tokens.
     * @param _value La cantidad de tokens a transferir.
     * @return success Devuelve true si la transferencia fue exitosa.
     */
    function transfer(address _to, uint256 _value)
        public
        returns (bool success)
    {
        require(balanceOf[msg.sender] >= _value, "Balance insuficiente"); // Verifica que el remitente tenga suficientes tokens
        inc();

        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;

        TokenHolderInfo storage tokenHolderInfo = tokenHolderInfos[_to];

        tokenHolderInfo._to = _to;
        tokenHolderInfo._from = msg.sender;
        tokenHolderInfo._totalToken = _value;
        tokenHolderInfo._tokenHolder = true;
        tokenHolderInfo._tokenId = _userId;

        holderToken.push(_to); // Agrega la dirección del titular a la lista

        emit Transfer(msg.sender, _to, _value); // Emite un evento de transferencia

        return true;
    }

    /**
     * @notice Permite a un tercero (spender) gastar una cantidad específica de tokens en nombre del propietario.
     * @param _spender La dirección del tercero que está autorizado para gastar tokens.
     * @param _value La cantidad de tokens que se autoriza a gastar.
     * @return success Devuelve true si la aprobación fue exitosa.
     */
    function approve(address _spender, uint256 _value)
        public
        returns (bool success)
    {
        allowance[msg.sender][_spender] = _value;

        emit Approval(msg.sender, _spender, _value); // Emite un evento de aprobación

        return true;
    }

    /**
     * @notice Transfiere tokens de una dirección a otra con aprobación previa.
     * @param _from La dirección desde la que se transfieren los tokens.
     * @param _to La dirección de destino a la que se transfieren los tokens.
     * @param _value La cantidad de tokens a transferir.
     * @return success Devuelve true si la transferencia fue exitosa.
     */
    function transferFrom(
        address _from,
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(_value <= balanceOf[_from], "Balance insuficiente"); // Verifica que el remitente tenga suficientes tokens
        require(_value <= allowance[_from][msg.sender], "Aprobacion insuficiente"); // Verifica la aprobación

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;

        allowance[_from][msg.sender] -= _value;

        emit Transfer(_from, _to, _value); // Emite un evento de transferencia

        return true;
    }

    /**
     * @notice Obtiene información detallada de un titular de tokens específico.
     * @param _address La dirección del titular de tokens.
     * @return tokenId, to, from, totalToken, tokenHolder Detalles del titular de tokens.
     */
    function getTokenHolderData(address _address)
        public
        view
        returns (
            uint256,
            address,
            address,
            uint256,
            bool
        )
    {
        return (
            tokenHolderInfos[_address]._tokenId,
            tokenHolderInfos[_address]._to,
            tokenHolderInfos[_address]._from,
            tokenHolderInfos[_address]._totalToken,
            tokenHolderInfos[_address]._tokenHolder
        );
    }

    /**
     * @notice Obtiene una lista de todas las direcciones de los titulares de tokens.
     * @return Una lista de direcciones de titulares de tokens.
     */
    function getTokenHolder() public view returns (address[] memory) {
        return holderToken; // Devuelve la lista de titulares de tokens
    }
}
