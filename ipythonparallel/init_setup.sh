#!/bin/bash

######
# installing anaconda requriements
######
while true; do
    read -p "Do you want to check anaconda requirements?? [yes, no] " yn
    if [ "$yn" == "yes" ]; then
    	echo "trying to activate anaconda..."
    	export PATH=$HOME/anaconda/bin:$PATH
    	read -p "What is the name of your anaconda env:? [eg: python2.7]" ana_env;
    	echo "trying to bring up anacond";
		source activate $ana_env;
		echo "trying to install anaconda rquirements"
		conda install --file requirements.txt
		break;
	fi
    if [ "$yn" == "no" ]; then
    	break;
	else
		echo "Please answer yes or no.";
	fi
done

#####
# Setup ipython parallel
#####
if [ ! -d "$HOME/.ipython" ]; then
	echo "Creating profile $HOME/.ipython/.profile_slurm for your parallel cluster";
	ipython profile create --parallel --profile=slurm;
	# enable ipcluster extension in ipython
	ipcluster nbextension enable
	echo "Done";
	echo "Consider copying the ipcontroller-engine.json from there to your master machine to connect jupyter etc.";
fi

#####
# jupyter notebook setup
# http://jupyter-notebook.readthedocs.org/en/latest/public_server.html
###
nb_config_file=$HOME/.jupyter/jupyter_notebook_config.py;
while true; do
	if [ ! -d "$HOME/.jupyter" ]; then
		echo "jupyter conf dir not found setting up...";
		jupyter notebook --generate-config;
		echo "Generating ssl keys";
		keyfile=$HOME/.jupyter/notebook.key;
		certfile=$HOME/.jupyter/notebookcert.pem;
		openssl req -x509 -nodes -days 365 -newkey rsa:1024 -keyout "${keyfile}" -out "${certfile}";
		echo "linking your key in the ./jupyter/jupyert_notebebook.conf";
		echo "Attention! Keep the keyfile private!!";
		sed -i "s|^.*c.NotebookApp.keyfile.*|c.NotebookApp.keyfile = u'$keyfile'|g" $nb_config_file;
		grep -n "c.NotebookApp.keyfile" $nb_config_file;
		echo "Done";
		echo "linking your certificate";
		sed -i "s|^.*c.NotebookApp.certfile.*|c.NotebookApp.certfile = '${certfile}'|g" $nb_config_file;
		grep -n "c.NotebookApp.certfile" $nb_config_file;
		echo "Done";
		break;
	else
		read -p "Found existing $HOME/.jupyter. Do you want to delete it? [yes|no] " yn;
		if [ "$yn" == "yes" ]; then
    		echo "trying to delete..."
    		rm -rf $HOME/.jupyter
			echo "Done"
		fi
	fi
    if [ "$yn" == "no" ]; then
    	break;
	else
		echo "Please answer yes or no.";
	fi
done


#setting up password

while true; do
    read -p "Do you want to secure your notebook server with a password? [yes, no] " yn
    if [ "$yn" == "yes" ]; then
			pw=$(python -c"from notebook.auth import passwd; pw = passwd(); print (pw)");
			# write password to file
			# replace the line:
			# c.NotebookApp.password
			sed -i "s|.*c.NotebookApp.password.*|c.NotebookApp.password = u'${pw}'|g" $nb_config_file
			grep "c.NotebookApp.password" $nb_config_file
		break;
	fi
    if [ "$yn" == "no" ]; then
    	break;
	else
		echo "Please answer yes or no.";
	fi
done

# setting up Working dir
while true; do
    read -p "Do you want to set a standart working dir [yes|no]? " yn
    if [ "$yn" == "yes" ]; then
			read -p 'Enter directory: ' dir
			if [ -d $dir ]; then
				sed -i "s|.*c.NotebookApp.notebook_dir.*|c.NotebookApp.notebook_dir = u'${dir}'|g" $nb_config_file
				grep "c.NotebookApp.notebook_dir" $nb_config_file
				break;
			else
				echo "Dir not found! $dir"
			fi
	fi
    if [ "$yn" == "no" ]; then
        echo "Please answer yes or no.";
    	exit;
	fi
done

# setting up remote access

while true; do
    read -p "Do you want to allow remote access to the notebook? Sensful if you are running it on a server. [yes|no]? " yn
    if [ "$yn" == "yes" ]; then
				sed -i "s|.*c.NotebookApp.ip.*|c.NotebookApp.ip = u'*'|g" $nb_config_file;
				grep "c.NotebookApp.ip" $nb_config_file;
				break;
			else
		        echo "Please answer yes or no.";
			fi
    if [ "$yn" == "no" ]; then
    	exit;
	fi
done

echo "Done!"
echo "Remember to use anaconda if you used it for setup"
echo "Run on slurm: sbatch -t 180 -o $HOME/notebook.log -c2 --mem=20GB -J Notebook --wrap=\"jupyter notebook --no-browser\""