#************* PARAMETERS ************
home_project="/home/belharet/Documents/FABM_PROJECT"
build_folder="build/fabm"

path_to_fabm="$home_project/fabm"

hostname="nemo"

#Biogeochemical model

use_institute=true
institute="pisces"
path_to_pisces="$home_project/fabm-pisces" #To add only if use_institute is true

#Compiler
change_compiler=true
compiler="mpif90" #To add only if change_compiler is true

#Path where the compiled code will create fabm library and necessary include files (By default it is : ~/local/fabm/$hostname)
change_compiled_fabm_path=false
path_compiled_fabm="~/local/fabm/$hostname" #To add only if change_compiled_fabm_path is true



#************* SETTING UP  ****************
old_path=`pwd`
config="$path_to_fabm -DFABM_HOST=$hostname"

if [ $use_institute = true ]; then
        config="$config -DFABM_INSTITUTES=$institute -DFABM_PISCES_BASE=$path_to_pisces"
fi

if [ $change_compiler = true ]; then
        config="$config -DCMAKE_Fortran_COMPILER=$compiler"
fi

if [ $change_compiled_fabm_path = true ]; then
        config="$config -DCMAKE_INSTALL_PREFIX=$path_compiled_fabm"
fi

echo $config

#************ BUILDING ************************

mkdir -p $build_folder
cd $build_folder

cmake $config
sudo make install

cd $old_path

