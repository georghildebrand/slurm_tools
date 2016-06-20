#Short intro to ipython parallel and jupyter notebook

Disclaimer. Tested for python2.x, 3.x tbd ....

These script will help you building up an ipython parallel cluster on top of the SLURM controller together with basic configuration of jupyter notebook.
In general all these infos can be found in the web but i was so far missing a more or less complete walkthrough for ipython parallel + SLURM. Feel free to make suggestion or to contribute ...


##Requirements
Its assumed that you have anaconda or similar installed. You can find more information about that here: https://docs.continuum.io/anaconda/install

     Note: The init script is designed to work for anaconda and that anaconda is in your $HOME/anaconda

##Setup
To setup try running the init script

    ./init_setup.sh

Walk through the setup - it will:

1. first try to activate your conda environment
2. search your .jupyter / .ipythonparalle confs and in case create them
3. Setup a ipythonparallel config for you by creating a profile called "slurm"
3.1 the profile is usually stored under **$HOME/.ipython/<profile_name>**
4. help you configure ssl and a password for your notebook server


##Run an jupyter notebook.

Run something like:

    sbatch -o $HOME/notebook.log -c2 --mem=20GB -J Notebook --wrap="jupyter notebook --no-browser"
    # writing a logfile to your homefolder
    # have a look at sbatch --usage for the commands i use here

from your cluster master on slurm or just:

    jupyter notebook --no-browser
If you are on a local machine.


#Connect to ipythionparallel from jupyter
More info can be found by googling or eg here:
https://rcc.fsu.edu/docs/parallel-ipython-programming-hpc-and-spear



## Start the ipyparalle controller and engins
The important thing is the to mention that its all about the files in your ipython profile folder:

    ls -lah $HOME/.ipython/profile_slurm


Especially important are the files **$HOME/.ipython/profile_slurm/security/*.json** which are
used by ipythonparallel to konfigure engines and controller where to find each other!
Note: if you have no shared storage on your cluster machines it might be required to copy this profile files to all the machines.

Also important: Dont use the ipythonparallel cluster "tab" in the notebook. It will overwrite /delete possibly your profile information while trying to conncet to a cluster. Better is to use the following procedure

###Start the controller

    sbatch run_master.sh

Have a look at the sbatch-script to see all the commands
look at the output file (referenced in the run_master.sh) to learn more about what the script does.

###Start the ipython parallel engines

Lookup the hostname / ip of the controller eg. via squeue -u <username>
(--> the hostname of the run_master.sh script)

    sbatch run_engines.sh <hostname /ip of controller>

Double check the sbatch parameters in the file to adapt to your HPC cluster needs

##Try to use your engines for some parallel work.
Have a look at the Example 1.ipynb

#Links:
http://ipyparallel.readthedocs.org/
http://jupyter-notebook.readthedocs.org/
