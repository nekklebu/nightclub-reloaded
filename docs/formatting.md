# Code Style & Formatters

This project leans on a few trusted formatters to keep the codebase clean and readable. I'm not particularly picky about formatting (so long as it's not egregious).

_...But if I can have it taken care of without having to think about it, I will c:_

## Tools in Use

### Python

\>\>\>\>**`black`**: Auto-formats all Python code

### Shell

\>\>\>\>**`shfmt`**: Formats shell scripts for readability and alignment

### Docker

\>\>\>\>**`dockfmt`**: Formats Dockerfiles and Compose files

## My Workflow

Everything is integrated directly into Vim.

On save, the appropriate formatter runs for the filetype:

- Python files are formatted with `black`
- Shell scripts go through `shfmt`
- Dockerfiles pass through `dockfmt`

No manual CLI steps unless I'm outside Vim or batch-formatting.

> Doesn't anyone believe in a little bit of magic anymore,\,\,
