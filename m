Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14195D59F56
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 18:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8kRh-0003Qh-Gj; Wed, 06 Nov 2024 13:07:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kRc-0003Il-3u
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:07:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t8kRY-0005if-3e
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 13:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730916467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=EDKLBsEuARCAFbhkOtFxiV1kVOGf101ikyFON57bIhk=;
 b=MwkZ3RDbnseQ+5GhEvEFZCyS3hCdtXMV6b49KI4Cw7+2oh27CdrqowOTXDlTRRS9b4mSfO
 H7/do2BdPhH3jxy1WQ7GnM4sPICNK7zsYoCspO9FUmMmDYV/2T2xmEH4xYB6OjJbOiLR5d
 JXaH+up7S2UDgQk5Fi8SmLQ51+8Ee70=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-o4yUJNOaPiSZi_osBU_HNg-1; Wed, 06 Nov 2024 13:07:46 -0500
X-MC-Unique: o4yUJNOaPiSZi_osBU_HNg-1
X-Mimecast-MFC-AGG-ID: o4yUJNOaPiSZi_osBU_HNg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so17137f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 10:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730916464; x=1731521264;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EDKLBsEuARCAFbhkOtFxiV1kVOGf101ikyFON57bIhk=;
 b=MMcHaNeeQwcEznNCUFo5mthJ7gf7WFYSEmfs056qsKEoXUI3pRgMKhe51QYSXezCSK
 HkD9MQcKTrO4G6XkioKpdCfPuFEjy8dYFd8wgnK4qoKACWxj443O2ij4/D9i8EaUoboT
 K8qVv5uqytn3f1/HP5g+WAlRC22LupYv0lzM/EEj/d2eWv5XqbNnY608bl96S7zOTjpl
 707UtGrGGxLGc4HQDZXY3hUP3efGUrpAy+Sf3a9MNnIkjgZMqnXM9ediOUkuzj57ddmZ
 46o0HGm60xRptWVldzuccZNvGHsNSzUhYz6BPAgrL5XUJkqKMsNVx+i6H48u41OOUqh8
 mkCg==
X-Gm-Message-State: AOJu0YwGFr4onAQTiFM9Qclij24fYrfnFUkxBbEvQ87VnUfdsTp7sFq6
 8udcHrIxM7H7o8/REzu9PDTdWBF9jWkCn0tWGQRDPpbXPM4y2FTo+aKswZcbeu9+CANf02Xux/a
 ZypEaXpAT2SfQlDWUcVP4tchpSPrBC54GWvSmKAjh1lDXOiwLziwGgNv4lo6pJYWUYt4csrjGsL
 N2jBHiQr/HislXGgC4D8EnKCOFdawV2y2KqA1VZhc=
X-Received: by 2002:adf:e28a:0:b0:37d:45f0:dd0a with SMTP id
 ffacd0b85a97d-380610f2a9emr28692770f8f.1.1730916464412; 
 Wed, 06 Nov 2024 10:07:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzCxKl50YNI6CqZ0lfZqBH3IbtZjQ7zxOsRoPBSQxsqCdAB51iGplv/5tInWN8JGkYNHtmZA==
X-Received: by 2002:adf:e28a:0:b0:37d:45f0:dd0a with SMTP id
 ffacd0b85a97d-380610f2a9emr28692745f8f.1.1730916463860; 
 Wed, 06 Nov 2024 10:07:43 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10d4991sm19997244f8f.29.2024.11.06.10.07.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 10:07:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 00/39] Rust changes for QEMU 9.2 soft freeze
Date: Wed,  6 Nov 2024 19:07:41 +0100
Message-ID: <20241106180742.567076-1-pbonzini@redhat.com>
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

  https://gitlab.com/bonzini/qemu.git tags/for-upstream-rust

for you to fetch changes up to 951f71ad67bd474aba6925529daf45b747aac86e:

  dockerfiles: install bindgen from cargo on Ubuntu 22.04 (2024-11-06 17:12:17 +0100)

----------------------------------------------------------------
* rust: cleanups
* rust: integration tests
* rust/pl011: add support for migration
* rust/pl011: add TYPE_PL011_LUMINARY device
* rust: add support for older compilers and bindgen
----------------------------------------------------------------
v1->v2: wrap bindgen check with "if have_rust"
	drop ci enablement

v2->v3: fix formatting of pull request

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


