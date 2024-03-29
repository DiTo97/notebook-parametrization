# <a href="https://github.com/nteract/papermill"><img src="https://media.githubusercontent.com/media/nteract/logos/master/nteract_papermill/exports/images/png/papermill_logo_wide.png" height="48px" /></a>

A cross-platform example of notebook parametrization in the background with papermill.

## setup

```sh
git clone https://github.com/DiTo97/notebook-parametrization.git
cd notebook-parametrization
```

```sh
conda create --name=notebook-parametrization python=3.10
conda activate notebook-parametrization
```

```sh
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

## usage

```sh
.\run_notebook.bat <notebook> <config> [--configdir <configdir>] [--logdir <logdir>] [--background]  # windows
```

```sh
./run_notebook.sh  <notebook> <config> [--configdir <configdir>] [--logdir <logdir>] [--background]  # linux or macOS
```

## example

```sh
.\run_notebook.bat notebook.ipynb norway --background  # windows
```

```sh
./run_notebook.sh  notebook.ipynb UK     --background  # linux or macOS
```
