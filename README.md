# PageArc.ConversionRuntime

[中文](README.md) · [English](README.en.md) · [日本語](README.ja.md)

PageArc.ConversionRuntime is the optional conversion runtime distribution repository for [PageArc](https://github.com/KiYouJyo/PageArc).

It packages the pinned calibre `ebook-convert` runtime separately from the PageArc application so the base reader stays small. PageArc downloads this runtime only when a conversion-dependent feature is actually requested.

## Runtime line

- calibre: `9.13.0`
- PageArc runtime package: `9.13.0-pagearc.1`
- initial platform: Windows x64
- archive: `PageArc.ConversionRuntime-win-x64.zip`

## Distribution contract

Every runtime release publishes:

- `PageArc.ConversionRuntime-win-x64.zip`
- `runtime-manifest.json`
- `SHA256SUMS.txt`
- corresponding calibre source archive
- GPL / third-party notices

PageArc verifies the archive SHA-256 before installing it into its per-user runtime directory.

## Scope

This repository contains no PageArc UI or reading-state code. It owns only conversion-runtime packaging, verification metadata, licensing material, and release automation.
