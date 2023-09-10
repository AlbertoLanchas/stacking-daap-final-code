// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

//IMPORTING CONTRACT
import "./Address.sol";

/**
 * @title Contrato abstracto Initializable
 * @dev Este contrato abstracto proporciona funcionalidad para inicializar contratos y gestionar su estado de inicialización.
 */
abstract contract Initializable {
    
    /**
     * @dev Variable privada que almacena el estado de inicialización.
     */
    uint8 private _initialized;

    /**
     * @dev Variable privada que indica si la inicialización está en curso.
     */
    bool private _initializing;

    /**
     * @dev Evento que se emite cuando un contrato es inicializado.
     * @param version La versión de inicialización del contrato.
     */
    event Initialized(uint8 version);

    /**
     * @notice Modificador que garantiza que un contrato solo se inicialice una vez.
     */
    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            (isTopLevelCall && _initialized < 1) || (!Address.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    /**
     * @notice Modificador que permite reinicializar un contrato con una nueva versión.
     * @param version La nueva versión de inicialización del contrato.
     */
    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized < version, "Initializable: el contrato ya esta inicializado");
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized(version);
    }

    /**
     * @notice Modificador que garantiza que un contrato esté en proceso de inicialización.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: el contrato no esta en proceso de inicializacion");
        _;
    }

    /**
     * @dev Función interna que deshabilita la inicialización de contratos.
     */
    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: el contrato esta en proceso de inicializacion");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
            emit Initialized(type(uint8).max);
        }
    }
}
