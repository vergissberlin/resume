#!/usr/bin/env sh

################################################################################
## Variables
################################################################################

PANDOC_IMAGE="${PANDOC_IMAGE:-ghcr.io/vergissberlin/pandoc-eisvogel-de}"

################################################################################
## Environment specific replacements commands
################################################################################

if [ $CI ]; then
	sedcmd="sed -i"
else
	sedcmd="sed -i ''"
fi

################################################################################
## Docker helpers
################################################################################

# Print --platform for ARM hosts (image is amd64-only). Override with DOCKER_PLATFORM.
docker_platform_args() {
	if [ -n "${DOCKER_PLATFORM:-}" ]; then
		printf '%s' "--platform ${DOCKER_PLATFORM}"
		return
	fi
	case "$(uname -m)" in
		arm64|aarch64) printf '%s' "--platform linux/amd64" ;;
	esac
}

# Run pandoc inside the project Docker image. Optional first arg: -i
docker_pandoc_run() {
	run_opts=""
	if [ "${1:-}" = "-i" ]; then
		run_opts="-i"
		shift
	fi
	# shellcheck disable=SC2046
	docker run ${run_opts} $(docker_platform_args) -v "$PWD:/data" "$PANDOC_IMAGE" "$@"
}

# Pull image with correct platform on ARM hosts.
docker_pandoc_pull() {
	# shellcheck disable=SC2046
	docker pull $(docker_platform_args) "$PANDOC_IMAGE"
}

# Fail early with a helpful hint when the container cannot execute.
verify_docker_pandoc() {
	if docker_pandoc_run pandoc --version >/dev/null 2>&1; then
		return 0
	fi

	save_err=$(docker save "$PANDOC_IMAGE" -o /dev/null 2>&1) || true
	if printf '%s' "$save_err" | grep -q "integrity checksum failed"; then
		echo "🚨\tLocal Docker cache for ${PANDOC_IMAGE} is corrupted."
		echo "    Run: just docker-repair"
		echo "    If that fails (OrbStack): OrbStack → Settings → Reset Docker data"
		exit 1
	fi

	empty_pandoc=$(docker_pandoc_run sh -c 'wc -c < /usr/local/bin/pandoc' 2>/dev/null) || empty_pandoc=0
	if [ "${empty_pandoc:-0}" = "0" ]; then
		echo "🚨\tPandoc binary in ${PANDOC_IMAGE} is missing or empty locally."
		echo "    Run: just docker-repair"
		exit 1
	fi

	echo "🚨\tCannot run ${PANDOC_IMAGE} in Docker."
	case "$(uname -m)" in
		arm64|aarch64)
			if docker info 2>/dev/null | grep -qi orbstack; then
				echo "    OrbStack: ensure amd64 emulation works (linux/amd64 alpine test)."
				echo "    Try: just docker-repair"
			else
				echo "    Docker Desktop → Settings → General →"
				echo "    \"Use Rosetta for x86_64/amd64 emulation on Apple Silicon\""
				echo "    Then: just docker-pull"
			fi
			;;
	esac
	exit 1
}

################################################################################
## REPLACERS
################################################################################

# Add "\pagebreak" before each heading 1
addPageBreaks() {
    echo $(cat)
    $sedcmd 's/^# /\\pagebreak\\n\\n# /g' $1
}
