// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;



abstract contract Context {
  // Esta función devuelve la dirección del remitente del mensaje actual. En otras palabras, te dice quién está llamando a la función o quién ha enviado la transacción al contrato. Esta información es útil para determinar quién está interactuando con el contrato y, por ejemplo, para aplicar lógica de autorización basada en el remitente.

    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
// :Esta función devuelve los datos del mensaje actual como un array de bytes (bytes calldata). Los datos del mensaje incluyen cualquier información que se haya pasado como argumentos a la función en la transacción. Esto es útil si deseas analizar y procesar los datos que se envían al contrato, como parámetros para una función.
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}