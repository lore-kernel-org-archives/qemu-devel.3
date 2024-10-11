Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C697D0EE12
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:13:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJ52-0001ob-SU; Fri, 11 Oct 2024 13:05:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szJ4U-0000hD-PM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:04:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1szHd6-0007Bb-Pu
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 11:32:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728660754;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PDI/Jyc7U0oyvHlOl2zTUGj1FkMab/cE0ZBkgHXlfOc=;
 b=J6TRa4kl1D2oh9u8VJxGcQPVKFRdatpuTOFJJUWOZs50m4CMKjg9idpboLuegfWo3s/OOk
 iGoQSUsvPYSgEWYJx9CCSgkyaALu370Moc3f1Fn6lfmYnjmAs2F3WXhlm+WjGQmc+f+EcN
 BqeZBwlRE8rlu7CxVoabF8JhKIZg4zg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-ElapTMr_NQexuPWfKwGcIg-1; Fri, 11 Oct 2024 11:32:32 -0400
X-MC-Unique: ElapTMr_NQexuPWfKwGcIg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5c9338a16cdso2372772a12.0
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 08:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728660751; x=1729265551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PDI/Jyc7U0oyvHlOl2zTUGj1FkMab/cE0ZBkgHXlfOc=;
 b=nxoYUSfvmU3m3bQi3FSw3nMTvonNhtK3nQViZB8r1/6t5uBQNTtl1X4FM5EI3lpANk
 SHfUG906Vx55JrqltEHhNV5Kg65jjddO0kY7+wbs6lr9GYSdPCcLCKuMVTV8Ca9JXSs6
 kSVPowIbj4zsosa/QYvl1SJut+qt+Xcvh8h43/PLnBnZlDcDav4IArSyH3ZbHqx2jMmD
 qSf/zeW8qBeDvWZX8Lsi2HxvxHw19iqSUY08P8w1kEwlmq1bYvBzwqLptdUCDJIQfs8c
 XOPKQ0zlCPnxzvRyanK6Bh0k00N85YkA+CJm9n4OPbIUD8laq1TN9ugSFiFashpa9Vrb
 PuVQ==
X-Gm-Message-State: AOJu0YykhIarjKlgF3ezgJABCTxX5hjsb5+7g1vnAIskqZZW7C2Mrbcf
 g3+udwq1Jp3JVEnltr5tpDlvqbsvTZ8G7YpEs0Q7B2cPks98gKa+EugSzBe4LvcrXqpiSXhWLmV
 TOwr9r32n7xj5h8LOgMXYSZlBbNXJ5AnjPQSFi+WUgg2gXwYcA6/aRfbIEPzqhTdHpDkSVdcnY2
 lqJKS7eX67uCzKnEhrfPrs63b9DfBMPhOuQhS1J9g=
X-Received: by 2002:a05:6402:1d48:b0:5c5:cb7f:e56a with SMTP id
 4fb4d7f45d1cf-5c93353c96fmr7068473a12.1.1728660751113; 
 Fri, 11 Oct 2024 08:32:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXPG0bNtyxLYAHlROzDfH901ArxuPiQg8UkezZWsGVC/Sr2xF/nOKCRc8rtxPJlthtWgNrvg==
X-Received: by 2002:a05:6402:1d48:b0:5c5:cb7f:e56a with SMTP id
 4fb4d7f45d1cf-5c93353c96fmr7068437a12.1.1728660750360; 
 Fri, 11 Oct 2024 08:32:30 -0700 (PDT)
Received: from avogadro.local ([151.81.124.37])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c93711ab3asm2038475a12.30.2024.10.11.08.32.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 08:32:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/18] Rust initial PoC + meson changes for 2024-10-07
Date: Fri, 11 Oct 2024 17:32:08 +0200
Message-ID: <20241011153227.81770-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit b5ab62b3c0050612c7f9b0b4baeb44ebab42775a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2024-10-04 19:28:37 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 381d2c36e1242f849a55f4622e50b9a69cb92842:

  docs: use consistent markup for footnotes (2024-10-11 13:08:32 +0200)

v2->v3: new patches
- scripts/archive-source: find directory name for subprojects
- docs: fix invalid footnote syntax
- docs: avoid footnotes consisting of just URLs
- docs: use consistent markup for footnotes

----------------------------------------------------------------
* first commit for Rust support
* add CI job using Fedora + Rust nightly
* fix detection of ATOMIC128 on x86_64
* fix compilation with Sphinx 8.1.0

----------------------------------------------------------------
Manos Pitsidianakis (6):
      build-sys: Add rust feature option
      rust: add bindgen step as a meson dependency
      .gitattributes: add Rust diff and merge attributes
      meson.build: add HAVE_GLIB_WITH_ALIGNED_ALLOC flag
      rust: add crate to expose bindings and interfaces
      rust: add utility procedural macro crate

Paolo Bonzini (11):
      Require meson version 1.5.0
      configure, meson: detect Rust toolchain
      scripts/archive-source: find directory name for subprojects
      rust: add PL011 device model
      meson: define qemu_isa_flags
      meson: ensure -mcx16 is passed when detecting ATOMIC128
      dockerfiles: add a Dockerfile using a nightly Rust toolchain
      gitlab-ci: add Rust-enabled CI job
      docs: fix invalid footnote syntax
      docs: avoid footnotes consisting of just URLs
      docs: use consistent markup for footnotes

Pierrick Bouvier (1):
      meson: fix machine option for x86_version

 MAINTAINERS                                        |  21 +
 docs/devel/atomics.rst                             |   6 +-
 docs/devel/build-system.rst                        |   6 +-
 docs/devel/loads-stores.rst                        |   2 +-
 docs/devel/maintainers.rst                         |   4 +-
 docs/devel/migration/mapped-ram.rst                |   4 +-
 docs/devel/testing/acpi-bits.rst                   |  26 +-
 docs/specs/fw_cfg.rst                              |   4 +-
 docs/specs/rapl-msr.rst                            |  25 +-
 configure                                          | 170 +++++-
 meson.build                                        | 158 +++++-
 rust/wrapper.h                                     |  47 ++
 .gitattributes                                     |   3 +
 .gitlab-ci.d/buildtest.yml                         |  13 +
 .gitlab-ci.d/containers.yml                        |   6 +
 Kconfig                                            |   1 +
 Kconfig.host                                       |   3 +
 hw/arm/Kconfig                                     |  30 +-
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
 rust/hw/char/pl011/src/device.rs                   | 599 +++++++++++++++++++++
 rust/hw/char/pl011/src/device_class.rs             |  70 +++
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
 rust/qemu-api/src/definitions.rs                   |  97 ++++
 rust/qemu-api/src/device_class.rs                  | 128 +++++
 rust/qemu-api/src/lib.rs                           | 166 ++++++
 rust/qemu-api/src/tests.rs                         |  49 ++
 rust/rustfmt.toml                                  |   7 +
 scripts/archive-source.sh                          |  29 +-
 scripts/make-release                               |   6 +-
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
 .../docker/dockerfiles/fedora-rust-nightly.docker  | 173 ++++++
 tests/docker/dockerfiles/opensuse-leap.docker      |   2 +-
 tests/lcitool/mappings.yml                         |   2 +-
 tests/lcitool/refresh                              |  26 +
 88 files changed, 3474 insertions(+), 75 deletions(-)
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
 create mode 100644 tests/docker/dockerfiles/fedora-rust-nightly.docker
-- 
2.46.2


