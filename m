Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF32EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so05m-00081B-D2; Tue, 10 Sep 2024 08:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05l-00080E-Ew
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:33 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1so05h-0004oE-Ca
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:35:33 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5bef295a45bso2409361a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725971727; x=1726576527; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jw9Kt1/j18KEn0dBPVo8RQ0uYOA7WgovrrOOH5x0suY=;
 b=qpJnAtUijx5/mDjH/t71xtNkY7MoaY6FHHCwZKFu770XVS4tMtVG515CunVpnGo5BQ
 0tW8duII+L9jZ+KwsdLWsLKkBUBwDNm0HyWB31uo/G7MQes1m3rNvZGFoJVcNGM5nYdX
 Q9FFVXncmme2AfNrvBMTOsP5hrCgLgNBP6Q1vnTmZnqY889tZ/ABoT//m2XOtwxDHRIw
 wdXEUkWGmAz+zTEUvugdy7sPYpd4e/WTXgfhgF3g6pn6Awdu8l8LCcXcaaGHFdbVPI8n
 yzspZg+INBPAABdghY973laqssuPEOu1djkJ2Z8rA0lk/ik/AsufI3M0Su3ufxXXnFXf
 SuhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725971727; x=1726576527;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jw9Kt1/j18KEn0dBPVo8RQ0uYOA7WgovrrOOH5x0suY=;
 b=k+DX3x9QnYcwOOtPVbWU8pb+VzBfn/Y7TwcJ0G+ITkHyK9yx0VgRPsxkH5sG299QX/
 nzSUHgEkOAsaa1uuNbsO/xygQbc+Z9lONR2VL39Lf779fSarJ5B9p1Ku2jCRTTcd32ug
 E1E5y4pF+HVZgRUMjWxTo8YagoKW0R0a0o8QUc5fXg/lLz6KFM99/DUROQ2PhlgGSW4r
 d7JqSRchWkC2yxw8xpkuBA4sZPSNC3bdU+CBs4ojS5lBz7HcOpuC9etkUwDu667AgcDz
 43JudZkWiNsHq3/GUjvCzg8EjdMD+ed19VvpBLgw8c/5taKxwbw/ycIjtQ2CBis27FPj
 1YLw==
X-Gm-Message-State: AOJu0YwNXpBCoWRB4tui1Whq6eTlL9uu8syy3OmBTe+IDraKKu1d4l9n
 VoYKHyCIE9aTxKxEkSwCFuDJy20U8wTBjTYxW179OFoU1uLbHnIFiQRLmXIc6ADd/Ai/UC9WZyT
 iDkI=
X-Google-Smtp-Source: AGHT+IEBk09MHc2M6ZJYPCTOPxeTAiyR6ywJkvAMJ0VqUo7wqdmS//bNRqA/RRPunddvECsmaHvpuA==
X-Received: by 2002:a05:6402:524f:b0:5c2:6090:4049 with SMTP id
 4fb4d7f45d1cf-5c3dc7b7c28mr14486939a12.24.1725971726672; 
 Tue, 10 Sep 2024 05:35:26 -0700 (PDT)
