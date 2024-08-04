Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F220C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiP2-0008CX-QA; Sun, 04 Aug 2024 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiP1-00089T-7m
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:31 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1saiOx-0005dN-4i
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:04:30 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a20de39cfbso12522083a12.1
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722805465; x=1723410265; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=m5mzlhmsZ0UU/pS+QsoVVHEDq/DQtXz3GE5fOsjGfrg=;
 b=aaQhAMLtqyo3w+F9O6pCZPU8zkkvh9WTN77PPAbxr4XBrYiNUXY3wSUk+c0HNJSP5e
 0jyg9Ie4gg9jZ5aZIhq2It2OCTSpi2/HjCwav9k+r7dcbJKW6rd9E4f84HAoxhgoy4C4
 tR/Q/hTVwin3+YvurpWW6d8GE0OtbObP4ogdqjgys9XIdclEBW0yJkLzj1lac+C6Q4ed
 M8jnJR7FpofomcGCI48t0KmjJz4mD/H+3qqsiN/eE/hmp2B+omnejjxxzWqatywzPfCn
 XxqTzSHlqX0wNvEgJMoX/dVjyBNKqzsauhQFbVouQl7AWjmYiXmUbgRW2sCdbYaB3rej
 Gpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722805465; x=1723410265;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m5mzlhmsZ0UU/pS+QsoVVHEDq/DQtXz3GE5fOsjGfrg=;
 b=Nonp3HL2pe8YDS8WIm3HTlGlA4KQmbyOgrM2ZokSuZEb+qh5Wlu8Je8TAIl2uBBXBK
 miF+iBdkHvynxtD3v319jIrn30rKAJqpkvuaUuvW5YBdlyCEN6j78o0YBHURO7S2MTdE
 2FLlNaLsz8Hk27nQpfvhJYWbK3KMRG98vuQPURiWmQPE7RdbiDKvcMMdzhnKG5PBEdQs
 /LLaJ03oTC161YwcZY6RP/kj0/6utWlrIMAkFC3OrWcoGN2euG94elCxV5zpeO2DrVXA
 XAvojMAwGR8fa37kjkK5XGsuX+wNKfA4LAov9LN+wbR6UDHl4kAgD9MxB7IHdAaSziwc
 BraA==
X-Gm-Message-State: AOJu0YxkYo5EUjNMFmwarlHtq9U9SYq/ZacTZMBYMbk6Q1m1PAE1gEZs
 MvEXSANXcFr1HuPhChH8m9jsPOaYGo9bQ1PeXVYJ8KS877GZLJOLoeOYolHgs7FcZmb8GFROPwM
 9dS4=
X-Google-Smtp-Source: AGHT+IGF2Gk9+bFMLGfRNEkDpi3eMGEeBD776AsHu2/LwWlDqL2khAjQkqRAkObzyw31V58odFiItw==
X-Received: by 2002:a17:906:ee85:b0:a72:8762:1f5d with SMTP id
 a640c23a62f3a-a7dc507f309mr679399666b.55.1722805464529; 
 Sun, 04 Aug 2024 14:04:24 -0700 (PDT)
Received: from localhost.localdomain (adsl-146.37.6.160.tellas.gr.
 [37.6.160.146]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d437a5sm366348766b.101.2024.08.04.14.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Aug 2024 14:04:24 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH v6 0/5] rust-pl011-rfc-v6
Date: Mon,  5 Aug 2024 00:04:11 +0300
Message-ID: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x535.google.com
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

Changes
=======

- Setting MSRV to 1.77.0:
  * cstr crate MSRV is 1.64, which is more recent than Debian bookworm
    (1.63.0) <https://github.com/upsuper/cstr/blob/master/Cargo.toml>

  * pl011's dependencies (mostly proc-macro2) don't support 1.63.0

- Dropped CI/lcitool patches.

- Dropped vendored dependencies in favor of meson subprojects.

- Added a qom ObjectImpl trait and declaration macros

- Added # SAFETY comments.

- Changed configure flag to --{enable,disable}-rust

