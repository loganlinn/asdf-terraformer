<div align="center">

# asdf-terraformer ![Build](https://github.com/loganlinn/asdf-terraformer/workflows/Build/badge.svg) ![Lint](https://github.com/loganlinn/asdf-terraformer/workflows/Lint/badge.svg)

[terraformer](https://github.com/GoogleCloudPlatform/terraformer) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Why?](#why)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add terraformer
# or
asdf plugin add terraformer https://github.com/loganlinn/asdf-terraformer.git
```

terraformer:

```shell
# Show all installable versions
asdf list-all terraformer

# Install specific version
asdf install terraformer latest

# Set a version globally (on your ~/.tool-versions file)
asdf global terraformer latest

# Now terraformer commands are available
terraformer --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/loganlinn/asdf-terraformer/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Logan Linn](https://github.com/loganlinn/)
