Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9D1C61CE8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 12:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNWHp-0002Pq-Vj; Fri, 06 Jun 2025 08:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHn-0002PX-46
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uNWHg-0005a3-Cy
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 08:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749213293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GFT03fcVdCBPNH84iXV0ut6Ea/ANt9t4v0l5zOU9j1A=;
 b=Q00GeohBujVm69T3piqfJ2QAj/KnJuDH90J7FMlu68hE3sP2INBplxd/1HWBL8/Ywl81qB
 c7HAqzompIMHd5nvaLlAG2//tWd8STiH128+1SJMSARe5TZRpQjqPHXZnhQbT43vJaJ86D
 TTM4it7nVvO/cdhT+D7hfb0p13NNbxY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-cf15VCUiMBGbgZL-ZCid_Q-1; Fri, 06 Jun 2025 08:34:52 -0400
X-MC-Unique: cf15VCUiMBGbgZL-ZCid_Q-1
X-Mimecast-MFC-AGG-ID: cf15VCUiMBGbgZL-ZCid_Q_1749213291
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43eea5a5d80so11361945e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 05:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749213290; x=1749818090;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GFT03fcVdCBPNH84iXV0ut6Ea/ANt9t4v0l5zOU9j1A=;
 b=axhQeoLqyoRUe2E3tH9UU9SZxyyvBRtXPDdbeJep+R6dI3Pis1XPPN/2BsIsOvqesD
 Dqq6yqRQnZVPQVKtxj+azjopSP0XROOOioyDw7Qe1aHf0txS6AfgAO5WWibc6HbbLXZL
 QkuJ4ojo7056b+zzCVDIkkMEC9vi3OA3uDMJhwVZdegXmwPJ/4ITJUfmr9wRwrX0nXsZ
 hD9+ryrv+tOo/X08nPg/OWEimQfy8DUruHwqEfIOpGb8ImJsYbtAYqTlVUO2soklpdWe
 Ls3VFuif7G6/OEI/6jJ/wtueXhLubeRJspElzrC+1uaPFtjLCvJxFOFMAtsLHhp+JCAH
 I/Qg==
X-Gm-Message-State: AOJu0Yw07RROK7gblUI9Q85WG+azL7ZzlQUNU0N8qUciST4j+oppTyCG
 ajZOk8qTWDEkCCgtPwdCsqCbMJ/6rihWxhBqijm9OqlekCj/1Zu/2nyi5mhTKPfu0YUyvLsO0lT
 9Q40r+t0r5cok7M6AijERAZw3vuGlokBbdGzS8bVnZivWx2/oohqcbR6gh3X2gRrEldolQiCJSE
 GhSKQYrpkC9SwVmeXwBvKsFv60urmA0wAIjxEluR8q
X-Gm-Gg: ASbGncvQMHAskGaaioaWMcOvQJr5ZrTnpfvLVKLXL2oMH2X58WMBvw3qpEz4OOccCQn
 3wJKsjeGJ0n07VKuYK4ppFFIeEQ8bxTWcpRwe3dZb+RS30kh7Q/mTnWSl/BVDrAQv8WWS0Q8CIB
 SQsfK3DASak411RkytyBzacslqwGZJjIPbGgU3k6HZYBqXa3n2CMCiSewMuRKunpE36copKQFMJ
 AM7+8lK69ahLruahKnkocGKqAX7BzkltT4SD2Yo3KVUC9MBQVGHpN4Si9FtXGLkAL9FQMpEfTdP
 +XDHX96lAOc6GjDBnmOelDGO
X-Received: by 2002:a05:600c:1c99:b0:44a:b793:9e4f with SMTP id
 5b1f17b1804b1-4520143724fmr28490745e9.19.1749213290248; 
 Fri, 06 Jun 2025 05:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMYizOQEw61QO/2MSSdQ3fgfaBp/WY9/Q/RXGc0Ghoq0oWJn2sgRwTt6QTcarIo6ZgFH2m3w==
X-Received: by 2002:a05:600c:1c99:b0:44a:b793:9e4f with SMTP id
 5b1f17b1804b1-4520143724fmr28490455e9.19.1749213289618; 
 Fri, 06 Jun 2025 05:34:49 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209ce0b97sm22704255e9.9.2025.06.06.05.34.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:34:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/31] Threading, Rust, i386 changes for 2025-06-06
Date: Fri,  6 Jun 2025 14:34:14 +0200
Message-ID: <20250606123447.538131-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit f8a113701dd2d28f3bedb216e59125ddcb77fd05:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2025-06-04 11:43:31 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 3f9bdfb0dc8162cbc080c868625336178ddcda56:

  tests/tcg/x86_64/fma: add test for exact-denormal output (2025-06-06 14:32:55 +0200)

----------------------------------------------------------------
* futex: support Windows
* qemu-thread: Avoid futex abstraction for non-Linux
* migration, hw/display/apple-gfx: replace QemuSemaphore with QemuEvent
* rust: bindings for Error
* hpet, rust/hpet: return errors from realize if properties are incorrect
* rust/hpet: Drop BqlCell wrapper for num_timers
* target/i386: Emulate ftz and denormal flag bits correctly
* i386/kvm: Prefault memory on page state change

