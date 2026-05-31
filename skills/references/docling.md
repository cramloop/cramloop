# Docling

Convert study materials (`.docx`, `.pdf`, `.pptx`, `.html`, images, etc.) to Markdown for tutor scoping and quiz preparation. Handles tables, layout, and scanned PDFs (with OCR).

**Docs:** [Docling quickstart](https://docling-project.github.io/docling/getting_started/quickstart/) · [Installation](https://docling-project.github.io/docling/getting_started/installation/) · [CLI reference](https://docling-project.github.io/docling/reference/cli/)

## Install

Use the project venv when one exists:

```bash
python -m venv .venv
source .venv/bin/activate
pip install docling
```

Linux CPU-only (lighter PyTorch):

```bash
pip install docling --extra-index-url https://download.pytorch.org/whl/cpu
```

Verify:

```bash
docling --version
```

First run may download model weights to `~/.cache/docling/models`.

## Basic usage

### CLI

Convert a Word file to Markdown (output written to `--output` directory):

```bash
docling "materials/history/Revision Guide.docx" \
  --from docx \
  --to md \
  --output materials/history/
```

Convert a PDF:

```bash
docling "materials/history/chapter-7.pdf" \
  --from pdf \
  --to md \
  --output materials/history/
```

Export images as separate PNG files (referenced from Markdown):

```bash
docling input.docx \
  --to md \
  --output materials/history/ \
  --image-export-mode referenced
```

Convert a URL:

```bash
docling https://example.com/report.pdf --to md --output ./out
```

All options: `docling --help`

### Python

```python
from docling.document_converter import DocumentConverter

source = "materials/history/Revision Guide.docx"  # path or URL
converter = DocumentConverter()
doc = converter.convert(source).document

markdown = doc.export_to_markdown()
```

Write to file:

```python
from pathlib import Path

Path("materials/history/revision-guide.md").write_text(
    doc.export_to_markdown(), encoding="utf-8"
)
```

## Tutor workflow

When the user supplies binary documents (`.docx`, `.pdf`, `.pptx`, etc.) as quiz source material:

1. You MUST convert to Markdown with **Docling** before Phase 1 scoping or writing questions.
2. You MUST read the generated `.md` (and any referenced images) as the materials source.
3. You MUST keep converted files under `materials/` (or the user's existing materials path) so sources remain traceable in quiz files.
4. You MAY skip conversion when the user already provides `.md` or plain pasted text.

## Supported input formats

Docling accepts many formats via `--from` (defaults to all supported): `docx`, `pdf`, `pptx`, `html`, `image`, `md`, `csv`, `xlsx`, and others. See the [CLI reference](https://docling-project.github.io/docling/reference/cli/).

## When to use Docling

| Use Docling | Skip conversion |
|-------------|-----------------|
| Teacher handouts, revision `.docx`, worksheets, PDF chapters | User pasted text or attached `.md` |
| Scanned PDFs (OCR enabled by default) | Simple one-paragraph answer in chat |
| Tables and structured layout matter | Already-readable Markdown in repo |
