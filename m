Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC11D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kNX-0000i2-QC; Wed, 06 Nov 2024 13:03:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kNW-0000hc-0x
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:03:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kNS-0004gc-21
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730916212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=2vgNv1ztVv+J1anMKGsMpjPS04ULnMmc/GKiexbl4KQ=;
 b=SALkCCck9zwVPk+LsW/n4Wk+KhRYM29KUGzsX23LNLH7/znq09f0YlPTRsRo/mUsYxYVhP
 kL4Wyac0z++9A3jKaf0SYDrla0saKuZtD8dLPa5RWeyO3/+oHly6ZbZNVzRJii6EEs5yZr
 W0QhShYmDNo7mgPexMDJryWgQwu3zKU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-ReINN9W1NUeUCLegYbUa4A-1; Wed, 06 Nov 2024 13:03:30 -0500
X-MC-Unique: ReINN9W1NUeUCLegYbUa4A-1
X-Mimecast-MFC-AGG-ID: ReINN9W1NUeUCLegYbUa4A
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-539e4b7c8f4so5191085e87.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916209; x=1731521009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2vgNv1ztVv+J1anMKGsMpjPS04ULnMmc/GKiexbl4KQ=;
 b=JRiQia3vDGIbVghHpwb53wjBEJMMPdjjTgxVFYMM7Gq5TJEhhkQKIWp/YiJ3Jun9+s
 mS2dpz8i0JDtUbpQMPhEkQ7tyA+IeR+OJSgLJBmihq/dTFTOkh4qsAuS/9hwOcuVlH9N
 PzI1RJPGFQILv6n+QpgBOCErRdpZlbrW7BeCxVHszMYDkU1R35lJvdwZBlPNXw6i3QEG
 4bquX63u0nyJ1eJTMeCgR9ikwW/jxnz2j6cVjS/+SWTPp1fbNfXzK9YrKxyjZI/Whp6m
 gDipkwE5Og8PxwKJde18MfasS8dLxpv7mw+MWyvohaCG9hbFX7vpQVfyfmj/gJ6dRVBN
 b0fg==
X-Gm-Message-State: AOJu0Yzq+6w3u0Sx3vflzjPxrs0MYtzT4mLsYsL49AzWIx8IgnHPVIuh
 i0tg2Wze71/63jys2J4xc05PDCuQfw7r0S2oWKVMNFVB1QLXVrRXn+Y47k08xfeWuce9TEoH8iK
 gGsQB5B0zo6AeulQC6bEaABeM22/63gl9Pu4C9XkkF4LdtaPC53Z83JsQ34dd5cx2w4lO/w1KGt
 7BVSxpqtdhME03ajbdHG5EzYg71ULBhK96E4NPdwI=
X-Received: by 2002:a05:6512:3e25:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-53b3490eab7mr21711378e87.24.1730916208717; 
 Wed, 06 Nov 2024 10:03:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFaGK9FIFVGaOmwtheOT7cg8FKGNgs5AFwtoTNaFYxTgWmNtCWjfLRyXo8TSgx3fbrjquZLJQ==
X-Received: by 2002:a05:6512:3e25:b0:52f:2ea:499f with SMTP id
 2adb3069b0e04-53b3490eab7mr21711329e87.24.1730916207921; 
 Wed, 06 Nov 2024 10:03:27 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6eb003sm33691255e9.37.2024.11.06.10.03.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 10:03:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 00/39] Rust changes for QEMU 9.2 soft freeze
Date: Wed,  6 Nov 2024 19:03:24 +0100
Message-ID: <20241106180325.566170-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit 11b8920ed2093848f79f93d106afe8a69a61a523:

  Merge tag 'pull-request-2024-11-04' of https://gitlab.com/thuth/qemu into staging (2024-11-04 17:37:59 +0000)

are available in the Git repository at:

  tags/for-upstream-rust 

for you to fetch changes up to 951f71ad67bd474aba6925529daf45b747aac86e:

  dockerfiles: install bindgen from cargo on Ubuntu 22.04 (2024-11-06 17:12:17 +0100)

----------------------------------------------------------------
v1->v2: wrap bindgen check with "if have_rust"
	drop ci enablement

Junjie Mao (1):
      rust: introduce alternative implementation of offset_of!

Manos Pitsidianakis (9):
      rust/wrapper.h: define memory_order enum
      Revert "rust: add PL011 device model"
      rust: add PL011 device model
      rust: add definitions for vmstate
      rust/pl011: add support for migration
      rust/pl011: move CLK_NAME static to function scope
      rust/pl011: add TYPE_PL011_LUMINARY device
      rust/pl011: remove commented out C code
      rust/pl011: Use correct masks for IBRD and FBRD

