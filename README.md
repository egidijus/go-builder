# What

Docker thing to build go things, this should produce binaries in ./gowork/output_binaries/


# How


## Add your go package repos from github/gitlab
```
vim gowork/input_repos
```

like this:
```
github.com/tianon/gosu
github.com/wrouesnel/p2cli
```


## Build
run 
`make` it will pull and build and ouput everything in `./gowork/`

# Features

* makefiles
* cross compiling where possible to `darwin` `linux` and `windows`
* only need docker to build golang binaries (and you can update the Dockerfile for more dependencies if needed)
