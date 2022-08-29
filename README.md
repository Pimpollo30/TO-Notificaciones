# [TO]Notificaciones
Este repositorio es un recurso de mi proyecto **Theft Operation** en *Multi Theft Auto: San Andreas*, el cual consiste en un sistema de notificaciones que permite mostrar información al jugador proporcionada por otros recursos.

El sistema contiene cuatro tipos de notificaciones
* **sendMessage**. Permite mostrar un mensaje en la parte inferior de la pantalla
* **utilmsg**. Permite mostrar un mensaje en la parte izquierda de la pantalla
* **trashDo**. Permite mostrar un mensaje en la parte derecha de la pantalla
* **trashLast**. Permite mostrar un mensaje en la parte superior de la pantalla

### sendMessage
![mta-screen_2022-08-29_01-24-13](https://user-images.githubusercontent.com/70590661/187136801-3f1b3ea9-8f17-4687-be3b-444e933095b6.png)

### utilmsg
![mta-screen_2022-08-29_01-24-22](https://user-images.githubusercontent.com/70590661/187136839-5979f472-e488-4b17-8a98-1a8154ca6db6.png)

### trashDo
![mta-screen_2022-08-29_01-24-54](https://user-images.githubusercontent.com/70590661/187136852-522bc463-693b-4a37-9b51-c8a82228b021.png)

### trashLast
![mta-screen_2022-08-29_01-25-05](https://user-images.githubusercontent.com/70590661/187136872-75118551-1b9f-4e8e-a3ba-7d19f0c67cd0.png)


### Sintaxis (client)
* exports["resourceName"]:typeNotification(message, r, g, b, sound)

  * **resourceName**. Se refiere al nombre del recurso (*Procura que el nombre sea [TO]Notificaciones*)
  * **typeNotification**. Se refiere al tipo de notificación. Solo hay cuatro opciones disponibles mencionadas anteriormente: *sendMessage*, *utilmsg*, *trashDo* y *trashLast*.  
  * **message**. El mensaje a mostrar en la pantalla (string)
  * **r**, **g**, **b**. Sistema de composición de colores RGB (Red, Green, Blue). El valor de estos tres parámetros definirán el color del texto del mensaje (int, int, int)
  * **sound**. Es valor numérico que permite reproducir un sonido nativo del juego al momento de mostrar el mensaje mediante la función playSoundFronEnd. Si deseas aprender más sobre esto, te recomiendo leer este artículo de la wiki de Multi Theft Auto: *https://wiki.multitheftauto.com/wiki/PlaySoundFrontEnd*
  
### Ejemplos (client)
Suponiendo que deseamos mandar el texto 'Hola GitHub!' en color blanco, en los cuatro tipos de notificaciones y digirido al jugador de manera local:
* exports["[TO]Notificaciones"]:sendMessage("Hola GitHub!", 255, 255, 255, 11)  
* exports["[TO]Notificaciones"]:utilmsg("Hola GitHub!", 255, 255, 255, 11)  
* exports["[TO]Notificaciones"]:trashDo("Hola GitHub!", 255, 255,255, 11)  
* exports["[TO]Notificaciones"]:trashLast("Hola GitHub!", 255, 255, 255, 11)  

### Sintaxis (server)
* exports["resourceName"]:typeNotification(message, player, r, g, b, sound)

  * **resourceName**. Se refiere al nombre del recurso (*Procura que el nombre sea [TO]Notificaciones*)
  * **typeNotification**. Se refiere al tipo de notificación. Solo hay cuatro opciones disponibles mencionadas anteriormente: *sendMessage*, *utilmsg*, *trashDo* y *trashLast*.  
  * **message**. El mensaje a mostrar en la pantalla (string)
  * **player**. Se refiere al jugador (objeto) al que se le mostrará el mensaje. Si deseas aprender más sobre esto, te recomiendo leer este artículo de la wiki de Multi Theft Auto: *https://wiki.multitheftauto.com/wiki/Element/Player*
  * **r**, **g**, **b**. Sistema de composición de colores RGB (Red, Green, Blue). El valor de estos tres parámetros definirán el color del texto del mensaje (int, int, int)
  * **sound**. Es valor numérico que permite reproducir un sonido nativo del juego al momento de mostrar el mensaje mediante la función playSoundFronEnd. Si deseas aprender más sobre esto, te recomiendo leer este artículo de la wiki de Multi Theft Auto: *https://wiki.multitheftauto.com/wiki/PlaySoundFrontEnd*

### Ejemplos (server)
Suponiendo que deseamos mandar el texto 'Hola GitHub!' en color blanco, en los cuatro tipos de notificaciones y digirido a todos los jugadores del servidor:
* exports["[TO]Notificaciones"]:sendMessage("Hola GitHub!", root, 255, 255, 255, 11)  
* exports["[TO]Notificaciones"]:utilmsg("Hola GitHub!", root, 255, 255, 255, 11)  
* exports["[TO]Notificaciones"]:trashDo("Hola GitHub!", root, 255, 255, 255, 11)  
* exports["[TO]Notificaciones"]:trashLast("Hola GitHub!", root, 255, 255, 255, 11)  