----------------------------------------------------------------
Akihiko Odaki (11):
      futex: Check value after qemu_futex_wait()
      futex: Support Windows
      qemu-thread: Replace __linux__ with CONFIG_LINUX
      qemu-thread: Avoid futex abstraction for non-Linux
      qemu-thread: Use futex for QemuEvent on Windows
      qemu-thread: Use futex if available for QemuLockCnt
      qemu-thread: Document QemuEvent
      migration: Replace QemuSemaphore with QemuEvent
      migration/colo: Replace QemuSemaphore with QemuEvent
      migration/postcopy: Replace QemuSemaphore with QemuEvent
      hw/display/apple-gfx: Replace QemuSemaphore with QemuEvent

Paolo Bonzini (14):
      subprojects: add the anyhow crate
      subprojects: add the foreign crate
      util/error: expose Error definition to Rust code
      util/error: allow non-NUL-terminated err->src
      util/error: make func optional
      rust: qemu-api: add bindings to Error
      rust: qemu-api: add tests for Error bindings
      rust: qdev: support returning errors from realize
      rust/hpet: change type of num_timers to usize
      hpet: adjust VMState for consistency with Rust version
      hpet: return errors from realize if properties are incorrect
      rust/hpet: return errors from realize if properties are incorrect
      docs: update Rust module status
      rust: make TryFrom macro more resilient

Peter Maydell (4):
      target/i386: Detect flush-to-zero after rounding
      target/i386: Use correct type for get_float_exception_flags() values
      target/i386: Wire up MXCSR.DE and FPUS.DE correctly
      tests/tcg/x86_64/fma: add test for exact-denormal output

Tom Lendacky (1):
      i386/kvm: Prefault memory on page state change

Zhao Liu (1):
      rust/hpet: Drop BqlCell wrapper for num_timers

 docs/devel/rust.rst                                |   7 +-
 meson.build                                        |   7 +
 include/qapi/error-internal.h                      |  35 ++
 include/qemu/futex.h                               |  44 ++-
 include/qemu/lockcnt.h                             |   2 +-
 include/qemu/thread-posix.h                        |   9 -
 include/qemu/thread-win32.h                        |   6 -
 include/qemu/thread.h                              |  21 +-
 include/system/kvm.h                               |   1 +
 migration/migration.h                              |  12 +-
 rust/wrapper.h                                     |   1 +
 target/i386/ops_sse.h                              |  16 +-
 accel/kvm/kvm-all.c                                |   2 +
 hw/timer/hpet.c                                    |  21 +-
 migration/colo.c                                   |  20 +-
 migration/migration.c                              |  21 +-
 migration/postcopy-ram.c                           |  10 +-
 migration/savevm.c                                 |   2 +-
 target/i386/kvm/kvm.c                              |  31 +-
 target/i386/tcg/fpu_helper.c                       | 101 +++--
 tests/tcg/x86_64/fma.c                             |  17 +-
 tests/unit/test-aio-multithread.c                  |   6 +-
 util/error.c                                       |  20 +-
 util/event.c                                       | 171 +++++++++
 util/lockcnt.c                                     |   9 +-
 util/qemu-thread-posix.c                           | 148 --------
 util/qemu-thread-win32.c                           | 129 -------
 hw/display/apple-gfx.m                             |  10 +-
 rust/Cargo.lock                                    |  17 +
 rust/Cargo.toml                                    |   1 +
 rust/hw/char/pl011/src/device.rs                   |   5 +-
 rust/hw/timer/hpet/src/device.rs                   |  62 ++-
 rust/hw/timer/hpet/src/fw_cfg.rs                   |   7 +-
 rust/meson.build                                   |   4 +
 rust/qemu-api-macros/src/lib.rs                    |   7 +-
 rust/qemu-api/Cargo.toml                           |   2 +
 rust/qemu-api/meson.build                          |   3 +-
 rust/qemu-api/src/error.rs                         | 416 +++++++++++++++++++++
 rust/qemu-api/src/lib.rs                           |   3 +
 rust/qemu-api/src/qdev.rs                          |  12 +-
 scripts/archive-source.sh                          |   5 +-
 scripts/make-release                               |   5 +-
 subprojects/.gitignore                             |   2 +
 subprojects/anyhow-1-rs.wrap                       |   7 +
 subprojects/foreign-0.3-rs.wrap                    |   7 +
 subprojects/packagefiles/anyhow-1-rs/meson.build   |  33 ++
 .../packagefiles/foreign-0.3-rs/meson.build        |  26 ++
 util/meson.build                                   |   3 +-
 48 files changed, 1018 insertions(+), 488 deletions(-)
 create mode 100644 include/qapi/error-internal.h
 create mode 100644 util/event.c
 create mode 100644 rust/qemu-api/src/error.rs
 create mode 100644 subprojects/anyhow-1-rs.wrap
 create mode 100644 subprojects/foreign-0.3-rs.wrap
 create mode 100644 subprojects/packagefiles/anyhow-1-rs/meson.build
 create mode 100644 subprojects/packagefiles/foreign-0.3-rs/meson.build
-- 
2.49.0


