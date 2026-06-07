# Created by: Alexander Pereira Girald <alexander.girald@icloud.com>

PORTNAME=	temporal-cli
DISTVERSION=	0.14.0
CATEGORIES=	devel
MASTER_SITES=	https://github.com/temporalio/cli/archive/
DISTNAME=	v${DISTVERSION}
DIST_SUBDIR=	${PORTNAME}

MAINTAINER=	alexander.girald@icloud.com
COMMENT=	Command-line interface for Temporal workflow engine
WWW=		https://github.com/temporalio/cli

LICENSE=	MIT
LICENSE_FILE=	${WRKSRC}/LICENSE

USES=		go:1.21,modules
USE_GITHUB=	yes
GH_ACCOUNT=	temporalio
GH_PROJECT=	cli
GH_TAGNAME=	v${DISTVERSION}

GO_MODULE=	github.com/temporalio/cli
GO_BUILDFLAGS=	-ldflags "-s -w -X github.com/temporalio/cli/internal/temporalcli.Version=${DISTVERSION}"
GO_TARGET=	./cmd/temporal

PLIST_FILES=	bin/temporal \\
		man/man1/temporal.1.gz

PORTDOCS=	README.md

OPTIONS_DEFINE=	DOCS

DOCS_PLIST_FILES=	%%DOCSDIR%%/README.md

# Dependencies based on go.mod analysis
GO_MODULE_DEPS= \\
	github.com/BurntSushi/toml@v1.4.0 \\
	github.com/alitto/pond@v1.9.2 \\
	github.com/davecgh/go-spew@v1.1.2-0.20180830191138-d8f796af33cc \\
	github.com/dustin/go-humanize@v1.0.1 \\
	github.com/fatih/color@v1.19.0 \\
	github.com/google/uuid@v1.6.0 \\
	github.com/mattn/go-isatty@v0.0.21 \\
	github.com/nexus-rpc/sdk-go@v0.6.0 \\
	github.com/olekukonko/tablewriter@v0.0.5 \\
	github.com/spf13/cobra@v1.10.2 \\
	github.com/spf13/pflag@v1.0.10 \\
	github.com/stretchr/testify@v1.11.1 \\
	github.com/temporalio/ui-server/v2@v2.49.1 \\
	go.temporal.io/api@v1.62.13 \\
	go.temporal.io/sdk@v1.44.1 \\
	go.temporal.io/sdk/contrib/envconfig@v1.0.0 \\
	go.temporal.io/server@v1.32.0-157.0 \\
	golang.org/x/exp@v0.0.0-20260410095643-746e56fc9e2f \\
	golang.org/x/mod@v0.35.0 \\
	golang.org/x/term@v0.42.0 \\
	golang.org/x/tools@v0.44.0 \\
	google.golang.org/grpc@v1.80.0 \\
	google.golang.org/protobuf@v1.36.11 \\
	gopkg.in/yaml.v3@v3.0.1 \\
	modernc.org/sqlite@v1.51.0

do-build:
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${GO_CMD} generate ./...
	cd ${WRKSRC} && ${SETENV} ${MAKE_ENV} ${GO_CMD} build ${GO_BUILDFLAGS} -o ${GO_WRKDIR_BIN}/temporal ./cmd/temporal

do-install:
	${INSTALL_PROGRAM} ${GO_WRKDIR_BIN}/temporal ${STAGEDIR}${PREFIX}/bin/temporal

do-install-DOCS-on:
	@${MKDIR} ${STAGEDIR}${DOCSDIR}
	${INSTALL_DATA} ${WRKSRC}/README.md ${STAGEDIR}${DOCSDIR}/README.md

post-install:
	# Generate and install man page if available
	@if [ -f ${WRKSRC}/docs/temporal.1 ]; then \\
		${INSTALL_MAN} ${WRKSRC}/docs/temporal.1 ${STAGEDIR}${MAN1PREFIX}/man/man1/temporal.1; \\
	fi

.include <bsd.port.mk>
