Mercado Libre Challenge

Resumen

El proyecto se centra en abordar el desafío planteado por Mercado Libre para desarrollar una aplicación utilizando su API. Esta aplicación tiene como objetivo proporcionar a los usuarios una experiencia fluida y eficiente al buscar productos en la plataforma de Mercado Libre.

La aplicación permitirá a los usuarios realizar búsquedas de productos, mostrar los resultados de dichas búsquedas de manera clara y concisa, y permitirles acceder a información detallada sobre los productos encontrados.

A través de la integración de la API de Mercado Libre, los usuarios podrán realizar búsquedas con filtros específicos, visualizar imágenes, precios, descripciones y otras características relevantes de los productos.

Características

Búsqueda de Productos: Los usuarios podrán buscar productos en el catálogo de Mercado Libre utilizando palabras clave.

Visualización de Resultados: Se mostrarán los resultados de las búsquedas de manera clara y organizada, con imágenes representativas, nombres de productos, condiciones de producto y precios.

Interfaz Intuitiva: La aplicación contará con una interfaz de usuario intuitiva y fácil de usar, diseñada siguiendo las mejores prácticas de diseño de aplicaciones móviles.

Integración con API de Mercado Libre: Se aprovecharán las funcionalidades ofrecidas por la API de Mercado Libre para proporcionar una experiencia completa de búsqueda y compra dentro de la aplicación.
Tecnologías Utilizadas

Swift
SwiftUI
Arquitectura

 
El desarrollo de la aplicación sigue el patrón de diseño Modelo-Vista-ViewModel (MVVM), que se organiza en varias carpetas principales:

1. Vistas

Esta carpeta contiene todas las vistas de la aplicación, implementadas utilizando SwiftUI. Las vistas son responsables de la presentación de la interfaz de usuario y la interacción con el usuario.

2. Modelo

En esta carpeta se encuentra el modelo de datos de la aplicación. El modelo consiste en la estructura de datos que se decodificará y utilizará dentro de la aplicación. Esta capa es fundamental para representar la información de los productos obtenida de la API de Mercado Libre.

3. ViewModel

La carpeta ViewModel contiene las clases que actúan como intermediarios entre las vistas y el modelo. Estas clases, implementadas como objetos observables (@Published) y conformes al protocolo ObservableObject, gestionan la lógica de presentación y manipulación de datos. Aquí se manejan las actualizaciones de estado y las interacciones del usuario.

4. Servicios

Dentro de esta carpeta se encuentra la lógica relacionada con la comunicación de red y el manejo de errores con la API de Mercado Libre. Esto incluye una clase con la función requestHttp para realizar solicitudes a la API y un modelo adicional para manejar los errores y decodificar las respuestas que no estén en el rango de 200 a 299.

Componentes Clave

1. Modelo

El modelo de datos de la aplicación se ha diseñado cuidadosamente para mantener una estructura organizada y coherente. Se define una estructura principal que contiene tipos de datos de otras estructuras, lo que permite un proceso y código más organizado y mantenible.

Además, se ha implementado un enum de CodingKeys para abordar la variación en la nomenclatura de las propiedades en la respuesta del JSON. Algunas propiedades pueden estar escritas con guiones bajos (snake case), como "ejemplo_ejemplo", mientras que se prefiere utilizar camel case en Swift. Este enum asegura que estas propiedades se acepten y decodifiquen correctamente, permitiendo mantener la lógica general de la aplicación utilizando camel case.

Esta separación clara entre el modelo y el resto de la aplicación facilita la modularidad y el mantenimiento del código, permitiendo que el modelo evolucione de manera independiente del resto de la lógica de la aplicación.

2. ViewModel

Los ViewModel son componentes clave de la aplicación, actuando como intermediarios entre las vistas y el modelo de datos. Estas clases gestionan la lógica de presentación y manipulación de datos, permitiendo que las vistas se actualicen dinámicamente en respuesta a cambios en el estado de la aplicación. Implementados como objetos observables (@Published) y conformes al protocolo ObservableObject, los ViewModel facilitan la separación de preocupaciones y la reutilización del código.

3. Networking

Para abordar el requerimiento del challenge, que implica una sola petición GET para generar las funcionalidades asignadas, podríamos haber optado por una solución sencilla, pasando directamente la URL a la cual se quiere acceder, la estructura con la que se desea decodificar y el manejo de errores utilizando los métodos estándar de URLSession que nos proporciona Swift, sin necesidad de pasar ningún parámetro adicional.

Sin embargo, en un enfoque más realista y demostrativo, he decidido implementar una función genérica y más compleja. Esta función genérica recibe varios parámetros, incluyendo la estructura que se desea decodificar cuando la respuesta está en el rango de 200 a 299, así como la estructura que se desea decodificar cuando no se encuentra en este rango. Además, acepta parámetros como la URL, el método, los parámetros del cuerpo de ser necesarios y el manejo de errores a través de un completionHandler.

Aunque esta implementación puede parecer más compleja para el requerimiento específico del challenge, el objetivo es demostrar cómo se manejarían múltiples solicitudes a una API en un caso de uso más realista. Con esta función genérica, podemos realizar diferentes pedidos a la API sin necesidad de reescribir varias líneas de código dependiendo de los diferentes parámetros mencionados.

