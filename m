Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0199D3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5QlW-0000j1-EC; Mon, 28 Oct 2024 10:30:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qke-00009t-OV
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkc-0003hD-LP
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nqiLFkv/I80giblOsTrIr8vNMTqkspLd18qhJyUFZ1M=;
 b=FoT0ArQ7Y74ScXve2i5XloiM1xgcSJTB5xRhDep7NBFIT3/2Z1lr9Jp0+jCczdIn7vnpKq
 AZflDAjDYhIvViCGo/YTtoeL/RTd/HJq0r0IEun/OXd2JZCIJQJ2ujWjorL3yowEVOKTfV
 d7URFK0n4FI8CWKF/Tc16wtAQgKm4ic=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-_nFcJJDIMm2zTKQvHJLxag-1; Mon, 28 Oct 2024 10:29:36 -0400
X-MC-Unique: _nFcJJDIMm2zTKQvHJLxag-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d45f1e935so2482660f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125774; x=1730730574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nqiLFkv/I80giblOsTrIr8vNMTqkspLd18qhJyUFZ1M=;
 b=SnzefTpgjzjIY+tcrmmnUh+g4OHNfdcV6rkoaL9oDuS/RmD6k5PfdUQkrSSDsvIot6
 n1EcZZs2z+DeUDhRJ1VthAkoHYO1Y1LdhWYMPbUO8RkP5hFBpS/aH42Qv29MACjWkaNF
 fcWRGUld/hEwL0BrB/4NJnRSEqs/WKlT44uqe+J/3oMbKOi1OVMmLexfjM7kBfGnN0Ev
 zjTKsCc4FF2T8bH6sez+H45tAi1+axBIlb04AioiBGDecZgoIqY0bAG8evWnyxUkLkR7
 U5/SwaJFNou6Ky4DYS4r9nwc5z2RhSOHHzr9mQPsiDvQ71WBiJl9yN4hscveEed1XRfH
 3bQw==
X-Gm-Message-State: AOJu0Yxc1gJNz0Aav2ZukP9H9wjtuRwc8auh9176q9JowG6OqPtZRqWp
 Qj/GcsJFTsjKIlBS13KxsN7PhpKGm8oQOMjIz+HyKrNqg2wWLA0coUkaAABhbZIB6C6cu1KD/Zd
 6j0iUftMzzRacb14YMiXT1j3i/UNLp8PRyLlz1BK1NX6/6I3S1qm7xqBZ1hkGVB92TvuERLEupv
 6pJe6URwoaopjn1Y/f2MrJRPNdfF3/Z95G9F/5mtI=
X-Received: by 2002:a5d:6601:0:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-380610f46damr5492284f8f.8.1730125774478; 
 Mon, 28 Oct 2024 07:29:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFKUYVGINL2dL/+EOnF5+vn/FkO6XMhUs64Lyd8XVAL7bTDxARMvc8xnRMtHrsGuqYp6M/Aw==
X-Received: by 2002:a5d:6601:0:b0:37d:33ab:de30 with SMTP id
 ffacd0b85a97d-380610f46damr5492269f8f.8.1730125773946; 
 Mon, 28 Oct 2024 07:29:33 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47952sm9551978f8f.48.2024.10.28.07.29.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/24] rust, x86, misc patches for 2024-10-28
Date: Mon, 28 Oct 2024 15:29:07 +0100
Message-ID: <20241028142932.363687-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit e67b7aef7c7f67ecd0282e903e0daff806d5d680:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2024-10-24 11:23:46 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream-v2

for you to fetch changes up to 3f9f26be71ba39e606ad90f6fc2f56d5bf336b5a:

  MAINTAINERS: Add myself as a reviewer of x86 general architecture support (2024-10-28 11:56:17 +0100)

----------------------------------------------------------------
* target/i386: fixes for -cpu pentium3
* qdev: allow making Properties arrays const
* sockets: Remove dead code
* configure: Fix typo
* stubs: avoid duplicate symbols in libqemuutil.a
* remove erroneous file that breaks git clone on Windows
* rust: cleanups, integration tests, enable rust in the Fedora system build job
* configure: detect 64-bit MIPS for Meson and rustc
* configure: deprecate 32-bit MIPS
* add Zhao Liu as x86 reviewer

----------------------------------------------------------------
Daniel P. Berrangé (2):
      tests: add 'rust' and 'bindgen' to CI package list
      ci: enable rust in the Fedora system build job