Received: from [127.0.1.1] (adsl-234.109.242.225.tellas.gr. [109.242.225.234])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41cd7sm4242994a12.3.2024.09.10.05.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 05:35:26 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v10 0/9] Add Rust build support, ARM PL011 device impl
Date: Tue, 10 Sep 2024 15:35:06 +0300
Message-Id: <20240910-rust-pl011-v10-0-85a89ee33c40@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPo84GYC/2XNywqDMBAF0F+RrJuShzFJV/2P0oWPRAeKkcRKi
 /jvnQoFQ5f3MufOSpKL4BK5FCuJboEEYcTA2akg7VCPvaPQYUEEEyUzvKTxmWY6PRjndNEEz6b
 oPLz2jdsd8wBpDvG9T+IFtj+sckwZtVpxqZw1RvLrA8Y6hnOIPfnuLOZghcysQdtYr3RZNV3t5
 Z+1R6sza9E6yxrbCuNNlf/dtu0DXzjcLhQBAAA=
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>, Junjie Mao <junjie.mao@intel.com>, 
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=8677;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=52NHtVjT0ogV9qScAuRiTTKX9OXFbFsdSp17o/dO5MQ=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm00RDBKdHQyWWhrS2ViSzVuQWErRDNwTno0U3hWCm9jZGZKTmZsRVBDTjkzQzRt
 eENKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnVBOUNRQUt
 DUkIzS2Nkd2YzNEowSFZNRC85SlVqM0tHbUVQMXJ3NEZ1K25wMVlTRDY5ZUVMRWp2SldnZ2ovVA
 pyRldwSGlsbVBiblEvREp6N2N6WkhGTUJkcVlvckZzVFp6RjdNdmZpRzBlL3AxekdmRkZxcXk1c
 Ewwb3JxZmUvCkVYMmZsREpnaFZYekgwT2dGNHYxcG9tSlBjTWVEeWF2aUZjNEZReVhrUWZGdXBr
 NEJaY0g0TGhwQXhFZ0huOVoKd3B5UnVNb3ZrSHJJTDRWeU9PMy94Q045d0RSVTlPVTMxeEEwYkd
 xeGRQdmptNndYd1RMTW54SWVmZmgvUXBaRAp3bmVrU29oa0xkUTRqQnM5cnFUaWVEZmRaNkR0Nk
 ZraXNMNXBVaHJTVUROUDZFNS9oRCttMVhGTFlFbDllWG41CmpGb0I2RWt3OTdFMGhxcytqQ210S
 zRXdjhIRjM2ZlVKTkdsS2p2RmloNWJUYXcxQjl4VExoT1RYLzBIOFJONVIKT1lUWWhEMis5NVFt
 anBEaWl3T1MvOTZxTllvdVU0QWthM0JiUFptYUZodFo1SUlwM1FGRnVZamZ3dmsxTy9FWAoyQVp
 rSFBNZXJQeityUUQ3enNhbG1QVVhKeG1wZW1JS1BMalZDblc4c0NKaWlTeHE4eFprcVJ5TXplbn
 BJaHlWCkZCQ2FjRmVzRlR2aXdXNnBVR1A0WFZrekRhKzJuWEJRenVpNStYUVFMS3RNTEtxZXRaW
 mtlWmVEbVdxMFRoTjcKWnNlc2t3V3g1MEo4SjA5SGVEQmJlU2M0OE5IdndicW9YVFV5RGQwWkRI
 bmw2UmozVG1jM0xGUk9VY3dEQnFwVQpZdkNNZDVWWkQxbmp3ajZDVndvcDlnV3JmWDlRUm5zVDN
 rZ01hcDhlNGE4U0VQSC8yZGZTVFJZZnMwZ3UwMUNECi94RE5jUT09Cj1PcFJlCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x532.google.com
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

WARNING: This series contains a patch with blob diffs and thus problems
may arise with your patch workflow. The revision is available at
https://gitlab.com/epilys/qemu/-/tree/rust-v10 for you to fetch.

rust-v10 head: 29f226178b5af97612cc8d1c8401959c6f41f027

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

