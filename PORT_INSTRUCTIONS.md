# FreeBSD Port for Temporal CLI

This repository contains the FreeBSD port files for Temporal CLI, a command-line interface for the Temporal workflow engine.

## Quick Start

### Prerequisites
- FreeBSD system with ports tree installed
- Go 1.21 or later
- Internet connection for downloading dependencies

### Installation Steps

1. **Clone this repository:**
   ```bash
   git clone https://github.com/seunets/temporal-cli-freebsd-port.git
   cd temporal-cli-freebsd-port
   ```

2. **Copy port files to FreeBSD ports tree:**
   ```bash
   sudo mkdir -p /usr/ports/devel/temporal-cli
   sudo cp Makefile pkg-descr pkg-plist distinfo /usr/ports/devel/temporal-cli/
   ```

3. **Generate checksums:**
   ```bash
   cd /usr/ports/devel/temporal-cli
   sudo make makesum
   ```

4. **Test the port:**
   ```bash
   make configure
   make build
   make stage
   ```

5. **Install the port:**
   ```bash
   sudo make install clean
   ```

## Usage

After installation, the `temporal` command will be available:

```bash
# Start Temporal server in development mode
temporal server start-dev

# In another terminal, interact with Temporal
temporal namespace list
temporal workflow list

# See all available commands
temporal --help
```

## Port Details

- **Port Category:** devel
- **Upstream:** https://github.com/temporalio/cli
- **License:** MIT
- **Go Version:** 1.21+
- **Build System:** Go modules

## Files Included

- `Makefile` - FreeBSD port Makefile with build instructions
- `pkg-descr` - Package description for the port
- `pkg-plist` - List of files installed by the port  
- `distinfo` - Checksums and file sizes (updated by `make makesum`)

## Troubleshooting

### Common Issues

1. **Missing Go:** Install with `pkg install go121`
2. **Permission errors:** Use `sudo` for port operations
3. **Network issues:** Check firewall settings for Go module downloads
4. **Build failures:** Check `/var/log/messages` for detailed errors

### Getting Help

- FreeBSD Porter's Handbook: https://docs.freebsd.org/en/books/porters-handbook/
- Temporal Documentation: https://docs.temporal.io/cli
- Issues: https://github.com/seunets/temporal-cli-freebsd-port/issues

## Contributing

1. Fork this repository
2. Make your changes
3. Test the port thoroughly
4. Submit a pull request

## Submitting to FreeBSD Ports

Once tested and stable, this port can be submitted to the FreeBSD ports collection:

1. Create a PR against FreeBSD ports tree
2. Follow FreeBSD ports submission guidelines
3. Address feedback from port committers

## Maintainer

**Alexander Pereira Girald**  
Email: alexander.girald@icloud.com  
GitHub: @seunets

## License

This FreeBSD port follows the same MIT license as the upstream Temporal CLI project.