Paolo Bonzini (29):
      qdev: make properties array "const"
      meson: import rust module into a global variable
      meson: remove repeated search for rust_root_crate.sh
      meson: pass rustc_args when building all crates
      rust: do not always select X_PL011_RUST
      rust: do not use --no-size_t-is-usize
      rust: remove uses of #[no_mangle]
      rust: modernize link_section usage for ELF platforms
      rust: build integration test for the qemu_api crate
      rust: cleanup module_init!, use it from #[derive(Object)]
      rust: clean up define_property macro
      rust: make properties array immutable
      rust: provide safe wrapper for MaybeUninit::zeroed()
      rust: do not use TYPE_CHARDEV unnecessarily
      rust/pl011: fix default value for migrate-clock
      rust: patch bilge-impl to allow compilation with 1.63.0
      rust: fix cfgs of proc-macro2 for 1.63.0
      rust: use std::os::raw instead of core::ffi
      rust: introduce a c_str macro
      rust: silence unknown warnings for the sake of old compilers
      rust: synchronize dependencies between subprojects and Cargo.lock
      rust: create a cargo workspace
      rust: do not use MaybeUninit::zeroed()
      rust: clean up detection of the language
      rust: allow version 1.63.0 of rustc
      rust: do not use --generate-cstr
      rust: allow older version of bindgen
      rust: make rustfmt optional
      dockerfiles: install bindgen from cargo on Ubuntu 22.04

 docs/about/build-platforms.rst                     |  12 +
 meson.build                                        | 137 +++++---
 include/hw/qdev-core.h                             |   4 +-
 include/hw/qdev-properties.h                       |   4 +-
 rust/wrapper.h                                     |  17 +
 hw/core/qdev-properties.c                          |  26 +-
 system/qdev-monitor.c                              |   2 +-
 .gitattributes                                     |   2 +
 .gitlab-ci.d/buildtest.yml                         |   2 +-
 meson_options.txt                                  |   2 +
 rust/{hw/char/pl011 => }/Cargo.lock                |   4 +
 rust/Cargo.toml                                    |   7 +
 rust/hw/char/Kconfig                               |   1 -
 rust/hw/char/pl011/Cargo.toml                      |   3 -
 rust/hw/char/pl011/src/device.rs                   | 162 +++++++---
 rust/hw/char/pl011/src/device_class.rs             |  80 ++++-
 rust/hw/char/pl011/src/lib.rs                      |   6 +-
 rust/hw/char/pl011/src/memory_ops.rs               |  24 +-
 rust/qemu-api-macros/Cargo.lock                    |  47 ---
 rust/qemu-api-macros/Cargo.toml                    |   5 +-
 rust/qemu-api-macros/meson.build                   |   2 +-
 rust/qemu-api-macros/src/lib.rs                    | 103 ++++--
 rust/qemu-api/Cargo.lock                           |   7 -
 rust/qemu-api/Cargo.toml                           |  10 +-
 rust/qemu-api/build.rs                             |   9 +
 rust/qemu-api/meson.build                          |  44 ++-
 rust/qemu-api/src/c_str.rs                         |  53 +++
 rust/qemu-api/src/definitions.rs                   |  68 ++--
 rust/qemu-api/src/device_class.rs                  | 114 ++-----
 rust/qemu-api/src/lib.rs                           |  23 +-
 rust/qemu-api/src/offset_of.rs                     | 161 +++++++++
 rust/qemu-api/src/tests.rs                         |  49 ---
 rust/qemu-api/src/vmstate.rs                       | 360 +++++++++++++++++++++
 rust/qemu-api/src/zeroable.rs                      |  86 +++++
 rust/qemu-api/tests/tests.rs                       |  79 +++++
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |   1 -
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |   1 -
 scripts/meson-buildoptions.sh                      |   4 +
 subprojects/bilge-impl-0.2-rs.wrap                 |   1 +
 subprojects/packagefiles/bilge-impl-1.63.0.patch   |  45 +++
 .../packagefiles/proc-macro2-1-rs/meson.build      |   4 +-
 subprojects/packagefiles/syn-2-rs/meson.build      |   1 +
 tests/docker/dockerfiles/ubuntu2204.docker         |   6 +-
 tests/lcitool/mappings.yml                         |   4 +
 tests/lcitool/refresh                              |  11 +-
 45 files changed, 1379 insertions(+), 414 deletions(-)
 rename rust/{hw/char/pl011 => }/Cargo.lock (98%)
 create mode 100644 rust/Cargo.toml
 delete mode 100644 rust/qemu-api-macros/Cargo.lock
 delete mode 100644 rust/qemu-api/Cargo.lock
 create mode 100644 rust/qemu-api/src/c_str.rs
 create mode 100644 rust/qemu-api/src/offset_of.rs
 delete mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/qemu-api/src/vmstate.rs
 create mode 100644 rust/qemu-api/src/zeroable.rs
 create mode 100644 rust/qemu-api/tests/tests.rs
 create mode 100644 subprojects/packagefiles/bilge-impl-1.63.0.patch
-- 
2.47.0


