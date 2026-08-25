#!/usr/bin/env python3
"""Render each InterfaceMap's element rectangles to a PNG, for layout checking.

Parses the Swift map files rather than duplicating their data, so the preview
always matches what the app will draw. Also reports rectangles that fall
outside the 0...1 design box.
"""
import os
import re
import struct
import sys
import zlib

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

MAP_HEAD_RE = re.compile(
    r'InterfaceMap\(\s*id:\s*"([^"]+)".*?aspect:\s*([\d.]+),\s*elements:\s*\[',
    re.S,
)
EL_RE = re.compile(
    r'MapElement\(\s*"([^"]+)",\s*CGRect\(x:\s*([\d.]+),\s*y:\s*([\d.]+),\s*'
    r'width:\s*([\d.]+),\s*height:\s*([\d.]+)\),\s*"((?:[^"\\]|\\.)*)"'
    r'(?:,\s*role:\s*\.(\w+))?(?:,\s*decorative:\s*(true|false))?',
    re.S,
)

ROLE_COLORS = {
    "surface": (32, 34, 38),
    "control": (90, 95, 104),
    "transport": (176, 232, 76),
    "clip": (243, 212, 46),
    "track": (98, 104, 112),
    "meter": (79, 195, 217),
    "browser": (154, 124, 240),
    "device": (79, 195, 217),
    "midi": (154, 124, 240),
    "audio": (79, 195, 217),
    "danger": (224, 69, 69),
    "highlight": (216, 70, 140),
}


def write_png(path, rows, w, h):
    raw = bytearray()
    for y in range(h):
        raw.append(0)
        for x in range(w):
            raw += bytes(rows[y][x])

    def chunk(tag, data):
        return (struct.pack(">I", len(data)) + tag + data
                + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF))

    png = b"\x89PNG\r\n\x1a\n"
    png += chunk(b"IHDR", struct.pack(">IIBBBBB", w, h, 8, 2, 0, 0, 0))
    png += chunk(b"IDAT", zlib.compress(bytes(raw), 6))
    png += chunk(b"IEND", b"")
    with open(path, "wb") as fh:
        fh.write(png)


def render(map_id, aspect, elements, out_dir, width=880):
    height = int(width / aspect)
    rows = [[(13, 14, 16)] * width for _ in range(height)]
    problems = []

    for el_id, x, y, w, h, label, role, decorative in elements:
        x, y, w, h = float(x), float(y), float(w), float(h)
        if x < -0.001 or y < -0.001 or x + w > 1.001 or y + h > 1.001:
            problems.append(f"  {map_id}/{el_id}: out of bounds "
                            f"(x={x} y={y} w={w} h={h})")
        color = ROLE_COLORS.get(role or "surface", (120, 120, 120))
        x0, y0 = int(x * width), int(y * height)
        x1, y1 = int((x + w) * width), int((y + h) * height)
        for py in range(max(0, y0), min(height, y1)):
            for px in range(max(0, x0), min(width, x1)):
                edge = px - x0 < 2 or x1 - px <= 2 or py - y0 < 2 or y1 - py <= 2
                if edge:
                    rows[py][px] = color
                else:
                    base = rows[py][px]
                    rows[py][px] = tuple(
                        int(b + (c - b) * 0.20) for b, c in zip(base, color)
                    )

    path = os.path.join(out_dir, f"{map_id}.png")
    write_png(path, rows, width, height)
    return path, problems


def main():
    out_dir = sys.argv[1] if len(sys.argv) > 1 else os.path.join(ROOT, "build", "map-previews")
    os.makedirs(out_dir, exist_ok=True)

    all_problems = []
    count = 0
    for name in ("AbletonMaps.swift", "FLMaps.swift"):
        source = open(os.path.join(ROOT, "Sources/DAWLearn/Content", name)).read()
        heads = list(MAP_HEAD_RE.finditer(source))
        for index, head in enumerate(heads):
            map_id, aspect = head.group(1), head.group(2)
            end = heads[index + 1].start() if index + 1 < len(heads) else len(source)
            elements = EL_RE.findall(source[head.end():end])
            path, problems = render(map_id, float(aspect), elements, out_dir)
            all_problems += problems
            count += 1
            print(f"{map_id:22s} {len(elements):3d} elements  →  {path}")

    print(f"\n{count} maps rendered")
    if all_problems:
        print("\nLayout problems:")
        print("\n".join(all_problems))
    else:
        print("All element rectangles are inside the 0...1 design box.")


if __name__ == "__main__":
    main()
