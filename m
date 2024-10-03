Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE66CF34AD
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 13:30:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swLtS-0008SG-0U; Thu, 03 Oct 2024 09:29:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtQ-0008Rw-F5
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:20 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1swLtM-0005v6-65
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 09:29:20 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c5cf26b95aso1191829a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 06:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727962143; x=1728566943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fg1tKdt50t2/A7kTjULWnpE+Kn6ateZeisnjiBltalY=;
 b=uyPACvzuzS3M7sbMN7VSRi1Y65Qyz3mjiPAIHPiKpDMKVWNj55lWUCwH4Rvf9QFgb4
 KIVQqI7qYDOzKv8MGT9d9hCKsNH8QXiuL41NHtH2AqEUupguRhxrrG6MkY+G+IDfmcn2
 OmDy/I4yzjepYKLMkopTKJyGpr0CLAMBKImajgncroD1QGznC8HhgaRHL0m6mRQIkgO0
 JHyn1WiQrF5pvptNkVDxdp7WLo00jFUfld2eeqMSSvk/QWInl483r5/ZA92r3PyEkm5H
 bq5JkYhIdCyxXrZkJFZGA2D3pAxCIbLbIpJ7NrxnoY3la1opBauVJfyqlUGg70EhJk1J
 MSfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727962143; x=1728566943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fg1tKdt50t2/A7kTjULWnpE+Kn6ateZeisnjiBltalY=;
 b=ThPMa0eecGE/PQ42nLssg4psn9vKSdtt/634Q+Yivj8aOGvV9fdbCkwt0lVdJo6f6l
 voTWDw80lxBBK/RalZhnRrSkt1DhfRz9a9HLqqTdhTQt/iZM7JgRUZdGuOtm/sIJrxUn
 /3CxvkjbeupMqENdqYR2fg1EZ9ktnX3OgzP4qehkRbreb9s8S4SwF/mf6x9PyfZpIMvO
 8mZl0TplX7KnGh7ORjhnj1F+PfD7gGdxnEyOVkx91ID23rMl7GtBnXlfD0MKHRwrN7AG
 gjNCDZxyO7DgJjUj4rD3UvC8oTxomY2S3WdXWAt+iAPsFNcDASsb2yznRbbf6uLjHPrY
 WQAA==
X-Gm-Message-State: AOJu0YzzU+kV0L01eQ+l9FOGX4zdn6gCWE6QbGKOmMrTo8ywIbIEshhl
 Rr0Hyj9eiHgWIYHyWrJv0mr3b+knKsfAbkepcjnjme1t23mevqN+srqJVrkEZhKZmR9uSxrvGEO
 KJ/o=
X-Google-Smtp-Source: AGHT+IGOdXY2hhMx0tarQe5bE1rmiNG5O1xkTuqmiJCQ6c5Z49z147NmDb8CmsyKrbOsI6mRZItCEw==
X-Received: by 2002:a17:907:960c:b0:a8a:9054:8391 with SMTP id
 a640c23a62f3a-a98f8207e6dmr599752166b.5.1727962143184; 
 Thu, 03 Oct 2024 06:29:03 -0700 (PDT)
