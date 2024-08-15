Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE40AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYsW-0007zG-T2; Thu, 15 Aug 2024 07:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsV-0007s9-6t
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:51 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1seYsP-0002CN-TZ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:42:50 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso335790566b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 04:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723722162; x=1724326962; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tlsu0qGMv6O7En1OrJqhhlVtFK2e6Mp/EHWWu8yMIlU=;
 b=WDS5ZzBVdQtawRCYrKoYGsw7L6LMVSZ3MIejzpgLvJC2A8tFzcIbKlQ3RLhwSOMJ8E
 zhXfhDkRY6XuRNnemHZ6aBEaK80c+oGhJVLInqCTZjsHtshliQwLgZZT/Itou5FO7iPd
 VKlQ6ySZp5FyWFtZkhb4OROKyBGFPsZc5MbvFL+HuoFgLFZqddhhKZmYrBnWb9xxrmS3
 ihM6kdW/bIfGJdslYAw7jttol8z22biExrJeYhgbYWghXgQNkOoFBOKaENQjxgnrvl/F
 5i5/jIv3gn9X+Qd70/J4DBGthWbEClSryW9SpcSeErk/Y9j8zImH+l0mTSnzVVLPyYn1
 jCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723722162; x=1724326962;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tlsu0qGMv6O7En1OrJqhhlVtFK2e6Mp/EHWWu8yMIlU=;
 b=CfnQ3mmd2JL5mHHv4+B3VzPkGNN01oyqMV2v7SQB8S6VI7+y/iZdiiCDJIJ4nMf67j
 TYp5oay9MdyIUh25YV6AVYkPO/QOZxKnuMA+RK1ZrScX/2lFWPUNwKCcWivTr32iVD8b
 o/V6db2UzWWZN8xRpSHXJbq8X6sZBXwTYeYn0oxj0ijOXtijHPLdAxgpD+wvzs7eHCdx
 p7V8jn68gtzlD/US40/hp2extBrT3wOJKu5Rw539eRhAWniBQfO7FIh3gUE2JVmIXe10
 L1WcTcQhoon7QlbAgChNZapybwmEPHkGvqhC9VDtXFGXMMt98plBq9/uRYr7Rvx4DWSX
 e0kA==
X-Gm-Message-State: AOJu0YzwPaKn2qF28+jhJcpERBDNDGMuY9XrXloXDkbScsjs8kGJMT1a
 nkUAecCI13Ne9fKeJNCfhFk9nwWQEYaxXibHLRyYas7AjDfl6ou92wCJ5RXh0BY=
X-Google-Smtp-Source: AGHT+IEk/cY7R5Lr/KG3AXzDZAwWIKdTwoc+NpYQzxYPRvSU/CaldEeLz4uQDse3/4eAggmaYMZGbA==
X-Received: by 2002:a17:907:9803:b0:a80:f67f:771b with SMTP id
 a640c23a62f3a-a837cbcce2fmr233224166b.2.1723722162225; 
 Thu, 15 Aug 2024 04:42:42 -0700 (PDT)
Received: from [127.0.1.1] (adsl-26.37.6.162.tellas.gr. [37.6.162.26])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a83838c6bf1sm89547966b.21.2024.08.15.04.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 04:42:41 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v7 0/7] Add Rust build support, ARM PL011 device impl
Date: Thu, 15 Aug 2024 14:42:17 +0300
Message-Id: <20240815-rust-pl011-v7-0-975135e98831@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJnpvWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC0MT3aLS4hLdghwDQ0PdMnMloLKCotS0zAqwEdGxtbUAylIqiFIAAAA
 =
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Beraldo Leal <bleal@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 ARM TCG CPUs <qemu-arm@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Junjie Mao <junjie.mao@intel.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gustavo Romero <gustavo.romero@linaro.org>, rowan.hart@intel.com, 
 Mads Ynddal <mads@ynddal.dk>, Markus Armbruster <armbru@redhat.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6866;
 i=manos.pitsidianakis@linaro.org; h=from:subject:message-id;
 bh=8Ad7RZkkTNKg+j+NV/utO/cwg7A7+51TNpgYAnr4D5A=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0VCYlFLUy9aQU5Bd0FLQVhjcHgzQi9mZ
 25RQWNzbVlnQm12ZW10NmUxWkFQL20yRHd0WVk4V3A2U3drUVI0ClFJRTJIeklOODYyc095UHBH
 NG1KQWpNRUFBRUtBQjBXSVFUTVhCdE9SS0JXODRkd0hSQjNLY2R3ZjM0SjBBVUMKWnIzcHJRQUt
 DUkIzS2Nkd2YzNEowTFRZRC80d0I3UkhubUNXTFFCelJXWUovS0dLSlFHaXZTSUNSSDJ6TlF2Rw
 ptR2l4bHkyWWJtL25Jc05uNmdOdk51QUxFZ2N1ZURUSFd6VHN0Y29qTjdXUkxEdVUwSTdtMElnZ
 W1ESlFXc05ECjRoZE45bCsxdk02QmRBQlVSVG1MdThyVEovdjRzNmpyeDRHaVVPSWJwWTc5S1lh
 b1pSUzVGaUppcmQxcUFQUjAKdjFibUZxdjZ0WjRlY2xpTWdoMys2bkpwWkVvMXV0eHBkWEJtMTZ
 FRFIzaHhmSDJEc1cweXdPZ0pCbmVQT2FyaQpkQUY5QlVzY2VoRzBaQkhSY3JOSFpPMFB1ejJEWW
 RwNVRrVS9zOFpoWklZeWtzYTEweEU2cnBsanplenZ6Y1U2CnIwdmk1Uy94MG1rZFNNMHEzczkyS
 HZNdzNnV1VWNXljRzZQZDZ0ZXVKbWNZKzJzWkR5TkdRQXBuM094QVUwTzcKVzlJV01SaDJHWGNW
 L1d4MXpPck83NkpsbFIxcWtzbk5sR3BOTkk2cHd3YmVpZm5GcUVJazNtZjdCSVZBWkxqLwp1a1h
 rV1ZkUW16eXJzcjhZbkRkUUpsMUVqQXljSE9BejVVZDBHY1NoUjFVczArK3FNYXBSOFB6Q2p6Wl
 ZvakpOClJHV2FQMDd0VEZZcHFEcHVnNmpCL3FRSVVvZ1ltT09La29zeGQzd0MxQnNsanpHUDM4c
 ldOeEw2RWZObEd1blkKWDVhRkFSbERYak5wRDVDNWRrT2orU3NCMzc4UnpNWk9VNFNGZkhobVVG
 aVo1b1ExS1BZOENmV2NZSkszYSsyZApLdkxtK3ROc2VNUXZhZ0hUc0tPTkwwUGxvT09UYitoMmk
 xelFzTE1ma2JxdDYzbU5ycHc1VkFhb05aNG0zUUpCCkNrVDVKQT09Cj04Qm1DCi0tLS0tRU5EIF
 BHUCBNRVNTQUdFLS0tLS0K
