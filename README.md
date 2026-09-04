# PageArc.ConversionRuntime

[中文](README.md) · [English](README.en.md) · [日本語](README.ja.md)

PageArc.ConversionRuntime 是 [PageArc](https://github.com/KiYouJyo/PageArc) 的可选电子书转换运行时仓库。

从 PageArc v1.4 起，体积较大的 calibre 转换运行时不再打入基础阅读器安装包。只有在用户首次使用格式转换，或打开需要兼容转换层的书本时，PageArc 才会从本仓库的固定 Release 按需下载运行时。

## 当前运行时

- calibre：`9.13.0`
- PageArc 运行时包：`9.13.0-pagearc.1`
- 平台：Windows x64
- 归档：`PageArc.ConversionRuntime-win-x64.zip`
- SHA-256：`1d223227254d6dfacc8f5645caf3cba26434e129cf5bb65decb0a121a61b5322`

## Release 契约

每个运行时 Release 同时发布：

- `PageArc.ConversionRuntime-win-x64.zip`
- `runtime-manifest.json`
- `SHA256SUMS.txt`
- 对应版本的 calibre 源码归档
- 第三方许可证与来源说明

PageArc 主程序固定 Release 版本、归档大小和 SHA-256，在下载完成并验证通过后才会把运行时安装到用户本地目录。

## 仓库边界

本仓库不包含 PageArc UI、书库或阅读数据逻辑，只负责转换运行时的打包、版本元数据、完整性校验、许可证材料和 Release 自动化。

calibre 及其依赖保持各自的版权和 GPLv3 等许可证；本仓库的 MIT License 仅覆盖本仓库自行编写的脚本、元数据和文档。
