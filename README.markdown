# ubuntu-py3todeb

This is an image that I use to build python3 packages for the `ubuntu:18.04`
docker image. It takes a `requirements.txt`-style input from STDIN and uses
`fpm` to build each package.

Note that the resulting `.deb` files will end up in the `/result` directory
_inside_ the container, so if you actually want these packages you need to
mount a local directory to it.

# Project Status

This is mostly an updated dump from a project I worked on where upgrading
the build stack to use [docker's multi-stage build][docs] would be too
painful. I definitely recommend going for that if you can.

I don't have interest in evolving this into something smarter/fancier
myself, but I'm happy to assist with directions and/or issues in case
you are having trouble using this repository.

[docs]: https://docs.docker.com/develop/develop-images/multistage-build/#use-multi-stage-builds

# Installation

```bash
docker build . -t ubuntu-py3todeb
```

# Examples

## Building a single package

The following command will build a package for pipenv (notice that *no
packages will be built for pipenv's dependencies*) and the resulting
will be found in the current directory:

```bash
echo "pipenv==2018.7.1"| docker run -v $PWD:/result -i ubuntu-py3todeb
```

After a while you should see something like this in the output:

> {:timestamp=>"2018-07-21T12:49:29.324299+0000", :message=>"Created package", :path=>"python-pipenv_2018.7.1_all.deb"}

## Building packages for all dependencies of a pip-enabled project

The previous command is only useful when building self-contained modules
or just updating single package dependencies. Most of the time what
you want is to build a debian package for every single python
dependency in your project so that you can craft a docker image
with a reasonable size.

This command will build a package for each dependency and store them
in the `/tmp` directory:

```bash
pip freeze | docker run -v /tmp:/result -i ubuntu-py3todeb
```
