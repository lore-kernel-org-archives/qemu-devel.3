Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E77BC5321D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 08:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shPPB-00049Q-7W; Fri, 23 Aug 2024 04:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPP9-00043m-MH
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:19 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1shPP3-0004mT-Ss
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 04:12:19 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5bed68129a7so2298817a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 01:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724400731; x=1725005531; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rVZ0uWTHj8G8O2Ltl9XvStucg5tWUri+VZpKjzwQJGI=;
 b=xURYon57ESBbJk0tfaibMsJtADfyaTospeOzyNjz+l/q7WUPZzLUPNHVHVy8g4K7qH
 7IV3tcDKcU7CHOhMaEfJXhBPXh2qJ26QPRvQJw3w8qUj2NKy8NJwzeUQzgGxC3VEKR8Y
 PXd5ZxzO0rmdPP6VfS72RoagXz5rw3jI3bmtxy802p2tsEfATe4+EdKk5S1d9Vywz6hc
 mm6reABFSQ5yXMmLT586YsbK/O1VKoTeW1bV89TNz3tqWUNMdqA35JCZ2nD8eyR+yODD
 gYXjz6WOVS5ATUj43jqgjcIyW4emdZmPJCA9t9gZ9WMMI7u3KdiqEI6Xs/POKNpJERCw
 AS4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724400731; x=1725005531;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rVZ0uWTHj8G8O2Ltl9XvStucg5tWUri+VZpKjzwQJGI=;
 b=ueT5nhGx7FJcEL9j4i4PLrt+GzWV5ob1s5qWlx6lROKXJvq5wQLqHRYCNrJiq7nGiy
 kYaWVlnUj7ADfXloN37Me8PhO7IcC76VqJxhylISfkbZpOIy7mEIVvIzoTq2YCXsehIR
 7LoyS1vPNYVEW/3fTFsMEGrntToaRG0D4bNBtFPT+Ct4WzQGzDbK6oGhAbmuc4Yd3hVE
 ILrvXsvRknQw17/jvu/NWOeTLWMxpwTxxrEzcfSJ6Wi6MQ1bjOER/snH9nlQsqmUtjUn
 Rk4YCGVNZzkBfCIz47+6jtlqYzgyFL5faHa+c42l9HIBgepU5lVSrTW3wGStACJRZVX0
 KsAA==
X-Gm-Message-State: AOJu0YxYGQ7z/OYWemZV5s0L7ZFVjah8Sy3vy6hoHmapEJAZL5zIL+F3
 1eazEX+aMOtNu1whlsKN0k+seqZBz9gn5qMR22WVbR75ZrO4XIlyMIHqs+6zyG8=
X-Google-Smtp-Source: AGHT+IEX1HINsQoESrmegO7yoaXDglI4kW5jFZaUsmEVHnLFmU8t7uUvYCBFz9bxXdzCQPW6f32T4A==
X-Received: by 2002:a17:907:3ea2:b0:a86:6b97:d95c with SMTP id
 a640c23a62f3a-a86a54f2bdfmr87839866b.67.1724400731060; 
 Fri, 23 Aug 2024 01:12:11 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a868ee6b390sm223620066b.0.2024.08.23.01.12.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 01:12:10 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v8 0/8] Add Rust build support, ARM PL011 device impl
Date: Fri, 23 Aug 2024 11:11:48 +0300
Message-Id: <20240823-rust-pl011-v8-0-b9f5746bdaf3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAEREyGYC/1WMQQqDMBBFryKz7pREDcaueo/iQtqpDkgiEysVy
 d0dhC66fJ//3g6JhCnBrdhBaOXEMSj4SwHPsQ8DIb+UoTRlbbytUT5pwXky1uLagN5moTd/z8S
 jUx45LVG2s6gPXX+y+5fRYNs4Wzlqva/sfeLQS7xGGaDLOR+gUBMfmwAAAA==
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
 Zhao Liu <zhao1.liu@intel.com>