Manos Pitsidianakis (2):
      Revert "rust: add PL011 device model"
      rust: add PL011 device model

Paolo Bonzini (18):
      stubs: avoid duplicate symbols in libqemuutil.a
      target/i386: fix CPUID check for LFENCE and SFENCE
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
      configure: detect 64-bit MIPS
      configure, meson: deprecate 32-bit MIPS

Pierrick Bouvier (1):
      scripts: remove erroneous file that breaks git clone on Windows

Zhao Liu (1):
      MAINTAINERS: Add myself as a reviewer of x86 general architecture support

 MAINTAINERS                                        |  1 +
 docs/about/build-platforms.rst                     |  2 +-
 docs/about/deprecated.rst                          | 12 ++-
 configure                                          | 10 ++-
 meson.build                                        | 43 ++++++++---
 include/hw/qdev-core.h                             |  4 +-
 include/hw/qdev-properties.h                       |  4 +-
 hw/core/qdev-properties.c                          | 26 +++----
 system/qdev-monitor.c                              |  2 +-
 target/i386/tcg/decode-new.c.inc                   |  4 +-
 .gitlab-ci.d/buildtest.yml                         |  2 +-
 .gitlab-ci.d/cirrus/freebsd-14.vars                |  2 +-
 .gitlab-ci.d/cirrus/macos-14.vars                  |  2 +-
 .gitlab-ci.d/cirrus/macos-15.vars                  |  2 +-
 rust/hw/char/Kconfig                               |  1 -
 rust/hw/char/pl011/src/device.rs                   |  6 +-
 rust/hw/char/pl011/src/device_class.rs             |  6 +-
 rust/hw/char/pl011/src/memory_ops.rs               | 10 +--
 rust/qemu-api-macros/meson.build                   |  2 +-
 rust/qemu-api-macros/src/lib.rs                    | 30 ++------
 rust/qemu-api/meson.build                          | 29 +++++++-
 rust/qemu-api/src/definitions.rs                   | 66 ++++++++---------
 rust/qemu-api/src/device_class.rs                  | 85 ++++++----------------
 rust/qemu-api/src/lib.rs                           |  4 +-
 rust/qemu-api/src/tests.rs                         | 49 -------------
 rust/qemu-api/src/zeroable.rs                      | 23 ++++++
 rust/qemu-api/tests/tests.rs                       | 78 ++++++++++++++++++++
 scripts/ci/setup/ubuntu/ubuntu-2204-aarch64.yaml   |  2 +
 scripts/ci/setup/ubuntu/ubuntu-2204-s390x.yaml     |  2 +
 scripts/meson-buildoptions.                        |  0
 stubs/meson.build                                  |  7 +-
 tests/docker/dockerfiles/alpine.docker             |  2 +
 tests/docker/dockerfiles/centos9.docker            |  2 +
 tests/docker/dockerfiles/debian-amd64-cross.docker |  3 +
 tests/docker/dockerfiles/debian-arm64-cross.docker |  3 +
 tests/docker/dockerfiles/debian-armhf-cross.docker |  3 +
 tests/docker/dockerfiles/debian-i686-cross.docker  |  3 +
 .../dockerfiles/debian-mips64el-cross.docker       |  3 +
 .../docker/dockerfiles/debian-mipsel-cross.docker  |  3 +
 .../docker/dockerfiles/debian-ppc64el-cross.docker |  3 +
 tests/docker/dockerfiles/debian-s390x-cross.docker |  3 +
 tests/docker/dockerfiles/debian.docker             |  2 +
 .../docker/dockerfiles/fedora-rust-nightly.docker  |  2 +
 tests/docker/dockerfiles/fedora-win64-cross.docker |  2 +
 tests/docker/dockerfiles/fedora.docker             |  2 +
 tests/docker/dockerfiles/opensuse-leap.docker      |  2 +
 tests/docker/dockerfiles/ubuntu2204.docker         |  2 +
 tests/lcitool/projects/qemu.yml                    |  2 +
 tests/vm/generated/freebsd.json                    |  2 +
 49 files changed, 319 insertions(+), 241 deletions(-)
 delete mode 100644 rust/qemu-api/src/tests.rs
 create mode 100644 rust/qemu-api/src/zeroable.rs
 create mode 100644 rust/qemu-api/tests/tests.rs
 delete mode 100644 scripts/meson-buildoptions.
-- 
2.47.0