Es importante destacar que, de ser necesario para una aplicación más simple que solo requiere una única solicitud, se podría implementar una función más precisa y específica para ese propósito.

4. Persistencia de Datos

Aunque Swift maneja la gestión de memoria automáticamente mediante el recuento de referencias (ARC), se ha realizado un exhaustivo control de posibles fugas de memoria utilizando el instrumento de "leak" para garantizar la integridad del código en cuanto a la gestión de la memoria.

En caso de encontrar alguna propiedad con posibilidad de tener fugas de memoria, se establecería que dicha propiedad sea de tipo weak, convirtiendo su valor en una relación débil. Esto permitiría que ARC identifique cuando esta propiedad no tiene ningún valor o su contenido es nulo por un tiempo determinado, lo que permitiría que internamente despeje el espacio que esta propiedad está ocupando en la memoria y lo libere para almacenar otros datos relevantes.

Este enfoque asegura que la aplicación se ejecute de manera eficiente y sin problemas relacionados con la gestión de la memoria, lo que contribuye a una experiencia de usuario más estable y fluida.

5. Manejo de Errores


El manejo de errores en la aplicación se aborda de dos maneras distintas: errores para el usuario y errores para el desarrollador.

Errores para el Usuario:

Se ha implementado un enum que abarca los posibles errores que pueden surgir durante el funcionamiento o llamado a la API. Al manejar los errores de esta manera, Swift permite personalizar y presentar mensajes de error agradables para el usuario. Estos mensajes de error se encuentran en una vista separada, la cual accede a la propiedad errorMessage para mostrar el mensaje adecuado según el error. Además, en este apartado, en ocasiones es beneficioso incluir detalles de código junto con la redacción del error para tener claridad sobre la ubicación del error en caso de que sea necesario comunicarse con el soporte técnico. Esto contribuye a una experiencia de usuario más agradable y ayuda a los usuarios a comprender mejor los problemas que puedan surgir.

Errores para el Desarrollador

Para facilitar el seguimiento y la identificación de errores para el desarrollador, se ha implementado la técnica de imprimir mensajes de depuración utilizando print. Esta práctica permite que el desarrollador pueda rastrear y ubicar fácilmente la parte del código donde se produce un error específico. La inclusión de mensajes de depuración ayuda en la identificación rápida y eficiente de problemas durante el desarrollo y la depuración de la aplicación.

Este enfoque integral en el manejo de errores garantiza una experiencia de usuario satisfactoria y proporciona a los desarrolladores las herramientas necesarias para identificar y resolver problemas de manera efectiva durante el desarrollo y la ejecución de la aplicación.

6. Pruebas

Pruebas Unitarias

Las pruebas unitarias se han centrado en probar la comunicación con la API, dado que este es el principal objetivo de la aplicación. Se han creado pruebas para diversos escenarios, incluyendo:

Pruebas de parámetros no válidos, aunque no sea necesario para este caso, se realizó demostrativamente para garantizar la robustez de la aplicación.
Pruebas de URL no válida.
Pruebas de respuesta de petición fuera del rango de 200 a 299.
Pruebas de error de decodificación.
Cada una de estas pruebas se ha manejado de manera independiente para identificar con claridad cualquier error interno que pueda surgir. Se especifica el error concreto esperado y la respuesta que se debería obtener en base al manejo de errores implementado.

Pruebas de Interfaz de Usuario (UI)

Aunque no se haya implementado en esta etapa debido a limitaciones de tiempo, se reconoce la importancia de realizar pruebas de interfaz de usuario (UI). Estas pruebas son fundamentales para garantizar una experiencia de usuario fluida y libre de errores.  Verificar el comportamiento correcto de la interfaz de usuario en diferentes dispositivos y condiciones.

El enfoque en pruebas unitarias y pruebas de UI asegura la calidad y confiabilidad de la aplicación, garantizando que cumple con los estándares de funcionamiento esperados tanto para el comportamiento de la lógica como para la experiencia del usuario.


Conclusión

El desarrollo de esta aplicación ha sido un proceso integral que ha abordado varios aspectos fundamentales del desarrollo de software. Desde la arquitectura hasta las pruebas. 

Se ha adoptado la arquitectura Modelo-Vista-ViewModel (MVVM), lo que ha permitido una clara separación de responsabilidades y una modularidad que facilita el mantenimiento y la escalabilidad del código. La implementación de las carpetas de vistas, modelo, ViewModel y servicios ha proporcionado una estructura organizada y coherente para el proyecto.

El manejo de errores se ha abordado tanto para los usuarios como para los desarrolladores, con mensajes de error personalizados y claros, así como pruebas unitarias.

Las pruebas unitarias y las pruebas de interfaz de usuario (UI) se han realizado con el objetivo de garantizar el correcto funcionamiento de la aplicación y una experiencia de usuario fluida. Aunque las pruebas de UI no se hayan implementado en esta etapa, se reconoce su importancia e implementación.