Manos Pitsidianakis (5):
  build-sys: Add rust feature option
  rust: add bindgen step as a meson dependency
  .gitattributes: add Rust diff and merge attributes
  rust: add crate to expose bindings and interfaces
  rust: add PL011 device model

 MAINTAINERS                                   |  20 +
 configure                                     |   2 +
 meson.build                                   |  77 ++-
 rust/wrapper.h                                |  39 ++
 .gitattributes                                |   3 +
 Kconfig                                       |   1 +
 Kconfig.host                                  |   3 +
 hw/arm/Kconfig                                |  33 +-
 meson_options.txt                             |   3 +
 rust/.gitignore                               |   3 +
 rust/Kconfig                                  |   1 +
 rust/hw/Kconfig                               |   2 +
 rust/hw/char/Kconfig                          |   3 +
 rust/hw/char/meson.build                      |   1 +
 rust/hw/char/pl011/.gitignore                 |   2 +
 rust/hw/char/pl011/Cargo.lock                 | 125 ++++
 rust/hw/char/pl011/Cargo.toml                 |  26 +
 rust/hw/char/pl011/README.md                  |  31 +
 rust/hw/char/pl011/meson.build                |  28 +
 rust/hw/char/pl011/rustfmt.toml               |   1 +
 rust/hw/char/pl011/src/definitions.rs         |  26 +
 rust/hw/char/pl011/src/device.rs              | 586 ++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs        |  58 ++
 rust/hw/char/pl011/src/lib.rs                 | 584 +++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs          |  56 ++
 rust/hw/meson.build                           |   1 +
 rust/meson.build                              |  15 +
 rust/qemu-api/.gitignore                      |   2 +
 rust/qemu-api/Cargo.lock                      |   7 +
 rust/qemu-api/Cargo.toml                      |  23 +
 rust/qemu-api/README.md                       |  17 +
 rust/qemu-api/build.rs                        |  13 +
 rust/qemu-api/meson.build                     |  19 +
 rust/qemu-api/rustfmt.toml                    |   1 +
 rust/qemu-api/src/bindings.rs                 |   7 +
 rust/qemu-api/src/definitions.rs              | 108 ++++
 rust/qemu-api/src/device_class.rs             | 128 ++++
 rust/qemu-api/src/lib.rs                      | 100 +++
 rust/qemu-api/src/tests.rs                    |  48 ++
 rust/rustfmt.toml                             |   7 +
 scripts/meson-buildoptions.sh                 |   3 +
 scripts/rustc_args.py                         |  84 +++
 subprojects/.gitignore                        |  11 +
 subprojects/arbitrary-int.wrap                |   9 +
 subprojects/bilge-impl.wrap                   |  10 +
 subprojects/bilge.wrap                        |  10 +
 subprojects/either.wrap                       |  10 +
 subprojects/itertools.wrap                    |  10 +
 .../packagefiles/arbitrary-int/meson.build    |  19 +
 .../packagefiles/bilge-impl/meson.build       |  36 ++
 subprojects/packagefiles/bilge/meson.build    |  25 +
 subprojects/packagefiles/either/meson.build   |  21 +
 .../packagefiles/itertools/meson.build        |  25 +
 .../proc-macro-error-attr/meson.build         |  27 +
 .../packagefiles/proc-macro-error/meson.build |  32 +
 .../packagefiles/proc-macro2/meson.build      |  26 +
 subprojects/packagefiles/quote/meson.build    |  25 +
 subprojects/packagefiles/syn/meson.build      |  33 +
 .../packagefiles/unicode-ident/meson.build    |  19 +
 subprojects/proc-macro-error-attr.wrap        |  10 +
 subprojects/proc-macro-error.wrap             |  11 +
 subprojects/proc-macro2.wrap                  |  10 +
 subprojects/quote.wrap                        |  10 +
 subprojects/syn.wrap                          |  11 +
 subprojects/unicode-ident.wrap                |  10 +
 65 files changed, 2695 insertions(+), 12 deletions(-)
 create mode 100644 rust/wrapper.h
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
 create mode 120000 rust/hw/char/pl011/rustfmt.toml
 create mode 100644 rust/hw/char/pl011/src/definitions.rs
 create mode 100644 rust/hw/char/pl011/src/device.rs
 create mode 100644 rust/hw/char/pl011/src/device_class.rs
 create mode 100644 rust/hw/char/pl011/src/lib.rs
 create mode 100644 rust/hw/char/pl011/src/memory_ops.rs
 create mode 100644 rust/hw/meson.build
 create mode 100644 rust/meson.build
 create mode 100644 rust/qemu-api/.gitignore
 create mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/Cargo.toml
 create mode 100644 rust/qemu-api/README.md
 create mode 100644 rust/qemu-api/build.rs
 create mode 100644 rust/qemu-api/meson.build
 create mode 120000 rust/qemu-api/rustfmt.toml
 create mode 100644 rust/qemu-api/src/bindings.rs
 create mode 100644 rust/qemu-api/src/definitions.rs
 create mode 100644 rust/qemu-api/src/device_class.rs
 create mode 100644 rust/qemu-api/src/lib.rs
 create mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/rustfmt.toml
 create mode 100644 scripts/rustc_args.py
 create mode 100644 subprojects/arbitrary-int.wrap
 create mode 100644 subprojects/bilge-impl.wrap
 create mode 100644 subprojects/bilge.wrap
 create mode 100644 subprojects/either.wrap
 create mode 100644 subprojects/itertools.wrap
 create mode 100644 subprojects/packagefiles/arbitrary-int/meson.build
 create mode 100644 subprojects/packagefiles/bilge-impl/meson.build
 create mode 100644 subprojects/packagefiles/bilge/meson.build
 create mode 100644 subprojects/packagefiles/either/meson.build
 create mode 100644 subprojects/packagefiles/itertools/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error-attr/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro-error/meson.build
 create mode 100644 subprojects/packagefiles/proc-macro2/meson.build
 create mode 100644 subprojects/packagefiles/quote/meson.build
 create mode 100644 subprojects/packagefiles/syn/meson.build
 create mode 100644 subprojects/packagefiles/unicode-ident/meson.build
 create mode 100644 subprojects/proc-macro-error-attr.wrap
 create mode 100644 subprojects/proc-macro-error.wrap
 create mode 100644 subprojects/proc-macro2.wrap
 create mode 100644 subprojects/quote.wrap
 create mode 100644 subprojects/syn.wrap
 create mode 100644 subprojects/unicode-ident.wrap


base-commit: f9851d2ffef59b3a7f39513469263ab3b019480f
-- 
γαῖα πυρί μιχθήτω