Received: from localhost.localdomain (adsl-122.37.6.160.tellas.gr.
 [37.6.160.122]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99102a4cdcsm86528366b.57.2024.10.03.06.29.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 06:29:02 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Hanna Reitz <hreitz@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 Junjie Mao <junjie.mao@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, berrange@redhat.com, hi@alyssa.is
Subject: [PATCH v11 0/9] Add Rust build support, ARM PL011 device impl
Date: Thu,  3 Oct 2024 16:28:42 +0300
Message-ID: <cover.1727961605.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

WARNING: This series contains a patch with blob diffs (update of python 
wheels) and thus problems may arise with your patch workflow. The 
revision is available at
https://gitlab.com/epilys/qemu/-/tree/20240814-rust-pl011-v7-v11 for you 
to fetch. HEAD is 6ec1d4fb8db2a1d7ba94c73e65d9770371b7857d

Hello everyone,

This series adds:

- build system support for the Rust compiler
- a small Rust library, qemu-api, which includes bindings to QEMU's C 
  interface generated with bindgen, and qemu-api-macros, a procedural 
  macro library.
- a proof of concept ARM PL011 device implementation in Rust, chosen for 
  its low complexity. The device is used in the arm virt machine if qemu 
  is compiled with rust enabled (./configure --enable-rust [...])

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
---
Changes in v11:
- rebased against current master
- addressed review comments by Junjie
- addressed review comments by Paolo
- added r-o-bs
- use rustified and bitfield enum generation with bindgen
- use size_t instead of usize for FFI
- Link to v10: https://lore.kernel.org/qemu-devel/20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org

See also range-diff against v10 at the end of the cover letter.

Changes in v10:
- Removed unnecessary meson version check (thanks Alex)
- Added warning in `configure` when Rust is not disabled about what to
  do if bindgen does not detect the correct libclang and fails to find
  certain system header files.
- Disabled rust qemu allocator by default
- Added changes by Paolo to detect the correct rust target for cross
  compilation in `configure` script.
- Made PL011State::init fn unsafe (Paolo)
- Link to v9: https://lore.kernel.org/r/20240827-rust-pl011-v9-0-e90b9c28f861@linaro.org

Changes in v9:
- Addressed v8 review comment: removed rustfmt.toml symlink (Junjie Mao)
- Addressed v8 review comment: removed unused cstr files (Junjie Mao)
- Addressed v8 review comment: added HAVE_GLIB_WITH_ALIGNED_ALLOC config
  host def to check whether glib's aligned alloc functions are available (Junjie Mao)
- qemu_api: Changed default alignment condition in allocator (alignment
  is always nonzero)
- qemu_api: Enabled allocator by default in builds
- pl011: fixed invalid cast of byte buffer to u32 in pl011_receive()
  leading to misaligned read

- Link to v8: https://lore.kernel.org/r/20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org

Changes in v8:
- Allow for compilation of more than one Rust-based component in Meson
  by compiling all Rust static libraries into one "root" library before
  linking it to each target emulation executable.
- Added a qemu_api_macros procedural macro library.
- (minor) Moved generated bindings.rs to qemu_api crate using meson's
  structured_source() instead of compiling it as a standalone crate
  which was unnecessary.
- (minor) Removed unnecessary rustc optimization/debug flags (should be handled
  by meson instead).
- (minor) Moved build scripts under scripts/rust/
- (minor) Fixed license issues

Previous version was: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>

https://lore.kernel.org/qemu-devel/20240815-rust-pl011-v7-0-975135e98831@linaro.org/

Outstanding issues that are not blocking for merge are:

- Cross-compilation for aarch64 is not possible out-of-the-box because of this bug:
  <https://github.com/rust-lang/rust/issues/125619> in llvm which when
  fixed, must be ported to upstream rust's llvm fork. Since the problem
  is an extraneous symbol we could strip it with objcopy -N|--strip-symbol
  Fix is in upstream llvm, we're awaiting for rust upstream to pick it up.

Manos Pitsidianakis (7):
  build-sys: Add rust feature option
  rust: add bindgen step as a meson dependency
  .gitattributes: add Rust diff and merge attributes
  meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
  rust: add crate to expose bindings and interfaces
  rust: add utility procedural macro crate
  rust: add PL011 device model

Paolo Bonzini (2):
  Require meson version 1.5.0
  configure, meson: detect Rust toolchain

 MAINTAINERS                                   |  21 +
 configure                                     | 170 ++++-
 meson.build                                   | 125 +++-
 rust/wrapper.h                                |  47 ++
 .gitattributes                                |   3 +
 Kconfig                                       |   1 +
 Kconfig.host                                  |   3 +
 hw/arm/Kconfig                                |  30 +-
 meson_options.txt                             |   3 +
 python/scripts/vendor.py                      |   4 +-
 python/wheels/meson-1.2.3-py3-none-any.whl    | Bin 964928 -> 0 bytes
 python/wheels/meson-1.5.0-py3-none-any.whl    | Bin 0 -> 959846 bytes
 pythondeps.toml                               |   2 +-
 rust/.gitignore                               |   3 +
 rust/Kconfig                                  |   1 +
 rust/hw/Kconfig                               |   2 +
 rust/hw/char/Kconfig                          |   3 +
 rust/hw/char/meson.build                      |   1 +
 rust/hw/char/pl011/.gitignore                 |   2 +
 rust/hw/char/pl011/Cargo.lock                 | 134 ++++
 rust/hw/char/pl011/Cargo.toml                 |  26 +
 rust/hw/char/pl011/README.md                  |  31 +
 rust/hw/char/pl011/meson.build                |  26 +
 rust/hw/char/pl011/src/device.rs              | 599 ++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs        |  70 ++
 rust/hw/char/pl011/src/lib.rs                 | 586 +++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs          |  59 ++
 rust/hw/meson.build                           |   1 +
 rust/meson.build                              |   4 +
 rust/qemu-api-macros/Cargo.lock               |  47 ++
 rust/qemu-api-macros/Cargo.toml               |  25 +
 rust/qemu-api-macros/README.md                |   1 +
 rust/qemu-api-macros/meson.build              |  25 +
 rust/qemu-api-macros/src/lib.rs               |  43 ++
 rust/qemu-api/.gitignore                      |   2 +
 rust/qemu-api/Cargo.lock                      |   7 +
 rust/qemu-api/Cargo.toml                      |  26 +
 rust/qemu-api/README.md                       |  17 +
 rust/qemu-api/build.rs                        |  14 +
 rust/qemu-api/meson.build                     |  24 +
 rust/qemu-api/src/definitions.rs              |  97 +++
 rust/qemu-api/src/device_class.rs             | 128 ++++
 rust/qemu-api/src/lib.rs                      | 166 +++++
 rust/qemu-api/src/tests.rs                    |  49 ++
 rust/rustfmt.toml                             |   7 +
 scripts/archive-source.sh                     |   6 +-
 scripts/make-release                          |   5 +-
 scripts/meson-buildoptions.sh                 |   3 +
 scripts/rust/rust_root_crate.sh               |  13 +
 scripts/rust/rustc_args.py                    |  84 +++
 subprojects/.gitignore                        |  11 +
 subprojects/arbitrary-int-1-rs.wrap           |   7 +
 subprojects/bilge-0.2-rs.wrap                 |   7 +
 subprojects/bilge-impl-0.2-rs.wrap            |   7 +
 subprojects/either-1-rs.wrap                  |   7 +
 subprojects/itertools-0.11-rs.wrap            |   7 +
 .../arbitrary-int-1-rs/meson.build            |  19 +
 .../packagefiles/bilge-0.2-rs/meson.build     |  29 +
 .../bilge-impl-0.2-rs/meson.build             |  45 ++
 .../packagefiles/either-1-rs/meson.build      |  24 +
 .../itertools-0.11-rs/meson.build             |  30 +
 .../proc-macro-error-1-rs/meson.build         |  40 ++
 .../proc-macro-error-attr-1-rs/meson.build    |  32 +
 .../packagefiles/proc-macro2-1-rs/meson.build |  31 +
 .../packagefiles/quote-1-rs/meson.build       |  29 +
 subprojects/packagefiles/syn-2-rs/meson.build |  40 ++
 .../unicode-ident-1-rs/meson.build            |  20 +
 subprojects/proc-macro-error-1-rs.wrap        |   7 +
 subprojects/proc-macro-error-attr-1-rs.wrap   |   7 +
 subprojects/proc-macro2-1-rs.wrap             |   7 +
 subprojects/quote-1-rs.wrap                   |   7 +
 subprojects/syn-2-rs.wrap                     |   7 +
 subprojects/unicode-ident-1-rs.wrap           |   7 +
 subprojects/unicode-ident-1-rs/meson.build    |  20 +
 tests/lcitool/mappings.yml                    |   2 +-
 75 files changed, 3174 insertions(+), 21 deletions(-)
 create mode 100644 rust/wrapper.h
 delete mode 100644 python/wheels/meson-1.2.3-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.5.0-py3-none-any.whl
 create mode 100644 rust/.gitignore
 create mode 100644 rust/Kconfig
 create mode 100644 rust/hw/Kconfig
 create mode 100644 rust/hw/char/Kconfig
 create mode 100644 rust/hw/char/meson.build
 create mode 100644 rust/hw/char/pl011/.gitignore
 create mode 100644 rust/hw/char/pl011/Cargo.lock
 create mode 100644 rust/hw/char/pl011/Cargo.toml
 create mode 100644 rust/hw/char/pl011/README.md
 create mode 100644 rust/hw/char/pl011/meson.build
 create mode 100644 rust/hw/char/pl011/src/device.rs
 create mode 100644 rust/hw/char/pl011/src/device_class.rs
 create mode 100644 rust/hw/char/pl011/src/lib.rs
 create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/hw/meson.build
 create mode 100644 rust/meson.build
 create mode 100644 rust/qemu-api-macros/Cargo.lock
 create mode 100644 rust/qemu-api-macros/Cargo.toml
 create mode 100644 rust/qemu-api-macros/README.md
 create mode 100644 rust/qemu-api-macros/meson.build
 create mode 100644 rust/qemu-api-macros/src/lib.rs
 create mode 100644 rust/qemu-api/.gitignore
 create mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/Cargo.toml
 create mode 100644 rust/qemu-api/README.md
 create mode 100644 rust/qemu-api/build.rs
 create mode 100644 rust/qemu-api/meson.build
 create mode 100644 rust/qemu-api/src/definitions.rs
 create mode 100644 rust/qemu-api/src/device_class.rs
 create mode 100644 rust/qemu-api/src/lib.rs
 create mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/rustfmt.toml
 create mode 100755 scripts/rust/rust_root_crate.sh
 create mode 100644 scripts/rust/rustc_args.py
 create mode 100644 subprojects/arbitrary-int-1-rs.wrap
 create mode 100644 subprojects/bilge-0.2-rs.wrap
 create mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 create mode 100644 subprojects/either-1-rs.wrap
 create mode 100644 subprojects/itertools-0.11-rs.wrap
 create mode 100644 subprojects/packagefiles/arbitrary-int-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/bilge-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/bilge-impl-0.2-rs/meson.build
 create mode 100644 subprojects/packagefiles/either-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/itertools-0.11-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-attr-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/quote-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/syn-2-rs/meson.build
 create mode 100644 subprojects/packagefiles/unicode-ident-1-rs/meson.build
 create mode 100644 subprojects/proc-macro-error-1-rs.wrap
 create mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
 create mode 100644 subprojects/proc-macro2-1-rs.wrap
 create mode 100644 subprojects/quote-1-rs.wrap
 create mode 100644 subprojects/syn-2-rs.wrap
 create mode 100644 subprojects/unicode-ident-1-rs.wrap
 create mode 100644 subprojects/unicode-ident-1-rs/meson.build

Range-diff against v10:
 1:  9335dd9849 !  1:  74e1eb4b13 Require meson version 1.5.0
    @@ pythondeps.toml
      # The install key should match the version in python/wheels/
     -meson = { accepted = ">=1.1.0", installed = "1.2.3", canary = "meson" }
     +meson = { accepted = ">=1.5.0", installed = "1.5.0", canary = "meson" }
    + pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
      
      [docs]
    - # Please keep the installed versions in sync with docs/requirements.txt
     
      ## tests/lcitool/mappings.yml ##
     @@ tests/lcitool/mappings.yml: mappings:
 2:  b7508a1a2c =  2:  14642d80fb build-sys: Add rust feature option
 3:  a764b69afa =  3:  207d2640b3 configure, meson: detect Rust toolchain
 4:  492e93bf71 !  4:  1be89a2771 rust: add bindgen step as a meson dependency
    @@ meson.build: common_all = static_library('common',
                                  dependencies: common_ss.all_dependencies())
      
     +if have_rust and have_system
    -+  rustc_config_args = run_command(
    ++  rustc_args = run_command(
     +    find_program('scripts/rust/rustc_args.py'),
     +    '--config-headers', meson.project_build_root() / 'config-host.h',
     +    capture : true,
     +    check: true).stdout().strip().split()
    ++  rustc_args += ['-D', 'unsafe_op_in_unsafe_fn']
    ++  bindgen_args = [
    ++    '--disable-header-comment',
    ++    '--raw-line', '// @generated',
    ++    '--ctypes-prefix', 'core::ffi',
    ++    '--formatter', 'rustfmt',
    ++    '--generate-block',
    ++    '--generate-cstr',
    ++    '--impl-debug',
    ++    '--merge-extern-blocks',
    ++    '--no-doc-comments',
    ++    '--use-core',
    ++    '--with-derive-default',
    ++    '--no-size_t-is-usize',
    ++    '--no-layout-tests',
    ++    '--no-prepend-enum-name',
    ++    '--allowlist-file', meson.project_source_root() + '/include/.*',
    ++    '--allowlist-file', meson.project_source_root() + '/.*',
    ++    '--allowlist-file', meson.project_build_root() + '/.*'
    ++    ]
    ++  c_enums = [
    ++    'DeviceCategory',
    ++    'GpioPolarity',
    ++    'MachineInitPhase',
    ++    'MemoryDeviceInfoKind',
    ++    'MigrationPolicy',
    ++    'MigrationPriority',
    ++    'QEMUChrEvent',
    ++    'QEMUClockType',
    ++    'device_endian',
    ++    'module_init_type',
    ++  ]
    ++  foreach enum : c_enums
    ++    bindgen_args += ['--rustified-enum', enum]
    ++  endforeach
    ++  c_bitfields = [
    ++    'ClockEvent',
    ++    'VMStateFlags',
    ++  ]
    ++  foreach enum : c_bitfields
    ++    bindgen_args += ['--bitfield-enum', enum]
    ++  endforeach
     +
     +  # TODO: Remove this comment when the clang/libclang mismatch issue is solved.
     +  #
    @@ meson.build: common_all = static_library('common',
     +    output: 'bindings.rs',
     +    include_directories: include_directories('.', 'include'),
     +    bindgen_version: ['>=0.69.4'],
    -+    args: [
    -+      '--disable-header-comment',
    -+      '--raw-line', '// @generated',
    -+      '--ctypes-prefix', 'core::ffi',
    -+      '--formatter', 'rustfmt',
    -+      '--generate-block',
    -+      '--generate-cstr',
    -+      '--impl-debug',
    -+      '--merge-extern-blocks',
    -+      '--no-doc-comments',
    -+      '--use-core',
    -+      '--with-derive-default',
    -+      '--allowlist-file', meson.project_source_root() + '/include/.*',
    -+      '--allowlist-file', meson.project_source_root() + '/.*',
    -+      '--allowlist-file', meson.project_build_root() + '/.*'
    -+      ],
    ++    args: bindgen_args,
     +    )
     +  subdir('rust')
     +endif
 5:  40937067f9 =  5:  278e3878b4 .gitattributes: add Rust diff and merge attributes
 6:  c9b544bc01 =  6:  23f7b0cc98 meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
 7:  f4dfecd31b !  7:  0fb23fbe21 rust: add crate to expose bindings and interfaces
    @@ rust/qemu-api/meson.build (new)
     +  ),
     +  override_options: ['rust_std=2021', 'build.rust_std=2021'],
     +  rust_abi: 'rust',
    -+  rust_args: rustc_config_args + [
    ++  rust_args: rustc_args + [
     +    '--cfg', 'MESON',
     +    # '--cfg', 'feature="allocator"',
     +  ],
    @@ rust/qemu-api/src/definitions.rs (new)
     +
     +//! Definitions required by QEMU when registering a device.
     +
    ++use ::core::ffi::{c_void, CStr};
    ++
    ++use crate::bindings::{Object, ObjectClass, TypeInfo};
    ++
     +/// Trait a type must implement to be registered with QEMU.
     +pub trait ObjectImpl {
     +    type Class;
    -+    const TYPE_INFO: crate::bindings::TypeInfo;
    -+    const TYPE_NAME: &'static ::core::ffi::CStr;
    -+    const PARENT_TYPE_NAME: Option<&'static ::core::ffi::CStr>;
    -+    const INSTANCE_INIT: ::core::option::Option<
    -+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
    -+    >;
    -+    const INSTANCE_POST_INIT: ::core::option::Option<
    -+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
    -+    >;
    -+    const INSTANCE_FINALIZE: ::core::option::Option<
    -+        unsafe extern "C" fn(obj: *mut crate::bindings::Object),
    -+    >;
    ++    const TYPE_INFO: TypeInfo;
    ++    const TYPE_NAME: &'static CStr;
    ++    const PARENT_TYPE_NAME: Option<&'static CStr>;
     +    const ABSTRACT: bool;
    ++    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
    ++    const INSTANCE_POST_INIT: Option<unsafe extern "C" fn(obj: *mut Object)>;
    ++    const INSTANCE_FINALIZE: Option<unsafe extern "C" fn(obj: *mut Object)>;
     +}
     +
     +pub trait Class {
    -+    const CLASS_INIT: ::core::option::Option<
    -+        unsafe extern "C" fn(
    -+            klass: *mut crate::bindings::ObjectClass,
    -+            data: *mut core::ffi::c_void,
    -+        ),
    -+    >;
    -+    const CLASS_BASE_INIT: ::core::option::Option<
    -+        unsafe extern "C" fn(
    -+            klass: *mut crate::bindings::ObjectClass,
    -+            data: *mut core::ffi::c_void,
    -+        ),
    ++    const CLASS_INIT: Option<unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void)>;
    ++    const CLASS_BASE_INIT: Option<
    ++        unsafe extern "C" fn(klass: *mut ObjectClass, data: *mut c_void),
     +    >;
     +}
     +
    @@ rust/qemu-api/src/definitions.rs (new)
     +        #[cfg_attr(target_os = "macos", link_section = "__DATA,__mod_init_func")]
     +        #[cfg_attr(target_os = "windows", link_section = ".CRT$XCU")]
     +        pub static LOAD_MODULE: extern "C" fn() = {
    -+            assert!($type < $crate::bindings::module_init_type_MODULE_INIT_MAX);
    -+
     +            extern "C" fn __load() {
     +                unsafe {
     +                    $crate::bindings::register_module_init(Some($func), $type);
    @@ rust/qemu-api/src/definitions.rs (new)
     +                unsafe {
     +                    $crate::bindings::register_module_init(
     +                        Some($func),
    -+                        $crate::bindings::module_init_type_MODULE_INIT_QOM,
    ++                        $crate::bindings::module_init_type::MODULE_INIT_QOM,
     +                    );
     +                }
     +            }
    @@ rust/qemu-api/src/definitions.rs (new)
     +            } else {
     +                ::core::ptr::null_mut()
     +            },
    -+            instance_size: ::core::mem::size_of::<$t>(),
    -+            instance_align: ::core::mem::align_of::<$t>(),
    ++            instance_size: ::core::mem::size_of::<$t>() as $crate::bindings::size_t,
    ++            instance_align: ::core::mem::align_of::<$t>() as $crate::bindings::size_t,
     +            instance_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_INIT,
     +            instance_post_init: <$t as $crate::definitions::ObjectImpl>::INSTANCE_POST_INIT,
     +            instance_finalize: <$t as $crate::definitions::ObjectImpl>::INSTANCE_FINALIZE,
     +            abstract_: <$t as $crate::definitions::ObjectImpl>::ABSTRACT,
    -+            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>(),
    ++            class_size:  ::core::mem::size_of::<<$t as $crate::definitions::ObjectImpl>::Class>() as $crate::bindings::size_t,
     +            class_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_INIT,
     +            class_base_init: <<$t as $crate::definitions::ObjectImpl>::Class as $crate::definitions::Class>::CLASS_BASE_INIT,
     +            class_data: ::core::ptr::null_mut(),
    @@ rust/qemu-api/src/device_class.rs (new)
     +
     +#[macro_export]
     +macro_rules! device_class_init {
    -+    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, reset_fn => $reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
    ++    ($func:ident, props => $props:ident, realize_fn => $realize_fn:expr, legacy_reset_fn => $legacy_reset_fn:expr, vmsd => $vmsd:ident$(,)*) => {
     +        #[no_mangle]
     +        pub unsafe extern "C" fn $func(
     +            klass: *mut $crate::bindings::ObjectClass,
    @@ rust/qemu-api/src/device_class.rs (new)
     +            let mut dc =
     +                ::core::ptr::NonNull::new(klass.cast::<$crate::bindings::DeviceClass>()).unwrap();
     +            dc.as_mut().realize = $realize_fn;
    -+            dc.as_mut().reset = $reset_fn;
     +            dc.as_mut().vmsd = &$vmsd;
    ++            $crate::bindings::device_class_set_legacy_reset(dc.as_mut(), $legacy_reset_fn);
     +            $crate::bindings::device_class_set_props(dc.as_mut(), $props.as_mut_ptr());
     +        }
     +    };
    @@ rust/qemu-api/src/lib.rs (new)
     +    non_camel_case_types,
     +    non_snake_case,
     +    non_upper_case_globals,
    ++    unsafe_op_in_unsafe_fn,
     +    clippy::missing_const_for_fn,
     +    clippy::too_many_arguments,
     +    clippy::approx_constant,
    @@ rust/qemu-api/src/lib.rs (new)
     +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
     +        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
     +        {
    -+            g_malloc0(layout.size().try_into().unwrap()).cast::<u8>()
    ++            // SAFETY: g_malloc0() is safe to call.
    ++            unsafe { g_malloc0(layout.size().try_into().unwrap()).cast::<u8>() }
     +        } else {
     +            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
     +            {
    -+                g_aligned_alloc0(
    -+                    layout.size().try_into().unwrap(),
    -+                    1,
    -+                    (8 * layout.align()).try_into().unwrap(),
    -+                )
    -+                .cast::<u8>()
    ++                // SAFETY: g_aligned_alloc0() is safe to call.
    ++                unsafe {
    ++                    g_aligned_alloc0(
    ++                        layout.size().try_into().unwrap(),
    ++                        1,
    ++                        layout.align().try_into().unwrap(),
    ++                    )
    ++                    .cast::<u8>()
    ++                }
     +            }
     +            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
     +            {
    -+                qemu_memalign(8 * layout.align(), layout.size()).cast::<u8>()
    ++                // SAFETY: qemu_memalign() is safe to call.
    ++                unsafe { qemu_memalign(layout.align(), layout.size()).cast::<u8>() }
     +            }
     +        }
     +    }
    @@ rust/qemu-api/src/lib.rs (new)
     +    unsafe fn dealloc(&self, ptr: *mut u8, layout: Layout) {
     +        if matches!(Self::DEFAULT_ALIGNMENT_BYTES, Some(default) if default.checked_rem(layout.align()) == Some(0))
     +        {
    -+            g_free(ptr.cast::<_>())
    ++            // SAFETY: `ptr` must have been allocated by Self::alloc thus a valid
    ++            // glib-allocated pointer, so `g_free`ing is safe.
    ++            unsafe { g_free(ptr.cast::<_>()) }
     +        } else {
     +            #[cfg(HAVE_GLIB_WITH_ALIGNED_ALLOC)]
     +            {
    -+                g_aligned_free(ptr.cast::<_>())
    ++                // SAFETY: `ptr` must have been allocated by Self::alloc thus a valid aligned
    ++                // glib-allocated pointer, so `g_aligned_free`ing is safe.
    ++                unsafe { g_aligned_free(ptr.cast::<_>()) }
     +            }
     +            #[cfg(not(HAVE_GLIB_WITH_ALIGNED_ALLOC))]
     +            {
    -+                qemu_vfree(ptr.cast::<_>())
    ++                // SAFETY: `ptr` must have been allocated by Self::alloc thus a valid aligned
    ++                // glib-allocated pointer, so `qemu_vfree`ing is safe.
    ++                unsafe { qemu_vfree(ptr.cast::<_>()) }
     +            }
     +        }
     +    }
 8:  6dc9aced83 !  8:  dd64564240 rust: add utility procedural macro crate
    @@ Commit message
         generates a constructor to register a QOM TypeInfo on init and it must
         be used on types that implement qemu_api::definitions::ObjectImpl trait.
     
    +    Reviewed-by: Junjie Mao <junjie.mao@hotmail.com>
         Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## MAINTAINERS ##
    @@ rust/qemu-api-macros/src/lib.rs (new)
     +                unsafe {
     +                    ::qemu_api::bindings::register_module_init(
     +                        Some(__register),
    -+                        ::qemu_api::bindings::module_init_type_MODULE_INIT_QOM
    ++                        ::qemu_api::bindings::module_init_type::MODULE_INIT_QOM
     +                    );
     +                }
     +            }
 9:  a8b4c239a3 !  9:  6ec1d4fb8d rust: add PL011 device model
    @@ meson.build: foreach target : target_dirs
     +                            rlib_rs,
     +                            dependencies: target_rust.dependencies(),
     +                            override_options: ['rust_std=2021', 'build.rust_std=2021'],
    -+                            rust_args: rustc_config_args,
    ++                            rust_args: rustc_args,
     +                            rust_abi: 'c')
     +      arch_deps += declare_dependency(link_whole: [rlib])
     +    endif
    @@ hw/arm/Kconfig: config MUSCA
          select PL031
          select SPLIT_IRQ
          select UNIMP
    -@@ hw/arm/Kconfig: config Z2
    -     depends on TCG && ARM
    -     select PFLASH_CFI01
    -     select WM8750
    --    select PL011 # UART
    -+    select PL011 if !HAVE_RUST # UART
    -+    select X_PL011_RUST if HAVE_RUST # UART
    -     select PXA2XX
    - 
    - config REALVIEW
     @@ hw/arm/Kconfig: config REALVIEW
          select WM8750 # audio codec
          select LSI_SCSI_PCI
    @@ rust/hw/char/pl011/meson.build (new)
     +  variables: {'crate': 'pl011'},
     +)])
     
    - ## rust/hw/char/pl011/src/definitions.rs (new) ##
    -@@
    -+// Copyright 2024, Linaro Limited
    -+// Author(s): Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
    -+// SPDX-License-Identifier: GPL-2.0-or-later
    -+
    -+//! Definitions required by QEMU when registering the device.
    -+
    -+use core::mem::MaybeUninit;
    -+
    -+use qemu_api::{bindings::*, definitions::ObjectImpl};
    -+
    -+use crate::device::PL011State;
    -+
    -+pub const TYPE_PL011: &std::ffi::CStr = c"pl011";
    -+
    -+#[used]
    -+pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
    -+    name: PL011State::TYPE_INFO.name,
    -+    unmigratable: true,
    -+    ..unsafe { MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
    -+};
    -
      ## rust/hw/char/pl011/src/device.rs (new) ##
     @@
     +// Copyright 2024, Linaro Limited
    @@ rust/hw/char/pl011/src/device.rs (new)
     +impl ObjectImpl for PL011State {
     +    type Class = PL011Class;
     +    const TYPE_INFO: qemu_api::bindings::TypeInfo = qemu_api::type_info! { Self };
    -+    const TYPE_NAME: &'static CStr = c"pl011";
    ++    const TYPE_NAME: &'static CStr = crate::TYPE_PL011;
     +    const PARENT_TYPE_NAME: Option<&'static CStr> = Some(TYPE_SYS_BUS_DEVICE);
     +    const ABSTRACT: bool = false;
     +    const INSTANCE_INIT: Option<unsafe extern "C" fn(obj: *mut Object)> = Some(pl011_init);
    @@ rust/hw/char/pl011/src/device.rs (new)
     +                CLK_NAME.as_ptr(),
     +                None, /* pl011_clock_update */
     +                addr_of_mut!(*self).cast::<c_void>(),
    -+                ClockEvent_ClockUpdate,
    ++                ClockEvent::ClockUpdate.0,
     +            ))
     +            .unwrap();
     +        }
    @@ rust/hw/char/pl011/src/device.rs (new)
     +    }
     +
     +    pub fn event(&mut self, event: QEMUChrEvent) {
    -+        if event == bindings::QEMUChrEvent_CHR_EVENT_BREAK && !self.fifo_enabled() {
    ++        if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK && !self.fifo_enabled() {
     +            self.put_fifo(DATA_BREAK);
     +            self.receive_status_error_clear.set_break_error(true);
     +        }
    @@ rust/hw/char/pl011/src/device.rs (new)
     +#[no_mangle]
     +pub unsafe extern "C" fn pl011_can_receive(opaque: *mut c_void) -> c_int {
     +    unsafe {
    -+        assert!(!opaque.is_null());
    ++        debug_assert!(!opaque.is_null());
     +        let state = NonNull::new_unchecked(opaque.cast::<PL011State>());
     +        state.as_ref().can_receive().into()
     +    }
    @@ rust/hw/char/pl011/src/device.rs (new)
     +    size: core::ffi::c_int,
     +) {
     +    unsafe {
    -+        assert!(!opaque.is_null());
    ++        debug_assert!(!opaque.is_null());
     +        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
     +        if state.as_ref().loopback_enabled() {
     +            return;
     +        }
     +        if size > 0 {
    -+            assert!(!buf.is_null());
    ++            debug_assert!(!buf.is_null());
     +            state.as_mut().put_fifo(c_uint::from(buf.read_volatile()))
     +        }
     +    }
    @@ rust/hw/char/pl011/src/device.rs (new)
     +#[no_mangle]
     +pub unsafe extern "C" fn pl011_event(opaque: *mut core::ffi::c_void, event: QEMUChrEvent) {
     +    unsafe {
    -+        assert!(!opaque.is_null());
    ++        debug_assert!(!opaque.is_null());
     +        let mut state = NonNull::new_unchecked(opaque.cast::<PL011State>());
     +        state.as_mut().event(event)
     +    }
    @@ rust/hw/char/pl011/src/device.rs (new)
     +) -> *mut DeviceState {
     +    unsafe {
     +        let dev: *mut DeviceState = qdev_new(PL011State::TYPE_INFO.name);
    -+        assert!(!dev.is_null());
    -+        let sysbus: *mut SysBusDevice = dev as *mut SysBusDevice;
    ++        let sysbus: *mut SysBusDevice = dev.cast::<SysBusDevice>();
     +
     +        qdev_prop_set_chr(dev, bindings::TYPE_CHARDEV.as_ptr(), chr);
     +        sysbus_realize_and_unref(sysbus, addr_of!(error_fatal) as *mut *mut Error);
    @@ rust/hw/char/pl011/src/device.rs (new)
     +#[no_mangle]
     +pub unsafe extern "C" fn pl011_init(obj: *mut Object) {
     +    unsafe {
    -+        assert!(!obj.is_null());
    ++        debug_assert!(!obj.is_null());
     +        let mut state = NonNull::new_unchecked(obj.cast::<PL011State>());
     +        state.as_mut().init();
     +    }
    @@ rust/hw/char/pl011/src/device_class.rs (new)
     +
     +use core::ptr::NonNull;
     +
    -+use qemu_api::bindings::*;
    ++use qemu_api::{bindings::*, definitions::ObjectImpl};
     +
    -+use crate::{definitions::VMSTATE_PL011, device::PL011State};
    ++use crate::device::PL011State;
    ++
    ++#[used]
    ++pub static VMSTATE_PL011: VMStateDescription = VMStateDescription {
    ++    name: PL011State::TYPE_INFO.name,
    ++    unmigratable: true,
    ++    ..unsafe { ::core::mem::MaybeUninit::<VMStateDescription>::zeroed().assume_init() }
    ++};
     +
     +qemu_api::declare_properties! {
     +    PL011_PROPERTIES,
    @@ rust/hw/char/pl011/src/device_class.rs (new)
     +    pl011_class_init,
     +    props => PL011_PROPERTIES,
     +    realize_fn => Some(pl011_realize),
    -+    reset_fn => Some(pl011_reset),
    ++    legacy_reset_fn => Some(pl011_reset),
     +    vmsd => VMSTATE_PL011,
     +}
     +
    @@ rust/hw/char/pl011/src/lib.rs (new)
     +//! the [`registers`] module for register types.
     +
     +#![deny(
    -+    unsafe_op_in_unsafe_fn,
     +    rustdoc::broken_intra_doc_links,
     +    rustdoc::redundant_explicit_links,
     +    clippy::correctness,
    @@ rust/hw/char/pl011/src/lib.rs (new)
     +extern crate bilge_impl;
     +extern crate qemu_api;
     +
    -+pub mod definitions;
     +pub mod device;
     +pub mod device_class;
     +pub mod memory_ops;
     +
    ++pub const TYPE_PL011: &::core::ffi::CStr = c"pl011";
    ++
     +/// Offset of each register from the base memory address of the device.
     +///
     +/// # Source
    @@ rust/hw/char/pl011/src/memory_ops.rs (new)
     +    write: Some(pl011_write),
     +    read_with_attrs: None,
     +    write_with_attrs: None,
    -+    endianness: device_endian_DEVICE_NATIVE_ENDIAN,
    ++    endianness: device_endian::DEVICE_NATIVE_ENDIAN,
     +    valid: unsafe { MaybeUninit::<MemoryRegionOps__bindgen_ty_1>::zeroed().assume_init() },
     +    impl_: MemoryRegionOps__bindgen_ty_2 {
     +        min_access_size: 4,

base-commit: 35ba77d2fcd10efd6db8318bbd4d21fa9402143b
-- 
γαῖα πυρί μιχθήτω


