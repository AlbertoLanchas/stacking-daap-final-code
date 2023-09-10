// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @title Interfaz estándar ERC-20
 * @dev Esta interfaz define el estándar para tokens ERC-20 en Ethereum.
 * Los contratos que implementan esta interfaz deben proporcionar las funciones y eventos especificados aquí.
 */
interface IERC20 {
    
    /**
     * @notice Evento que se emite cuando se realiza una transferencia de tokens.
     * @param from La dirección que envía los tokens.
     * @param to La dirección que recibe los tokens.
     * @param value La cantidad de tokens transferidos.
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @notice Evento que se emite cuando se aprueba a un tercero (spender) para gastar una cierta cantidad de tokens en nombre del propietario.
     * @param owner La dirección del propietario de los tokens.
     * @param spender La dirección del tercero autorizado para gastar los tokens.
     * @param value La cantidad de tokens aprobados para gastar.
     */
    event Approval(address indexed owner, address indexed spender, uint256 value);

    /**
     * @notice Consulta el saldo de tokens de una dirección específica.
     * @param account La dirección para la cual se desea consultar el saldo.
     * @return El saldo de tokens de la dirección especificada.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @notice Transfiere una cantidad específica de tokens a otra dirección.
     * @param to La dirección a la que se transferirán los tokens.
     * @param amount La cantidad de tokens a transferir.
     * @return `true` si la transferencia se realizó con éxito, `false` si falló.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @notice Consulta la cantidad de tokens que un tercero (spender) está autorizado a gastar en nombre del propietario.
     * @param owner La dirección del propietario de los tokens.
     * @param spender La dirección del tercero cuya asignación se desea consultar.
     * @return La cantidad de tokens que el tercero está autorizado a gastar.
     */
    function allowance(address owner, address spender) external view returns (uint256);

    /**
     * @notice Autoriza a un tercero (spender) para gastar una cantidad específica de tokens en nombre del propietario.
     * @param spender La dirección del tercero al que se autoriza.
     * @param amount La cantidad de tokens que se autoriza al tercero para gastar.
     * @return `true` si la aprobación se realizó con éxito, `false` si falló.
     */
    function approve(address spender, uint256 amount) external returns (bool);

    /**
     * @notice Transfiere una cantidad específica de tokens desde una dirección (from) a otra dirección (to),
     * siempre que la cantidad esté dentro de los límites de la aprobación previamente otorgada por el propietario.
     * @param from La dirección desde la que se transferirán los tokens.
     * @param to La dirección a la que se transferirán los tokens.
     * @param amount La cantidad de tokens a transferir.
     * @return `true` si la transferencia se realizó con éxito, `false` si falló.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
