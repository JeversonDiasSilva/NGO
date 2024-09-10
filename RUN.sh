#!/bin/bash
#Curitiba 10 de Setembro de 2024
#Editor Jeverson Dias da Silva 
#Youtube/@JCGAMESCLASSICOS


# Cria diretório de trabalho.
cd /userdata/roms
wget https://raw.githubusercontent.com/JeversonDiasSilva/NGO/main/kof
unsquashfs kof
mv "squashfs-root" "kof-jc"
rm kof
mkdir -p "/userdata/system/.dev/scripts/@JCGAMESCLASSICOS"
cd "/userdata/system/.dev/scripts/@JCGAMESCLASSICOS" || { echo "Falha ao mudar para o diretório de trabalho."; exit 1; }

# Definir o URL raw dos arquivos
URL="https://raw.githubusercontent.com/JeversonDiasSilva/NGO/main/NEOGEO-REMAPS"
URLES="https://raw.githubusercontent.com/JeversonDiasSilva/NGO/main/es_systems_kof.cfg"

# Baixar o arquivo NEOGEO-REMAPS usando curl
curl -L "$URL" -o NEOGEO-REMAPS
if [ $? -ne 0 ]; then
    echo "Falha ao baixar o arquivo NEOGEO-REMAPS."
    exit 1
fi

# Verificar se o arquivo foi baixado e tem tamanho maior que zero
if [ ! -s NEOGEO-REMAPS ]; then
    echo "Arquivo NEOGEO-REMAPS não encontrado ou está vazio."
    exit 1
fi

# Descompactar o arquivo usando unsquashfs
unsquashfs NEOGEO-REMAPS
if [ $? -ne 0 ]; then
    echo "Falha ao descompactar o arquivo NEOGEO-REMAPS."
    exit 1
fi

# Remover o arquivo NEOGEO-REMAPS após descompactar
rm NEOGEO-REMAPS

# Criar link simbólico
ln -s "/userdata/system/.dev/scripts/@JCGAMESCLASSICOS/BATOCERA REMAPS/NGO" /usr/bin/NGO
batocera-save-overlay
# Baixar o arquivo es_systems_kof.cfg usando curl
cd '/userdata/system/configs/emulationstation' || { echo "Falha ao mudar para o diretório de configuração do emulationstation."; exit 1; }
curl -L "$URLES" -o es_systems_kof.cfg
if [ $? -ne 0 ]; then
    echo "Falha ao baixar o arquivo es_systems_kof.cfg."
    exit 1
fi

# Voltar para o diretório de trabalho
cd "/userdata/system/.dev/scripts/@JCGAMESCLASSICOS" || { echo "Falha ao voltar para o diretório de trabalho."; exit 1; }

# Verificar se o diretório foi criado
if [ ! -d "squashfs-root" ]; then
    echo "Diretório squashfs-root não encontrado."
    exit 1
fi

# Renomear o diretório descompactado
mv squashfs-root "BATOCERA REMAPS"

# Navegar para o diretório renomeado
cd "BATOCERA REMAPS" || { echo "Falha ao entrar no diretório BATOCERA REMAPS."; exit 1; }

# Verificar se o arquivo NGO está presente e é executável
if [ ! -x "./NGO" ]; then
    echo "Arquivo NGO não encontrado ou não é executável."
    exit 1
fi

# Executar o arquivo NGO
./NGO
