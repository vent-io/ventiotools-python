# Repository template for vent.io projects

## Usage

[Follow the official
guide](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-new-repository),
searching for "template".

## Structure

The `infrastructure/` directory contains the basic terraform structure, declaration of
the [`azurerm`
provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs) and
some commonly used variables.

[`lerna.json`](lerna.json) contains only the definition of the packages directory.

To quickly update the repo for your new project, find and replace all occurrences of
`project-template` in [`lerna.json`](lerna.json) as well as
[`package.json`](package.json), then run `npm i` to install dependencies and create the
initial `package-lock.json`.
