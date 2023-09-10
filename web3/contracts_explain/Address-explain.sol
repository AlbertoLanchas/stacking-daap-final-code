// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

/**
 * @title Address Library
 * @dev Una biblioteca para realizar operaciones relacionadas con direcciones.
 */
library Address {
   
    /**
     * @notice Verifica si una dirección es un contrato.
     * @param account La dirección a verificar.
     * @return True si la dirección es un contrato, false en caso contrario.
     */
    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    /**
     * @notice Envía Ether a una dirección específica.
     * @param recipient La dirección del destinatario.
     * @param amount La cantidad de Ether a enviar.
     * @dev Requiere que el contrato tenga un saldo suficiente.
     * @dev Requiere que la transferencia sea exitosa; de lo contrario, revertirá con un mensaje de error.
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: saldo insuficiente");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: no se pudo enviar el valor, el destinatario puede haber revertido");
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel a una dirección con datos específicos.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que la llamada de función sea exitosa; de lo contrario, revertirá con un mensaje de error predeterminado.
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: llamada de bajo nivel fallida");
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel a una dirección con datos específicos y un mensaje de error personalizado.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @param errorMessage El mensaje de error personalizado para revertir si la llamada falla.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que la llamada de función sea exitosa; de lo contrario, revertirá con el mensaje de error proporcionado.
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel a una dirección con datos y un valor específico.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @param value El valor en Ether a enviar con la llamada.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que el contrato tenga un saldo suficiente para la llamada de función.
     * @dev Requiere que la dirección de destino sea un contrato.
     * @dev Requiere que la llamada de función sea exitosa; de lo contrario, revertirá con un mensaje de error predeterminado.
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: llamada de bajo nivel con valor fallida");
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel a una dirección con datos, un valor específico y un mensaje de error personalizado.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @param value El valor en Ether a enviar con la llamada.
     * @param errorMessage El mensaje de error personalizado para revertir si la llamada falla.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que el contrato tenga un saldo suficiente para la llamada de función.
     * @dev Requiere que la dirección de destino sea un contrato.
     * @dev Requiere que la llamada de función sea exitosa; de lo contrario, revertirá con el mensaje de error proporcionado.
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: saldo insuficiente para la llamada");
        require(isContract(target), "Address: llamada a no-contrato");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel de solo lectura a una dirección con datos específicos.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que la dirección de destino sea un contrato.
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: llamada de bajo nivel estatica fallida");
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel de solo lectura a una dirección con datos específicos y un mensaje de error personalizado.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @param errorMessage El mensaje de error personalizado para revertir si la llamada falla.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que la dirección de destino sea un contrato.
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: llamada estatica a no-contrato");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel de delegación a una dirección con datos específicos.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que la dirección de destino sea un contrato.
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: llamada de bajo nivel de delegacion fallida");
    }

    /**
     * @notice Realiza una llamada de función de bajo nivel de delegación a una dirección con datos específicos y un mensaje de error personalizado.
     * @param target La dirección de destino.
     * @param data Los datos de la llamada de función.
     * @param errorMessage El mensaje de error personalizado para revertir si la llamada falla.
     * @return Los datos de retorno de la llamada de función.
     * @dev Requiere que la dirección de destino sea un contrato.
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: llamada de delegacion a no-contrato");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @notice Verifica el resultado de una llamada de función y revierte con un mensaje de error si la llamada falló.
     * @param success El resultado de la llamada de función.
     * @param returndata Los datos de retorno de la llamada de función.
     * @param errorMessage El mensaje de error personalizado para revertir si la llamada falla.
     * @return Los datos de retorno de la llamada de función si la llamada fue exitosa.
     * @dev Si la llamada falla, revertirá con el mensaje de error proporcionado o con el mensaje de error de la llamada de función si returndata no está vacío.
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