---
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

 MAINTAINERS                                        |  21 +
 configure                                          | 170 +++++-
 meson.build                                        |  98 +++-
 rust/wrapper.h                                     |  47 ++
 .gitattributes                                     |   3 +
 Kconfig                                            |   1 +
 Kconfig.host                                       |   3 +
 hw/arm/Kconfig                                     |  33 +-
 meson_options.txt                                  |   3 +
 python/scripts/vendor.py                           |   4 +-
 python/wheels/meson-1.2.3-py3-none-any.whl         | Bin 964928 -> 0 bytes
 python/wheels/meson-1.5.0-py3-none-any.whl         | Bin 0 -> 959846 bytes
 pythondeps.toml                                    |   2 +-
 rust/.gitignore                                    |   3 +
 rust/Kconfig                                       |   1 +
 rust/hw/Kconfig                                    |   2 +
 rust/hw/char/Kconfig                               |   3 +
 rust/hw/char/meson.build                           |   1 +
 rust/hw/char/pl011/.gitignore                      |   2 +
 rust/hw/char/pl011/Cargo.lock                      | 134 +++++
 rust/hw/char/pl011/Cargo.toml                      |  26 +
 rust/hw/char/pl011/README.md                       |  31 ++
 rust/hw/char/pl011/meson.build                     |  26 +
 rust/hw/char/pl011/src/definitions.rs              |  20 +
 rust/hw/char/pl011/src/device.rs                   | 600 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  63 +++
 rust/hw/char/pl011/src/lib.rs                      | 586 ++++++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs               |  59 ++
 rust/hw/meson.build                                |   1 +
 rust/meson.build                                   |   4 +
 rust/qemu-api-macros/Cargo.lock                    |  47 ++
 rust/qemu-api-macros/Cargo.toml                    |  25 +
 rust/qemu-api-macros/README.md                     |   1 +
 rust/qemu-api-macros/meson.build                   |  25 +
 rust/qemu-api-macros/src/lib.rs                    |  43 ++
 rust/qemu-api/.gitignore                           |   2 +
 rust/qemu-api/Cargo.lock                           |   7 +
 rust/qemu-api/Cargo.toml                           |  26 +
 rust/qemu-api/README.md                            |  17 +
 rust/qemu-api/build.rs                             |  14 +
 rust/qemu-api/meson.build                          |  24 +
 rust/qemu-api/src/definitions.rs                   | 109 ++++
 rust/qemu-api/src/device_class.rs                  | 128 +++++
 rust/qemu-api/src/lib.rs                           | 154 ++++++
 rust/qemu-api/src/tests.rs                         |  49 ++
 rust/rustfmt.toml                                  |   7 +
 scripts/archive-source.sh                          |   6 +-
 scripts/make-release                               |   5 +-
 scripts/meson-buildoptions.sh                      |   3 +
 scripts/rust/rust_root_crate.sh                    |  13 +
 scripts/rust/rustc_args.py                         |  84 +++
 subprojects/.gitignore                             |  11 +
 subprojects/arbitrary-int-1-rs.wrap                |   7 +
 subprojects/bilge-0.2-rs.wrap                      |   7 +
 subprojects/bilge-impl-0.2-rs.wrap                 |   7 +
 subprojects/either-1-rs.wrap                       |   7 +
 subprojects/itertools-0.11-rs.wrap                 |   7 +
 .../packagefiles/arbitrary-int-1-rs/meson.build    |  19 +
 subprojects/packagefiles/bilge-0.2-rs/meson.build  |  29 +
 .../packagefiles/bilge-impl-0.2-rs/meson.build     |  45 ++
 subprojects/packagefiles/either-1-rs/meson.build   |  24 +
 .../packagefiles/itertools-0.11-rs/meson.build     |  30 ++
 .../packagefiles/proc-macro-error-1-rs/meson.build |  40 ++
 .../proc-macro-error-attr-1-rs/meson.build         |  32 ++
 .../packagefiles/proc-macro2-1-rs/meson.build      |  31 ++
 subprojects/packagefiles/quote-1-rs/meson.build    |  29 +
 subprojects/packagefiles/syn-2-rs/meson.build      |  40 ++
 .../packagefiles/unicode-ident-1-rs/meson.build    |  20 +
 subprojects/proc-macro-error-1-rs.wrap             |   7 +
 subprojects/proc-macro-error-attr-1-rs.wrap        |   7 +
 subprojects/proc-macro2-1-rs.wrap                  |   7 +
 subprojects/quote-1-rs.wrap                        |   7 +
 subprojects/syn-2-rs.wrap                          |   7 +
 subprojects/unicode-ident-1-rs.wrap                |   7 +
 subprojects/unicode-ident-1-rs/meson.build         |  20 +
 tests/lcitool/mappings.yml                         |   2 +-
 76 files changed, 3163 insertions(+), 22 deletions(-)
---
base-commit: a733f37aef3b7d1d33bfe2716af88cdfd67ba64e
change-id: 20240814-rust-pl011-v7

Best regards,
-- 
γαῖα πυρί μιχθήτω


