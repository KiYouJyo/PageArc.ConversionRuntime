# PageArc.ConversionRuntime

PageArc.ConversionRuntime distributes PageArc's optional ebook conversion runtime separately from the main application.

## Why

PageArc's core reader should remain lightweight. The heavy calibre runtime is therefore not embedded in the base MSIX. It is downloaded only when a feature needs `ebook-convert`.

## Current runtime

- calibre 9.13.0
- package revision: 9.13.0-pagearc.1
- Windows x64
- archive: `PageArc.ConversionRuntime-win-x64.zip`

Each release carries the runtime archive, a machine-readable manifest, SHA-256 checksums, the corresponding calibre source archive, and license notices.
