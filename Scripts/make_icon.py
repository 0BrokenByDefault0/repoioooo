#!/usr/bin/env python3
"""Generate the app icon (no third-party deps).

Draws the launch-grid motif used throughout the app: a dark studio panel with a
3x3 clip grid, one column lit as if it were playing.
"""
import struct
import sys
import zlib

SIZE = 1024
BG = (9, 10, 11)
PANEL = (18, 19, 21)
GRID_LINE = (32, 34, 38)
CELLS = {
    (0, 0): (243, 212, 46),   # amber
    (1, 0): (243, 212, 46),
    (2, 0): (243, 212, 46),
    (0, 1): (58, 62, 70),
    (1, 1): (176, 232, 76),   # lime  (playing clip)
    (2, 1): (58, 62, 70),
    (0, 2): (58, 62, 70),
    (1, 2): (58, 62, 70),
    (2, 2): (232, 96, 42),    # orange
}


def blend(dst, src, a):
    return tuple(int(round(d + (s - d) * a)) for d, s in zip(dst, src))


def rounded_alpha(px, py, x0, y0, x1, y1, r):
    """Coverage in 0..1 for a rounded rect, sampled 2x2 for cheap AA."""
    hits = 0.0
    for ox in (0.25, 0.75):
        for oy in (0.25, 0.75):
            x, y = px + ox, py + oy
            if x < x0 or x > x1 or y < y0 or y > y1:
                continue
            cx = min(max(x, x0 + r), x1 - r)
            cy = min(max(y, y0 + r), y1 - r)
            dx, dy = x - cx, y - cy
            if dx * dx + dy * dy <= r * r:
                hits += 0.25
    return hits


def main(path):
    rows = [[BG] * SIZE for _ in range(SIZE)]

    # Outer panel.
    pad = 96
    for y in range(SIZE):
        for x in range(SIZE):
            a = rounded_alpha(x, y, pad, pad, SIZE - pad, SIZE - pad, 120)
            if a:
                rows[y][x] = blend(rows[y][x], PANEL, a)

    # Grid of clip slots.
    inner = 176
    span = SIZE - inner * 2
    gap = 34
    cell = (span - gap * 2) / 3.0
    for (col, row_i), color in CELLS.items():
        x0 = inner + col * (cell + gap)
        y0 = inner + row_i * (cell + gap)
        x1, y1 = x0 + cell, y0 + cell
        for y in range(int(y0) - 2, int(y1) + 3):
            if not (0 <= y < SIZE):
                continue
            for x in range(int(x0) - 2, int(x1) + 3):
                if not (0 <= x < SIZE):
                    continue
                a = rounded_alpha(x, y, x0, y0, x1, y1, 26)
                if a:
                    rows[y][x] = blend(rows[y][x], color, a)

    # Hairline under the grid, like a transport strip.
    bar_y0, bar_y1 = SIZE - inner + 26, SIZE - inner + 40
    for y in range(int(bar_y0), int(bar_y1)):
        for x in range(inner, SIZE - inner):
            rows[y][x] = blend(rows[y][x], GRID_LINE, 1.0)

    raw = bytearray()
    for row in rows:
        raw.append(0)
        for r, g, b in row:
            raw += bytes((r, g, b))

    def chunk(tag, data):
        return (struct.pack(">I", len(data)) + tag + data
                + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF))

    png = b"\x89PNG\r\n\x1a\n"
    png += chunk(b"IHDR", struct.pack(">IIBBBBB", SIZE, SIZE, 8, 2, 0, 0, 0))
    png += chunk(b"IDAT", zlib.compress(bytes(raw), 9))
    png += chunk(b"IEND", b"")
    with open(path, "wb") as fh:
        fh.write(png)
    print("wrote", path, len(png), "bytes")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "icon-1024.png")