X-Mailer: b4 0.15-dev-b8758
X-Developer-Signature: v=1; a=openpgp-sha256; l=7367;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=rUKeEO3+gIEqbG0m+Hzk6avbDVGIA83ZPa8P49IDSsc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm15RVJYMndobmRPM0cwRUVLQXRDWjlzMS9haXNtCi9FdGdMSkZUeG9BZ3JRK1Y3
 MCtKQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnNoRVZ3QUt
 DUkIzS2Nkd2YzNEowR2RsRC85QkZST3l3UUFuWWRDa05SN09XRTV3SGxqN3JBcEtwM01DMXFOVQ
 pzOVRBallNR3RCcFRoeXQ3U214T2FiVE5UWkEyelNhc0E4bER1aUpMS042ejZqQk52SEZhWUJ1Q
 VF4aGFLbVJKClo1Rnd0M2tYaEsxbnNmSXhPNStJLzFaUEdiMHBFK1FnU3lpNHRCQjQrMGVwYnBS
 MGY2aUQxQ1ZBYngyNXR4TkoKeVQ3aW95Tm1BMDllbnk0d3F3RzZkby9NNFlNUGtmSkNKZEFIamF
 ZaytKQnRqeU15UElML3pwaXdtZ1AwZlh4WQpOZ291enJDVTQwZmJxTHdERDkyUEMrUlpyRUxvZH
 hJbmdQenZPcW9aUG51dDVNL0pmUW54aHI3WnEvVmREWXhsCnB4R3J4aDQrQk9rZWdTcGozWUFFZ
 0p5NlppRHEvN3EzYU5Ic3dWbzB4T3h1TW9RQWx3cXZBL2hJcVB3ZlZzNXoKVGh4dUpHc0EzUXNo
 R1N0dGFtNmJEVSs1VFRTeU5mYksrNmlqem9YenBTNGJRUEFHdkRYU0VtY2JyMlY0bnEzcgpJaU4
 yc2hZQVVvcXkyWmVRbzRIRzJTL0RLMGQ2TEl0Z2UzbGJoZUxBa2RjbDlrbThUN2laWDYrWGYwd3
 BGZUlSCjlhRTkrdE9UcS9NYVYvOUxYL0ZpdS8rb3h2ck9hMzJNZDVDeno4dm02bGpBcEZwZjVOR
 3hQaEFqQ1IxQnZ5MmIKT2M5WE5OZi81VVBNOVM3Mmd5TWVYbnZTN0xvWWd6MDBtam9KK3o5L2cz
 K3hNdndqZitlWWhGVVZYbk50bmdjaAo4bFhKVlE5NlgyYy9yeGd6UUdUai96NGlNc3VSekZQZW0
 rdW52ZDl4bmRrQkVVSExDQWsyVWRQbnpDVXZNRlBKClZsTFc3UT09Cj1XQi96Ci0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01, URIBL_CSS_A=0.1 autolearn=ham autolearn_force=no
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
Manos Pitsidianakis (6):
      build-sys: Add rust feature option
      rust: add bindgen step as a meson dependency
      .gitattributes: add Rust diff and merge attributes
      rust: add crate to expose bindings and interfaces
      rust: add utility procedural macro crate
      rust: add PL011 device model

Paolo Bonzini (2):
      Require meson version 1.5.0
      configure, meson: detect Rust toolchain

 MAINTAINERS                                        |  21 +
 configure                                          |  50 +-
 meson.build                                        |  83 ++-
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
 rust/hw/char/pl011/rustfmt.toml                    |   1 +
 rust/hw/char/pl011/src/definitions.rs              |  20 +
 rust/hw/char/pl011/src/device.rs                   | 592 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  59 ++
 rust/hw/char/pl011/src/lib.rs                      | 585 ++++++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs               |  57 ++
 rust/hw/meson.build                                |   1 +
 rust/meson.build                                   |   4 +
 rust/qemu-api-macros/Cargo.lock                    |  47 ++
 rust/qemu-api-macros/Cargo.toml                    |  25 +
 rust/qemu-api-macros/README.md                     |   1 +
 rust/qemu-api-macros/meson.build                   |  25 +
 rust/qemu-api-macros/src/cstr/mod.rs               |  55 ++
 rust/qemu-api-macros/src/cstr/parse.rs             | 225 ++++++++
 rust/qemu-api-macros/src/lib.rs                    |  43 ++
 rust/qemu-api/.gitignore                           |   2 +
 rust/qemu-api/Cargo.lock                           |   7 +
 rust/qemu-api/Cargo.toml                           |  26 +
 rust/qemu-api/README.md                            |  17 +
 rust/qemu-api/build.rs                             |  14 +
 rust/qemu-api/meson.build                          |  23 +
 rust/qemu-api/rustfmt.toml                         |   1 +
 rust/qemu-api/src/definitions.rs                   | 109 ++++
 rust/qemu-api/src/device_class.rs                  | 128 +++++
 rust/qemu-api/src/lib.rs                           | 102 ++++
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
 79 files changed, 3214 insertions(+), 21 deletions(-)
---
base-commit: a733f37aef3b7d1d33bfe2716af88cdfd67ba64e
change-id: 20240814-rust-pl011-v7

Best regards,
-- 
γαῖα πυρί μιχθήτω


