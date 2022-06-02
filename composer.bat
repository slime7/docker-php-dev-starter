set PWD=%~dp0
set HOME=%USERPROFILE%
docker run --rm -it -v %PWD%:/app -v %HOME%/.composer:/tmp composer %*