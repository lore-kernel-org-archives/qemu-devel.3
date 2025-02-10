Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9717AC0219B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 16:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thWSB-0006nj-Jf; Mon, 10 Feb 2025 11:16:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR3-00049G-Bx
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:04 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1thWR0-0001Ur-Rw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 11:15:00 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5de5bf41652so4051498a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 08:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739204097; x=1739808897; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1RFUaUw8AmOoBrTLJ033QBHmmzDR19jzUEOy29awR64=;
 b=y7hQ78LRPlm5P0W1JfDhrsSa24KgX6HukgSqoaGN2a10pJ2mOo0/JES3XPt7sl8fJD
 EQcOdwyjA/rVFBaljMG8j0cehjK4IOFE+r7mzTFLJpC3iHZSgbppYlpxLdBPx2KpaeRu
 9m2oymhAE60Ym4/57ZChEsyZBxVIIYwRzMOrFH6QuLBcBVdYw9TyW0njEJrC4A8jqW9O
 bWJAaQBleyMBwRRgsvEcW2iI4rU/TWb+Bpaw3EKHrWj6GxJTzftG3y/S0lAyIumOQdAG
 5e09JFCjr+92j5+5sDdzTrZknICDPN+OCTiTDqEc7tvQ8eqjzjvC99uOte0+vYS1Ne/+
 d4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739204097; x=1739808897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RFUaUw8AmOoBrTLJ033QBHmmzDR19jzUEOy29awR64=;
 b=aKUKFnUOpCxgyATBjuw2M87/EYJZyvuDs9jxjf/zb1BYw6VJs7f4ZMVV3G55apNEIW
 I8NkoGMDw5pB8VRhKhikqeehRfD5LnMqLpILpPx0lcVlMPAAbTU+r7qNmNOhbRd02Mhh
 1rY187TJIWj9iAKyuv+/RwH09JRg/wjnnlvcM4WHZnpW310WrzKkWB6ZXU1biPRQFMkv
 rUi83uG4tIIPI5qs9xqYhmZZpfJsk1OZOKhA27RCLblhbynb29w2yKxNBjJIaDRhWD9P
 GNQCw4dsYlCyK9hSHmpJTA4o/1BD7vr2tOFnh1SXkgwZZr1eSWEk29NRdEFMoE7buGjV
 kajA==
X-Gm-Message-State: AOJu0Ywey/DaAuld4BO6XrU4ni8tUrnjIrbmlpF1sGkMhbpTGDVh9XHD
 bVH0Ft0d+BxhvSm7+FM6B2Vgif2wGwvz258NvwDDu2HPMt26Obh/lXNWSiduyZnezkxV+fo1mzT
 /y+g=
X-Gm-Gg: ASbGncsEb7fv5bIlUp2JL3cUahtfi2OpH8tb8dw8yPh6qODqH7VXAayCK2eOmARhM7j
 PHtH0bSoK4KyGQCGJ+hnTVZyaKOWKfCRNu0WKmHp3fDRhPNQtonTJE5i8I7/uiucap0t1Drd0P5
 yPq3NHTHpRD3FApyn3sXAm7kBxef5cKlbvViv5Gx/frd9gtYdTO/tausI6yA2TyMu5ds/0fYZl0
 zdEC9Nx2KztMPgDv+EPXfrCqflpOsxYd6AyaHw4xmKVYJbaHUt8rM8gUD31XH6IOqVHZvyBlzuP
 T3CcF8qBgkC6yh26ew==
X-Google-Smtp-Source: AGHT+IF77MokyEFbpnSHKwFEo1MhEy8jF1Yslehqh/Mozf5TZgdkvuUvnUaFnQBOJqGvBZTIHkEakw==
X-Received: by 2002:a05:6402:13c8:b0:5dc:cc02:5d25 with SMTP id
 4fb4d7f45d1cf-5de45002faamr13195735a12.11.1739204097080; 
 Mon, 10 Feb 2025 08:14:57 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dcf1b7adf4sm8147447a12.26.2025.02.10.08.14.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 08:14:53 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CA4695F8CF;
 Mon, 10 Feb 2025 16:14:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 00/17] testing and gdbstub updates
Date: Mon, 10 Feb 2025 16:14:34 +0000
Message-Id: <20250210161451.3273284-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit 04d3d0e9f54d4c42759f3810aa135ce314d98dc4:

  Merge tag 'hppa-system-for-v10-diva-artist-pull-request' of https://github.com/hdeller/qemu-hppa into staging (2025-02-08 09:00:57 -0500)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-10.0-testing-and-gdstub-updates-100225-1

