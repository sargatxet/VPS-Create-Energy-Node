# Instalación de un nodo de Energy en un servidor VPS

## Configuración del servidor

Lo primero que deberemos hacer es establecer la configuración del servidor. Nos vamos a basar en un servidor GNU/Linux Ubuntu LTS 18.04.

Los pasos a seguir una vez tenemos el servidor en marcha y nos hemos conectado por SSH serán los siguientes:

1. No logaremos como el usuario root:

    ```
    sudo su -
    ```

2. Actualizaremos el servidor. Para ello ejecutaremos los siguientes comandos:

    ```
    apt-get update && apt-get upgrade -f
    ```

3. Crearemos el usuario que correrá el nodo/stake de Energy (no debe ser root):

    - Creamos el usuario

    ```
    adduser nrgstaker
    ```

    Durante el proceso deberemos establecer la contraseña del usuario nuevo. El resto de campos se pueden quedar en blanco.

    - Establecemos sus permisos

    ```
    usermod -aG sudo nrgstaker
    ```

4. Configuramos el usuario nuevo para que corra el nodo/stake de Energy:

    - Nos logamos con el usuario nuevo

    ```
    su - nrgstaker
    ```

    - Añadimos al fichero .bashrc las variables necesarias

    ```
    cd $HOME
    echo "export PATH=$PATH:$HOME/energi3/bin" >> .bashrc
    echo "unset HISTFILE" >> .bashrc
    exit
    ```

    - Nos volvemos a logar con el usuario nuevo

    ```
    su - nrgstaker
    ```

    - Eliminamos el fichero que conserva el histórico de comandos

    ```
    cd $HOME
    rm .bash_history
    ```

5. Configuramos el nodo de Energy (seguimos logados como el usuario nrgstaker):

    1. Establecemos la gestión de los ficheros de LOG. Para ello creamos un nuevo fichero:

    ```
    sudo nano /etc/logrotate.d/energi3
    ```

    y lo rellenamos con el siguiente contenido

    ```
    /home/nrgstaker/.energicore3/log/*.log {
        su nrgstaker nrgstaker
        rotate 3
        minsize 100M
        copytruncate
        compress
        missingok
    }
    ```

    Guardaremos el fichero pulsando **CTRL+X** pulsando **Y** y **ENTER** a continuación para guardarlo.

    2. Reiniciamos el servidor para activar los cambios:

    ```
    sudo reboot now
    ```

6. Securizamos el servidor estableciendo las reglas necesarias en el firewal (logados con el usuario root):

    ```
    apt-get install ufw -y
    ufw allow ssh/tcp
    ufw limit ssh/tcp
    ufw allow 39797/tcp
    ufw allow 39797/udp
    ufw logging on
    ufw enable
    ```

## Instalación de la aplicación para el nodo de Energy

1. Nos logamos con el usuario nrgstaker

    ```
    su - nrgstaker
    ```

2. Descargamos y extraemos la aplicación del nodo de Energy

    ```
    cd $HOME
    wget https://s3-us-west-2.amazonaws.com/download.energi.software/releases/energi3/3.0.5/energi3-3.0.5-linux-amd64.tgz
    tar xvfz energi3-3.0.5-linux-amd64.tgz
    mv energi3-3.0.5-linux-amd64 energi3
    rm energi3-3.0.5-linux-amd64.tgz
    mkdir -p energi3/js
    ```

3. Comprobamos que la instación ha sido correcta

    ```
    energi3 console
    ```

    Obtendremos una imágen parecida a esta:

    ![Nodo sincronizando](./PruebaInicial.png)

    En este momento el nodo empezará a sincronizar y puede tardar horas (o días). Para parar el proceso escribiremos:

    ```
    exit
    ```

    y pulsaremos **ENTER**

    ![Nodo sincronizando](./PararPruebaInicial.png)