X-Developer-Key: i=manos.pitsidianakis@linaro.org; a=openpgp;
 fpr=7C721DF9DB3CC7182311C0BF68BC211D47B421E1
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

- Incorporated changes by Paolo Bonzini and Junjie Mao as a result of
  discussion on the previous patch series version
- Included two squash patches from
  <20240814090820.1251026-1-junjie.mao@intel.com>
  Junjie Mao (2):
    meson: subprojects: Specify Rust edition by rust_std=20XX
    rust: Specify Rust edition by rust_std=20XX

Outstanding issues
==================

Outstanding issues that are not blocking for merge are:

- Cross-compilation for aarch64 is not possible out-of-the-box because of this bug:
  <https://github.com/rust-lang/rust/issues/125619> in llvm which when
  fixed, must be ported to upstream rust's llvm fork. Since the problem
  is an extraneous symbol we could strip it with objcopy -N|--strip-symbol
- Adding more than one Rust device ends up with duplicate symbols from
  rust std library because we are linking as whole archives because...
  constructors are stripped by the linker otherwise :( It can be worked
  around if a single Rust library is built with all the devices as
  dependencies which is then linked to qemu. The fix is a small change
  which I will add either in a next version or when a new Rust device is
  added.

Previous version was: <rust-pl011-rfc-v6.git.manos.pitsidianakis@linaro.org>

---
Hello everyone,

This series adds:

- build system support for the Rust compiler
- a small Rust library, qemu-api, which includes bindings to QEMU's C
  interface generated with bindgen
- a proof of concept ARM PL011 device implementation in Rust, chosen for
  its low complexity. The device is used in the arm virt machine if qemu
  is compiled with rust enabled (./configure --enable-rust [...])

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

---
Manos Pitsidianakis (5):
      build-sys: Add rust feature option
      rust: add bindgen step as a meson dependency
      .gitattributes: add Rust diff and merge attributes
      rust: add crate to expose bindings and interfaces
      rust: add PL011 device model

Paolo Bonzini (2):
      Require meson version 1.5.0
      configure, meson: detect Rust toolchain

 MAINTAINERS                                        |  20 +
 configure                                          |  50 +-
 meson.build                                        |  77 ++-
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
 rust/hw/char/pl011/Cargo.lock                      | 125 +++++
 rust/hw/char/pl011/Cargo.toml                      |  26 +
 rust/hw/char/pl011/README.md                       |  31 ++
 rust/hw/char/pl011/meson.build                     |  21 +
 rust/hw/char/pl011/rustfmt.toml                    |   1 +
 rust/hw/char/pl011/src/definitions.rs              |  26 +
 rust/hw/char/pl011/src/device.rs                   | 586 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  58 ++
 rust/hw/char/pl011/src/lib.rs                      | 584 ++++++++++++++++++++
 rust/hw/char/pl011/src/memory_ops.rs               |  56 ++
 rust/hw/meson.build                                |   1 +
 rust/meson.build                                   |  11 +
 rust/qemu-api/.gitignore                           |   2 +
 rust/qemu-api/Cargo.lock                           |   7 +
 rust/qemu-api/Cargo.toml                           |  23 +
 rust/qemu-api/README.md                            |  17 +
 rust/qemu-api/build.rs                             |  13 +
 rust/qemu-api/meson.build                          |  17 +
 rust/qemu-api/rustfmt.toml                         |   1 +
 rust/qemu-api/src/bindings.rs                      |   7 +
 rust/qemu-api/src/definitions.rs                   | 108 ++++
 rust/qemu-api/src/device_class.rs                  | 128 +++++
 rust/qemu-api/src/lib.rs                           | 100 ++++
 rust/qemu-api/src/tests.rs                         |  48 ++
 rust/rustfmt.toml                                  |   7 +
 scripts/archive-source.sh                          |   5 +-
 scripts/make-release                               |   5 +-
 scripts/meson-buildoptions.sh                      |   3 +
 scripts/rustc_args.py                              |  84 +++
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
 72 files changed, 2756 insertions(+), 21 deletions(-)
---
base-commit: a733f37aef3b7d1d33bfe2716af88cdfd67ba64e
change-id: 20240814-rust-pl011-v7

Best regards,
--
γαῖα πυρί μιχθήτω


