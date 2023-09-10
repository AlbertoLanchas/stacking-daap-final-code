// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// IMPORTING CONTRACT
import "./Context.sol";

abstract contract Ownable is Context {
  // Esta variable privada almacena la dirección del propietario actual del contrato.
    address private _owner;
    
// Este evento se emite cuando se produce una transferencia de propiedad del contrato.
// event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);: Declara el evento OwnershipTransferred con dos parámetros indexados: previousOwner y newOwner. Los eventos indexados son útiles para realizar búsquedas eficientes en el registro de eventos.
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Constructor que asigna el creador del contrato como propietario inicial.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @notice Modificador que restringe una función solo al propietario del contrato.
     * @dev Requiere que el llamador sea el propietario actual.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @notice Obtiene la dirección del propietario actual del contrato.
     * @return La dirección del propietario.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Verifica si el llamador es el propietario actual del contrato.
     * @dev Requiere que el llamador sea el propietario actual, de lo contrario, revertirá.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @notice Permite al propietario renunciar a su propiedad, estableciendo la dirección del propietario en cero.
     * @dev Solo puede ser llamada por el propietario actual.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @notice Permite al propietario transferir la propiedad del contrato a una nueva dirección.
     * @param newOwner La nueva dirección que se convertirá en propietaria.
     * @dev Requiere que la nueva dirección no sea la dirección cero.
     * @dev Solo puede ser llamada por el propietario actual.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Realiza la transferencia real de propiedad y emite el evento OwnershipTransferred.
     * @param newOwner La nueva dirección que se convertirá en propietaria.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
