#!/usr/bin/env bash
set -e

BASE_DIR="$HOME/Media"
TARGET=""
URL=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        --target)
            TARGET="$2"
            shift 2
            ;;
        -*)
            echo "Unknown option: $1"
            exit 1
            ;;
        *)
            URL="$1"
            shift
            ;;
    esac
done

if [[ -z "$URL" ]]; then
    echo "Usage: yt-opus.sh [--target Music] <youtube-or-soundcloud-url>"
    exit 1
fi

OUT_DIR="${BASE_DIR}${TARGET:+/$TARGET}"
mkdir -p "$OUT_DIR"

yt-dlp \
    -f bestaudio/best \
    --extract-audio \
    --audio-format best \
    --output "${OUT_DIR}/%(uploader)s - %(title)s.%(ext)s" \
    "$URL"

echo "Downloaded to: $OUT_DIR"