for you to fetch changes up to 24c61663dcec0e87bb4206a7623f0e222e188b47:

  tests/tcg: Add late gdbstub attach test (2025-02-10 13:47:59 +0000)

----------------------------------------------------------------
testing and gdbstub updates:

  - add a check-rust test to docker builds
  - re-factor the qtest logic to be cleaner
  - fix tests to not clock_step when no timers enabled
  - roll-up log prefix into qtest_send
  - cleaner error reporting when qtest_clock_set fails
  - revert old deadlock fix now tests are updated
  - only run full set of migration tests under HW acceleration
  - support late attachment to user-mode gdbstubs

----------------------------------------------------------------
Alex Bennée (7):
      tests/docker: replicate the check-rust-tools-nightly CI job
      tests/qtest: don't attempt to clock_step while waiting for virtio ISR
      tests/qtest: don't step clock at start of npcm7xx periodic IRQ test
      tests/qtest: simplify qtest_process_inbuf
      tests/qtest: rename qtest_send_prefix and roll-up into qtest_send
      tests/qtest: tighten up the checks on clock_step
      Revert "util/timer: avoid deadlock when shutting down"

Fabiano Rosas (2):
      tests/qtest/migration: Add --full option
      tests/qtest/migration: Pick smoke tests

Ilya Leoshkevich (8):
      gdbstub: Allow the %d placeholder in the socket path
      gdbstub: Try unlinking the unix socket before binding
      user: Introduce user/signal.h
      user: Introduce host_interrupt_signal
      osdep: Introduce qemu_kill_thread()
      gdbstub: Allow late attachment
      docs/user: Document the %d placeholder and suspend=n QEMU_GDB features
      tests/tcg: Add late gdbstub attach test

 MAINTAINERS                                |   1 +
 docs/user/main.rst                         |  16 ++-
 bsd-user/signal-common.h                   |   1 -
 include/qemu/osdep.h                       |   9 ++
 include/system/qtest.h                     |   1 -
 include/user/signal.h                      |  25 +++++
 linux-user/signal-common.h                 |   1 -
 tests/qtest/migration/framework.h          |   1 +
 bsd-user/main.c                            |   1 -
 bsd-user/signal.c                          |  13 +++
 gdbstub/user.c                             | 150 ++++++++++++++++++++++-------
 hw/ppc/spapr_rtas.c                        |   1 -
 hw/riscv/riscv_hart.c                      |   1 -
 linux-user/main.c                          |   1 -
 linux-user/signal.c                        |  26 ++++-
 linux-user/syscall.c                       |   1 +
 stubs/monitor-fd.c                         |   9 ++
 system/qtest.c                             |  59 +++++-------
 tests/qtest/libqos/virtio-pci-modern.c     |   6 +-
 tests/qtest/libqos/virtio-pci.c            |   6 +-
 tests/qtest/migration-test.c               |  25 +++++
 tests/qtest/migration/compression-tests.c  |  15 ++-
 tests/qtest/migration/cpr-tests.c          |   6 ++
 tests/qtest/migration/file-tests.c         |  19 +++-
 tests/qtest/migration/misc-tests.c         |  16 ++-
 tests/qtest/migration/postcopy-tests.c     |  14 ++-
 tests/qtest/migration/precopy-tests.c      |  23 +++--
 tests/qtest/migration/tls-tests.c          |  14 ++-
 tests/qtest/npcm7xx_timer-test.c           |   1 -
 tests/tcg/multiarch/late-attach.c          |  41 ++++++++
 util/oslib-posix.c                         |  15 +++
 util/qemu-timer.c                          |  16 +--
 stubs/meson.build                          |   2 +
 tests/docker/Makefile.include              |   3 +
 tests/docker/test-rust                     |  21 ++++
 tests/guest-debug/run-test.py              |  15 ++-
 tests/qtest/meson.build                    |  11 ++-
 tests/tcg/multiarch/Makefile.target        |   9 +-
 tests/tcg/multiarch/gdbstub/late-attach.py |  28 ++++++
 util/meson.build                           |   2 +
 40 files changed, 490 insertions(+), 135 deletions(-)
 create mode 100644 include/user/signal.h
 create mode 100644 stubs/monitor-fd.c
 create mode 100644 tests/tcg/multiarch/late-attach.c
 create mode 100755 tests/docker/test-rust
 create mode 100644 tests/tcg/multiarch/gdbstub/late-attach.py

-- 
2.39.5


