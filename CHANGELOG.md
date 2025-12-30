# Changelog

## [3.2.0](https://github.com/Vtxdeo/vtx-protocol/compare/v3.1.0...v3.2.0) (2025-12-30)


### Features

* **wit:** add ffmpeg interface for media transcoding ([d0e62d7](https://github.com/Vtxdeo/vtx-protocol/commit/d0e62d7623356fb497abb8a870b906612971eb57))


### Bug Fixes

* **wit:** correct ffmpeg return type to use buffer resource ([a24c46a](https://github.com/Vtxdeo/vtx-protocol/commit/a24c46ad51fc62c80dbff578576a13f3bccce912))

## [3.1.0](https://github.com/Vtxdeo/vtx-protocol/compare/v3.0.0...v3.1.0) (2025-12-30)


### Features

* initialize go protocol package ([44d591b](https://github.com/Vtxdeo/vtx-protocol/commit/44d591b9ce1e52ee55e0979b3330a224b2c060fe))
* initialize java protocol package ([2212573](https://github.com/Vtxdeo/vtx-protocol/commit/221257347aa69863cb71f1b81bf777861de54bdc))

## [3.0.0](https://github.com/Vtxdeo/vtx-protocol/compare/v2.2.1...v3.0.0) (2025-12-30)


### ⚠ BREAKING CHANGES

* The `vtx-protocol` packages no longer provide the `vtx-protocol` CLI tool or generated bindings.
    * Build Logic: Migrated to `vtx-cli`.
    * Runtime Bindings: Migrated to language-specific `vtx-sdk`.
    * The Rust crate now only exposes `WIT_CONTENT` and path helpers.

### Code Refactoring

* purge build logic and transition to pure schema registry ([4dc3876](https://github.com/Vtxdeo/vtx-protocol/commit/4dc3876d2d067cea0cb7ce67a0932c19f813a6c4))

## [2.2.1](https://github.com/Vtxdeo/vtx-protocol/compare/v2.2.0...v2.2.1) (2025-12-30)


### Bug Fixes

* **rust:** correct relative path resolution for internal bindgen ([ada9b46](https://github.com/Vtxdeo/vtx-protocol/commit/ada9b46166a062f58c0dae01cb4bed159cbeb353))
* **rust:** correct relative path resolution for internal bindgen ([1c0c8d8](https://github.com/Vtxdeo/vtx-protocol/commit/1c0c8d899bd9fd9ef772029add392c22a0de34d3))
* **rust:** make export macro and bindings module public ([3826218](https://github.com/Vtxdeo/vtx-protocol/commit/3826218c49a9f57f1595243c563a4e831decd9bf))

## [2.2.0](https://github.com/Vtxdeo/vtx-protocol/compare/v2.1.0...v2.2.0) (2025-12-30)


### Features

* make protocol package self-contained as an SDK (Protocol as Capability) ([ee8ae47](https://github.com/Vtxdeo/vtx-protocol/commit/ee8ae47f6cd6cdea027d0fb1f2c7a971f9b92b37))

## [2.1.0](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.6...v2.1.0) (2025-12-29)


### Features

* upgrade protocol packages to auto-generating SDKs ([2652849](https://github.com/Vtxdeo/vtx-protocol/commit/265284930dcc138efefdbe097339912c21c8bbd4))
* upgrade protocol packages to auto-generating SDKs ([1c6df19](https://github.com/Vtxdeo/vtx-protocol/commit/1c6df19692f3ac5a22398eccdd6db44e088780c5))


### Bug Fixes

* **ci:** add missing dependencies for sdk generation ([70b552b](https://github.com/Vtxdeo/vtx-protocol/commit/70b552bc3afef35dd9a22bd305c96b566d45b56f))
* migrate binding generation to componentize-py ([5dcf04f](https://github.com/Vtxdeo/vtx-protocol/commit/5dcf04f57b1f9c13bc0ce7b5161541e4d595f1e8))

## [2.0.6](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.5...v2.0.6) (2025-12-29)


### Bug Fixes

* .github/workflows/release.yml ([298d8fa](https://github.com/Vtxdeo/vtx-protocol/commit/298d8fa4ea1751f2f0eae3c16d411cb6f515c197))

## [2.0.5](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.4...v2.0.5) (2025-12-29)


### Bug Fixes

* README.md ([f23d463](https://github.com/Vtxdeo/vtx-protocol/commit/f23d46307c84747fabf0da4151b40f49f01ee788))

## [2.0.4](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.3...v2.0.4) (2025-12-29)


### Bug Fixes

* .github/workflows/release.yml ([95a57bf](https://github.com/Vtxdeo/vtx-protocol/commit/95a57bf0436fd1af14bad924afeabf0f19ac63c1))

## [2.0.3](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.2...v2.0.3) (2025-12-29)


### Bug Fixes

* release-please.yml ([1e04262](https://github.com/Vtxdeo/vtx-protocol/commit/1e04262c0e90505cb77efe59f0243dcd0996f383))
* release-please.yml ([69077a1](https://github.com/Vtxdeo/vtx-protocol/commit/69077a1b433c992217c092477bab53064d7fcbbb))

## [2.0.2](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.1...v2.0.2) (2025-12-29)


### Bug Fixes

* README.md ([07cb2e2](https://github.com/Vtxdeo/vtx-protocol/commit/07cb2e2fbdb1c49fd95794ff5553bfe66a809fe0))
* README.md ([d547dc0](https://github.com/Vtxdeo/vtx-protocol/commit/d547dc0512e2187c0339fc35797e7adbfc286436))

## [2.0.1](https://github.com/Vtxdeo/vtx-protocol/compare/v2.0.0...v2.0.1) (2025-12-29)


### Bug Fixes

* Makefile ([e054df3](https://github.com/Vtxdeo/vtx-protocol/commit/e054df338ceebbbe27153112f27f1ee1e69b861c))
* restore corrupted package.json and switch release-type to node ([bbffb0a](https://github.com/Vtxdeo/vtx-protocol/commit/bbffb0ab413f40d296ecf80b34b8fad7722a74b4))

## [2.0.0](https://github.com/Vtxdeo/vtx-protocol/compare/v1.2.6...v2.0.0) (2025-12-29)


### ⚠ BREAKING CHANGES

* The production release branch has been formally designated as `master`. All production-bound pull requests must now target this branch.
* The legacy manual release process has been deprecated. All future version updates must be performed by merging Release Please–generated pull requests.

### Features

* initialize multi-language protocol distribution infrastructure ([e09c867](https://github.com/Vtxdeo/vtx-protocol/commit/e09c867bbecea9f494212244a0bece8080b3fa8c))


### Bug Fixes

* **ci:** correct cargo publish logic in release pipeline ([b7365d0](https://github.com/Vtxdeo/vtx-protocol/commit/b7365d0d870e49488c6a761d1bf93d89804fd0a3))
* **ci:** fix npm publish error by using explicit package path ([35ddd70](https://github.com/Vtxdeo/vtx-protocol/commit/35ddd705ee1144ae92fd635a96ee7fce137c0e48))
* **ci:** flatten artifacts structure and fix npm publish path ([8d8a80a](https://github.com/Vtxdeo/vtx-protocol/commit/8d8a80a48291c4c88cddcb0d61de3322d406901d))
* correct release process documentationte README ([86f8663](https://github.com/Vtxdeo/vtx-protocol/commit/86f866307dcfa320601462cb06ea88e8cf84c785))
* correct release process documentationte README ([20814c0](https://github.com/Vtxdeo/vtx-protocol/commit/20814c08a2123506dd17d3363af30d80eadcaca1))
* correct release process documentationte README ([19e4be6](https://github.com/Vtxdeo/vtx-protocol/commit/19e4be655644aa5a5b855212111cea7d0a36392f))
* correct release process documentationte README ([f1b7b38](https://github.com/Vtxdeo/vtx-protocol/commit/f1b7b3849fe1358456a9e139a41cdcc15bdef353))
* correct release process documentationte README ([2b8a617](https://github.com/Vtxdeo/vtx-protocol/commit/2b8a6174118c6b3bd0690fe75a37e9f52d9fe84c))


### Miscellaneous Chores

* align primary branch name to master and initialize beta branch setup ([c8393b3](https://github.com/Vtxdeo/vtx-protocol/commit/c8393b3dde42447d6d5536c6f3de14b2fbb81ccd))
* integrate Release Please for automated versioning and release pipeline ([c7eab82](https://github.com/Vtxdeo/vtx-protocol/commit/c7eab8258d433c986d485e29d250113aedc11c6f))
