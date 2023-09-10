// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Contrato abstracto para prevenir llamadas recursivas maliciosas (reentrancia)
abstract contract ReentrancyGuard {
    
    uint256 private constant _NOT_ENTERED = 1; // Estado de no entrada
    uint256 private constant _ENTERED = 2;     // Estado de entrada

    uint256 private _status; // Variable de estado para rastrear la entrada

    /**
     * @notice Constructor del contrato.
     * @dev Inicializa la variable de estado `_status` en el estado de no entrada `_NOT_ENTERED`.
     */
    constructor() {
        _status = _NOT_ENTERED;
    }

    /**
     * @notice Modificador para proteger funciones contra llamadas recursivas maliciosas.
     * @dev Requiere que el estado actual no sea `_ENTERED`, lo que indica que no hay una entrada en curso.
     * @dev Al entrar en la función, cambia el estado a `_ENTERED`, lo que indica que hay una entrada en curso.
     * @dev Al salir de la función, cambia el estado de nuevo a `_NOT_ENTERED`.
     */
    modifier nonReentrant() {
        require(_status != _ENTERED, "ReentrancyGuard: reentrant call");

        _status = _ENTERED; // Cambia el estado a indicar que hay una entrada en curso

        _; // Ejecuta la lógica de la función

        _status = _NOT_ENTERED; // Cambia el estado de nuevo a indicar que no hay entrada en curso
    }
}
