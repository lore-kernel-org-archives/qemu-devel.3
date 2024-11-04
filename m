Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9F2D1BDD2
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 17:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t80rh-00051T-1q; Mon, 04 Nov 2024 12:27:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rc-0004w0-17
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t80rU-00004t-13
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 12:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730741249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ofw5lZQCJqe6de3bYM2n2T4sLA9jsMkqsZYUFh5JqWc=;
 b=KRppUCa1S8RCRMIeier2UDw+xFHtODgvX23vGBZqwvPsRbDtmHX8r3sgw2opkitqqmd/9M
 M6l3mtU9Ozg0blNmBRppbJ8rRSFsAd/0llB4idq1oZI9MKzG2lidcWSmIZzXoHQnHKJ42b
 IOJcTMe56iLyDCd18q3MLi3YhysBIjY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-bsiHdGdsOQmWMZ7SIOv2ZQ-1; Mon, 04 Nov 2024 12:27:25 -0500
X-MC-Unique: bsiHdGdsOQmWMZ7SIOv2ZQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-431673032e6so26945425e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 09:27:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730741243; x=1731346043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ofw5lZQCJqe6de3bYM2n2T4sLA9jsMkqsZYUFh5JqWc=;
 b=Xk+eqqWLjw5s6AsfvojZslbNnlHRPLZoE4OJidJG62hCFMLJRsb3FG30D1wzQOaLSF
 qWVmj9NZ4xtNF+UjgbavVy6RNxmHJ7a/llt09IRSAE8k+HrZsre2iiNm7Slppvi9s0f2
 eJfj3k5ngAoaz3P7cepx34ZY8mq+Ka0MmjpXjpM/Y55DUbu94KByVl9LsQZ8bCj3NUuz
 K8CUqfBnmXfdOx0phq49VHrflo/qaq25c/OBtYaOYdadRxA++kHAMAWa8lc9DPFTkxXk
 fYPxGyS1a0AbyhmHlffbesnfQ6/G+Ti7eUZa4dk9mLtwrlluHLZwCygVzZvgEFbPpiwc
 0V4g==
X-Gm-Message-State: AOJu0YzNmJ2m+5668XKmA59WB0D3Ayvat8tLSj4CTeKxhHKSUopuc+NP
 p5pmjLoDXpwxEdG4gQEkvOGdPFfOxmHsnCoA4k26VYDKiy2Tu5mqSZv5VEPk9vHFKH29kkQQnvn
 Jmcd6+cV5uvtvBcbbfBglTlJgf8SjxsrqnUfbvvX7brylzk9pSrVhaG9hZ+0lvqvJaXH79c0VI/
 ZWzWvgEWqQO6nl/8iP/J8WoFSO4qHFLkTGzZOktt0=
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id
 5b1f17b1804b1-431bb9d1122mr200674645e9.26.1730741243303; 
 Mon, 04 Nov 2024 09:27:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpm0KkSRFnky4Ce49/E07LZHFkMgexgqnevE+hS1AWfaU3ShgV0hsIptVhsSyZIVgMS3QjKA==
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id
 5b1f17b1804b1-431bb9d1122mr200674235e9.26.1730741242785; 
 Mon, 04 Nov 2024 09:27:22 -0800 (PST)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ac387sm164505185e9.1.2024.11.04.09.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:27:22 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 00/40] Rust changes for QEMU 9.2 soft freeze
Date: Mon,  4 Nov 2024 18:26:39 +0100
Message-ID: <20241104172721.180255-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

The following changes since commit 15195de6a93438be99fdf9a90992c4228527130d:

  ci: enable rust in the Fedora system build job (2024-10-30 16:30:56 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream-rust

for you to fetch changes up to d20feaa9a5af597bd20630d041e5dc7808612be1:

  ci: enable rust in the Debian and Ubuntu system build job (2024-10-31 18:39:52 +0100)

----------------------------------------------------------------
* rust: cleanups
* rust: integration tests
* rust/pl011: add support for migration
* rust/pl011: add TYPE_PL011_LUMINARY device
* rust: add support for older compilers and bindgen
* rust: enable rust in the Debian, Fedora and Ubuntu system build job

----------------------------------------------------------------

This pull request enables Rust in QEMU's CI infrastructure, as a
first step towards collaborative development of Rust features. It matches
the plan that I mentioned last Thursday at
https://lore.kernel.org/qemu-devel/CABgObfb7=ZxgiasgB=dE8yV+bhd5-pd51n4qGpP8OFNBS3iMXQ@mail.gmail.com/.

There is a lot of new code in here that is specifically from me.  Because of
the worry that new Rust code may introduce hidden technical debt, others have
reviewed all the Rust code in here, with the exception of the mostly trivial
https://lore.kernel.org/qemu-devel/20241025160209.194307-17-pbonzini@redhat.com/.

The changes focus on CI integration and compilation infrastructure:

* support for older Rust versions as found in QEMU's Debian bookworm and
  Ubuntu CI targets.  Workarounds for older Rust compiler versions are grouped
  together for future cleanup.

* passing qtests with --enable-rust testing support: the pl011 code is closer
  to parity with the C version, though still experimental.

Regarding toolchain compatibility: Michael Tokarev expressed some
doubts about supporting the old toolchain in Debian bookworm.  However,
even trixie (currently in "testing") would require workarounds, mostly
due to lack of stable "offset_of!"  support, so maintaining bookworm
compatibility seemed reasonable.

I am also working on a documentation patch that explains the more recent
features that would be nice to have.

Note that the Rust code still contains what is technically undefined
behavior (also known as "unsound code", i.e. unsafe code that does not
respect aliasing rules). Fixing this and other aspects will be easier
with the CI infrastructure in place. For example bindings, static checking
and improved developer ergonomics (e.g., clippy and rustfmt integration),
documentation generation would all be valid starting points.

For developers testing locally with --enable-rust, run "meson subprojects
update --reset" after pulling and before building.  Meson does not do this
step automatically due to it being potentially destructive.  This should
only affect this initial stabilization period, but a fix is in progress
(I first need to check with the Meson folks whether my script is using
stable interfaces).

Paolo

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

Paolo Bonzini (30):
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
      ci: enable rust in the Debian and Ubuntu system build job


 docs/about/build-platforms.rst                     |  12 +
 meson.build                                        | 135 +++++---
 include/hw/qdev-core.h                             |   4 +-
 include/hw/qdev-properties.h                       |   4 +-
 rust/wrapper.h                                     |  17 +
 hw/core/qdev-properties.c                          |  26 +-
 system/qdev-monitor.c                              |   2 +-
 .gitattributes                                     |   2 +
 .gitlab-ci.d/buildtest.yml                         |   6 +-
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
 45 files changed, 1379 insertions(+), 416 deletions(-)
-- 
2.47.0


