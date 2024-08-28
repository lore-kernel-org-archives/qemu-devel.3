Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008D6C5474A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 04:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjA2T-0005Fr-Hv; Wed, 28 Aug 2024 00:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2R-0005FL-M2
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:07 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sjA2M-0000hI-Q8
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 00:12:06 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso349152a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 21:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724818320; x=1725423120; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oMVm/v+jQDrT8BtxJWUOTVTd+QdK/nIZHjMLBY365fs=;
 b=bmm5OdSjXMDDVYVVZCHt8NSjzWd81QmrFNmxraHTVEYWCdJkLzXJY8WMmeDrNS1KgI
 L2Pj29q8TscuxocPvf3zvGB7cNlnQ0N3hpC3D0jWyDrmpzV1POm0zuE9DEGWzv4k/Oz7
 vx3GfkMfpzmafpFeCyWH2vBBfFng+NuvO5RO2kS2UmT8rzRo8yArYetOzTP3iQYDFtyQ
 CnGRKgECmABaI4tkR7EFpVHM+ZqCjhiZ+/+QO80CO3kPt8B8pEOeEqFmK3H+XP1U1PUm
 bzD+Dvwr++Wu5TKeo5beuSQLCkpCMBBbGX2CV+LUY+sHv9/KgnpUuObDrM/eVAHfnuhh
 VgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724818320; x=1725423120;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oMVm/v+jQDrT8BtxJWUOTVTd+QdK/nIZHjMLBY365fs=;
 b=S074bDsFw7XrkdIjBunwlHiU8gJdX4Gi1j36kC+zrioEkePHEpmt18EouTlVCDDSAV
 D2LV00wnwHmwjwU/r9s8H6NhO3tnvdbx71zv+m5w+Xp3T5l0h1bYPGSVGXgeQ49T2B+B
 dECelqUpcxFIDXiKB41fyaDSy7fCrZ70ZdqsEsCtEUxPKGIr3ahh1+gqU2hnkdI9uDDa
 7TiKVGCFgEbJPhv+i/xZMidsuItaNjb18sejkzTuWz+XBmRnIGiEm5b1rFRVU6mfoZQ+
 Mw6icLlX1Oy9197/gHr1O83xQz7B4++9hrNoqktRANWP0AVnkrh/A8BIB0d7V9Z2Ip7+
 8tiw==
X-Gm-Message-State: AOJu0Yz8cJIiu0SSk8IRC2WV8IBKayCz8/YRMtV5xI/1Az4oX72Yklcy
 WyHoIQ0qycfi+WTjO060Ua+04p9dKmFqT6pLumtftST4dwl6L/agPN7kC4w43BM=
X-Google-Smtp-Source: AGHT+IGJJEXB8YTI46pgrJB0HjuZDQAMNQ4333BbAyXN+6L+3dhKpG0ucYdhM9I4IPHJ5sfFGzsSkQ==
X-Received: by 2002:a05:6402:84f:b0:5c2:122f:deea with SMTP id
 4fb4d7f45d1cf-5c2128cdaf7mr909110a12.0.1724818319841; 
 Tue, 27 Aug 2024 21:11:59 -0700 (PDT)
Received: from [127.0.1.1] (adsl-98.109.242.227.tellas.gr. [109.242.227.98])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c0bb1c29b9sm1712814a12.18.2024.08.27.21.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 21:11:59 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH RESEND v9 0/9] Add Rust build support, ARM PL011 device
 impl
Date: Wed, 28 Aug 2024 07:11:41 +0300
Message-Id: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
 Zhao Liu <zhao1.liu@intel.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
X-Mailer: b4 0.15-dev-c2c95
X-Developer-Signature: v=1; a=openpgp-sha256; l=7838;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=kul2ENg99DUpnaWYBxvyPVd7Ry/m5MSOf9TcYNEzaHY=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm16cU9JbW9GZnNXTFdUT2o2dDU0R3FNUU1jaUJkCmRucmRZckZacTZzS0s2WUp2
 RXVKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnM2amlBQUt
 DUkIzS2Nkd2YzNEowSVViRC80d1dhLzlCa2xaTkNGbENBRXR4YldsVUswTlN6akZVTkJJd0sxdg
 piRDZENEFTTTY0Z2ZkNGN0aVBtNldUQ2lTMVF4dnZBL056NzI1R2IvZDBQdi9kU09NN3V0dG9oT
 WluUG5tVTdhCnE2WjFZUHBVTkp6K2dJUW1hUkhjVUpaZ3FOQ241MjlxTmZHUnVXeTh5RlJPazBY
 MVFSV0VSSTdYSjRPR0pSak8KU2NPdTcyYllBWGFmN1lQRyt2T1M4M20xMGJBK0lMN1FYYUREZUp
 tWG5rczdkMHI4ZFpjVlh4Zmw3T3k3OWVSegpCNmc4Yk1mMm40SVFuTjNvMUFBbTR0ME5qZGRJZH
 FyRUt3OEN4aWRHUjRxR0NOdi90SjhEa1JKTUxNNjdLZkFYCmxScE5Sb0grZ0JXL2hxWlJmNi9TS
 jFIdGxSRlZyMGRpQVVNZks2UzdYUW96WXErQnFoSnZGRjBoTFd4YlJ5VWQKcmlJY0FwRWIwNmxa
 MU9GRi9jdHoxVmRndEVrVVhuNHJTNmxJUkgwcC93SGFFdG5ldkxFaXIxZk1xM210YlpYWAprUjh
 uVnQrd3FUM2wwUi9HMDEyNjg2emhNbUdNSTIvSHY5YzdtTWlEYVpjVDZZUU0vREpxTzVCZVF3Um
 lnazdpCjFQS0hZN25xTExDQnNIcHZ6RXBSRThCMCtJb3BTQ2w5R3VNODM3SnhuaEJTU0p6blN4a
 EFOMVVjajA5NzErd00KTlo0bFUvdHNpYkwwYUFqNExUY0ZrcjVFMU9KbzBmNFBnc2c4L1lWMHQ4
 azY0UEJHZzk1eUREYS8rUEhqN1RhUwo3SEFuYTRuWi9LSVZDVGpKeW9VOThjb0lZNmozYUZaWHh
 PcFFCWmtNcWhHVEZKZjFLOUQ0MWNVOWRCQ2RQQ2hhCkswZTlnZz09Cj04endUCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
  Update since last version: Fix is in upstream llvm, we're awaiting for
  rust upstream to pick it up.

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
 configure                                          |  50 +-
 meson.build                                        |  87 ++-
 rust/wrapper.h                                     |  39 ++
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
 rust/hw/char/pl011/src/device.rs                   | 594 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  59 ++
 rust/hw/char/pl011/src/lib.rs                      | 585 ++++++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs               |  57 ++
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
 scripts/archive-source.sh                          |   5 +-
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
 tests/lcitool/mappings.yml                         |   2 +-
 75 files changed, 2991 insertions(+), 21 deletions(-)
---
base-commit: a733f37aef3b7d1d33bfe2716af88cdfd67ba64e
change-id: 20240814-rust-pl011-v7

Best regards,
-- 
γαῖα πυρί μιχθήτω


